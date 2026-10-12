import 'package:aval1pmob/components/game/game_top_bar.dart';
import 'package:aval1pmob/components/game/tips_container.dart';
import 'package:aval1pmob/components/game/virtual_keyboard.dart';
import 'package:aval1pmob/entities/answer_category.dart';
import 'package:aval1pmob/entities/difficulty.dart';
import 'package:aval1pmob/entities/player_stats.dart';
import 'package:aval1pmob/entities/word_challenge.dart';
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
  late final WordChallenge challenge;

  @override
  void initState() {
    super.initState();
    challenge = widget.repository.draw(widget.category, widget.difficulty);
  }

  void onKeyPressed(String key) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.amber,
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
                const Center(
                  child: Text(
                    "Hello World",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: TipsContainer(challenge: challenge),
                ),
                VirtualKeyboard(onKeyPressed: onKeyPressed),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
