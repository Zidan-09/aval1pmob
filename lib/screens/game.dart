import 'package:aval1pmob/entities/answer_category.dart';
import 'package:aval1pmob/entities/difficulty.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.amber,
        child: Center(
          child: Text("Hello World", style: TextStyle(
            color: Colors.white,
            fontSize: 25
          ),),
        ),
      ),
    );
  }
}