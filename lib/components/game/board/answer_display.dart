import 'package:aval1pmob/components/game/board/answer_letter_tile.dart';
import 'package:aval1pmob/entities/game_round.dart';
import 'package:flutter/material.dart';

class AnswerDisplay extends StatelessWidget {
  final GameRound round;

  const AnswerDisplay({super.key, required this.round});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final answer = round.challenge.answer;
        final maxWidth = constraints.maxWidth;
        final rows = <Widget>[];
        var index = 0;
        for (final word in answer.split(' ')) {
          final tiles = <Widget>[];
          for (var i = 0; i < word.length; i++) {
            if (i > 0) tiles.add(const SizedBox(width: 6));
            tiles.add(
              AnswerLetterTile(
                character: round.displayCharAt(index),
                revealed: round.isRevealed(index),
                structural: round.isStructural(index),
              ),
            );
            index++;
          }
          rows.add(
            SizedBox(
              width: maxWidth,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(mainAxisSize: MainAxisSize.min, children: tiles),
              ),
            ),
          );
          index++;
        }
        return Wrap(
          alignment: WrapAlignment.center,
          spacing: 20,
          runSpacing: 12,
          children: rows,
        );
      },
    );
  }
}
