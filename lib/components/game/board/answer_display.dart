import 'package:aval1pmob/components/game/board/answer_letter_tile.dart';
import 'package:aval1pmob/entities/game_round.dart';
import 'package:flutter/material.dart';

class AnswerDisplay extends StatelessWidget {
  final GameRound round;

  const AnswerDisplay({super.key, required this.round});

  @override
  Widget build(BuildContext context) {
    final answer = round.challenge.answer;
    final rows = <Widget>[];
    var index = 0;
    for (final word in answer.split(' ')) {
      final tiles = <Widget>[];
      for (var i = 0; i < word.length; i++) {
        tiles.add(
          AnswerLetterTile(
            character: round.displayCharAt(index),
            revealed: round.isRevealed(index),
            structural: round.isStructural(index),
          ),
        );
        index++;
      }
      rows.add(Wrap(spacing: 6, runSpacing: 8, children: tiles));
      index++;
    }
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 20,
      runSpacing: 12,
      children: rows,
    );
  }
}
