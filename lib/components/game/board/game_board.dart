import 'package:aval1pmob/components/game/board/answer_display.dart';
import 'package:aval1pmob/components/game/board/hangman_figure.dart';
import 'package:aval1pmob/entities/game_round.dart';
import 'package:flutter/material.dart';

class GameBoard extends StatelessWidget {
  final GameRound round;

  const GameBoard({super.key, required this.round});

  @override
  Widget build(BuildContext context) {
    final figureSize = (MediaQuery.sizeOf(context).height * 0.32).clamp(
      180.0,
      320.0,
    );
    return Expanded(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HangmanFigure(errors: round.errors, size: figureSize),
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
    );
  }
}
