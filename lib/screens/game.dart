import 'package:aval1pmob/components/game/answer_display.dart';
import 'package:aval1pmob/components/game/game_top_bar.dart';
import 'package:aval1pmob/components/game/hangman_figure.dart';
import 'package:aval1pmob/components/game/tips_container.dart';
import 'package:aval1pmob/components/game/virtual_keyboard.dart';
import 'package:aval1pmob/entities/answer_category.dart';
import 'package:aval1pmob/entities/difficulty.dart';
import 'package:aval1pmob/entities/game_round.dart';
import 'package:aval1pmob/entities/player_stats.dart';
import 'package:aval1pmob/services/word_challenge_repository.dart';
import 'package:flutter/material.dart';
import 'package:aval1pmob/components/game/round_result_dialog.dart';

class GameScreen extends StatefulWidget {
  static const String backgroundAsset = 'lib/assets/images/background2.png';

  final WordChallengeRepository repository;
  final PlayerStats playerStats;

  final AnswerCategory category;
  final Difficulty difficulty;

  const GameScreen({
    super.key,
    required this.repository,
    required this.playerStats,
    required this.category,
    required this.difficulty,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameRound round;
  bool hintUsed = false;
  bool countedEnd = false;

  @override
  void initState() {
    super.initState();
    round = GameRound(
      challenge: widget.repository.draw(widget.category, widget.difficulty),
    );
  }

  void onKeyPressed(String key) {
    final outcome = round.guess(key);
    if (outcome != GuessOutcome.hit && outcome != GuessOutcome.miss) return;
    setState(() {});
    _finishRoundIfNeeded();
  }

  void onHintUsed() {
    if (hintUsed) return;
    hintUsed = true;
    widget.playerStats.incrementTipsUseds();
  }

  void _finishRoundIfNeeded() {
    if (countedEnd || !round.isFinished) return;
    countedEnd = true;

    final stats = widget.playerStats;
    stats.incrementGames();
    if (round.won) {
      stats.incrementWins();
    } else {
      stats.incrementLoses();
      round.revealAll = true;
    }
    stats.addErrors(round.errors);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _showResult();
    });
  }

  void _showResult() {
    final won = round.won;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => RoundResultDialog(
        won: round.won,
        answer: round.challenge.answer,
        errors: round.errors,
        maxErrors: GameRound.maxErrors,
        hintUsed: hintUsed,
        selectionLabel:
            '${widget.category.labelPt} • ${widget.difficulty.labelPt}',
        onNewRound: () {
          Navigator.of(dialogContext).pop();
          _startNewRound();
        },
        onChangeSelection: () {
          Navigator.of(dialogContext).pop();
          Navigator.of(context)
              .pop(); // volta p/ Home, lá você reabre o SetupGameDialog
        },
        onGoHome: () {
          Navigator.of(dialogContext).pop();
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _startNewRound() {
    late final GameRound next;
    try {
      next = GameRound(
        challenge: widget.repository.draw(widget.category, widget.difficulty),
      );
    } on StateError {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Todas as respostas dessa combinação já foram usadas.'),
        ),
      );
      Navigator.of(context).pop();
      return;
    }
    setState(() {
      round = next;
      hintUsed = false;
      countedEnd = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(GameScreen.backgroundAsset),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: GameTopBar(
                    category: widget.category,
                    difficulty: widget.difficulty,
                    // TODO: implement menu behavior (session stats / back to home).
                    onMenuPressed: null,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          HangmanFigure(errors: round.errors),
                          const SizedBox(height: 8),
                          Text(
                            'Erros: ${round.errors}/${GameRound.maxErrors}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          AnswerDisplay(round: round),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: TipsContainer(
                    key: ValueKey(round.challenge.answer),
                    challenge: round.challenge,
                    onHintUsed: onHintUsed,
                  ),
                ),
                VirtualKeyboard(
                  usedLetters: round.guessedLetters,
                  enabled: !round.isFinished,
                  onKeyPressed: onKeyPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
