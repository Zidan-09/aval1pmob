import 'package:aval1pmob/entities/game_round.dart';
import 'package:flutter/material.dart';

class AnswerDisplay extends StatelessWidget {
  final GameRound round;

  const AnswerDisplay({super.key, required this.round});

  @override
  Widget build(BuildContext context) {
    final answer = round.challenge.answer;
    final children = <Widget>[];
    for (var i = 0; i < answer.length; i++) {
      final original = answer[i];
      if (original == ' ') {
        children.add(const SizedBox(width: 20, height: 46));
        continue;
      }
      final revealed = round.isRevealed(i);
      final structural = round.isStructural(i);
      children.add(_LetterTile(
        character: revealed ? original : '_',
        revealed: revealed,
        structural: structural,
      ));
    }
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 6,
      runSpacing: 8,
      children: children,
    );
  }
}

class _LetterTile extends StatelessWidget {
  final String character;
  final bool revealed;
  final bool structural;

  const _LetterTile({
    required this.character,
    required this.revealed,
    required this.structural,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 46,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: structural
            ? null
            : const Border(
                bottom: BorderSide(color: Colors.white, width: 3),
              ),
      ),
      child: Text(
        character,
        style: TextStyle(
          color: structural ? Colors.white70 : Colors.white,
          fontSize: structural ? 26 : 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
