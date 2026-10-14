import 'package:flutter/material.dart';

class AnswerLetterTile extends StatelessWidget {
  final String character;
  final bool revealed;
  final bool structural;

  const AnswerLetterTile({
    super.key,
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
