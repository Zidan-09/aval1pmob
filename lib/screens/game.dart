import 'package:aval1pmob/components/game/game_top_bar.dart';
import 'package:aval1pmob/components/game/virtual_keyboard.dart';
import 'package:aval1pmob/entities/answer_category.dart';
import 'package:aval1pmob/entities/difficulty.dart';
import 'package:aval1pmob/entities/word_challenge.dart';
import 'package:aval1pmob/services/word_challenge_repository.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  final WordChallengeRepository repository;

  final AnswerCategory category;
  final Difficulty difficulty;

  const GameScreen({
    super.key,
    required this.repository, 
    required this.category, 
    required this.difficulty,
  });

  void onKeyPressed(String key) {
    
  }

  @override
  Widget build(BuildContext context) {
    final WordChallenge challenge = repository.draw(category, difficulty);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.amber,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: GameTopBar(
                  category: category,
                  difficulty: difficulty,
                  // TODO: implement menu behavior (session stats / back to home).
                  onMenuPressed: null,
                ),
              ),
              Center(
                child: Text("Hello World", style: TextStyle(
                  color: Colors.white,
                  fontSize: 25
                ),),
              ),
              VirtualKeyboard(onKeyPressed: onKeyPressed)
            ],
          ),
        ),
      ),
    );
  }
}
