import 'package:aval1pmob/components/game/answer_display.dart';
import 'package:aval1pmob/components/game/game_top_bar.dart';
import 'package:aval1pmob/components/game/tips_container.dart';
import 'package:aval1pmob/components/game/virtual_keyboard.dart';
import 'package:aval1pmob/entities/answer_category.dart';
import 'package:aval1pmob/entities/difficulty.dart';
import 'package:aval1pmob/entities/game_round.dart';
import 'package:aval1pmob/entities/player_stats.dart';
import 'package:aval1pmob/services/word_challenge_repository.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
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
  late final GameRound round;

  @override
  void initState() {
    super.initState();
    round = GameRound(
      challenge: widget.repository.draw(widget.category, widget.difficulty),
    );
  }

  void onKeyPressed(String key) {
    final outcome = round.guess(key);
    if (outcome == GuessOutcome.hit || outcome == GuessOutcome.miss) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 154, 57, 57),
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
                      child: AnswerDisplay(round: round),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: TipsContainer(challenge: round.challenge),
                ),
                VirtualKeyboard(
                  usedLetters: round.guessedLetters,
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
