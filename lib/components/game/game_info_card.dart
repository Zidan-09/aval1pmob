import 'package:flutter/material.dart';

class GameInfoCard extends StatelessWidget {
  final String label;

  const GameInfoCard({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 788 / 317,
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/buttons/panel.png'),
            fit: BoxFit.fill,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
