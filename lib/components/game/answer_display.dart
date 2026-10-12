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
          _LetterTile(
            character: round.displayCharAt(index),
            revealed: round.isRevealed(index),
            structural: round.isStructural(index),
          ),
        );
        index++;
      }
      rows.add(Wrap(spacing: 6, runSpacing: 8, children: tiles));
      index++; // pula o espaço entre palavras
    }
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 20,
      runSpacing: 12,
      children: rows,
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
    if (structural) {
      return Container(
        width: 30,
        height: 46,
        alignment: Alignment.center,
        child: Text(
          character,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return Container(
      width: 30,
      height: 46,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white, width: 3)),
      ),
      child: Text(
        revealed ? character : '',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
