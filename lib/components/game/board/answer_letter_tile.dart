import 'package:flutter/material.dart';

class AnswerLetterTile extends StatelessWidget {
  final String character;
  final bool revealed;
  final bool structural;
  final double tileWidth;

  const AnswerLetterTile({
    super.key,
    required this.character,
    required this.revealed,
    required this.structural,
    this.tileWidth = 30,
  });

  @override
  Widget build(BuildContext context) {
    final height = tileWidth * 46 / 30;
    if (structural) {
      return Container(
        width: tileWidth,
        height: height,
        alignment: Alignment.center,
        child: Text(
          character,
          style: TextStyle(
            color: Colors.white70,
            fontSize: tileWidth * 26 / 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return Container(
      width: tileWidth,
      height: height,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white, width: 3)),
      ),
      child: Text(
        revealed ? character : '',
        style: TextStyle(
          color: Colors.white,
          fontSize: tileWidth * 28 / 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
