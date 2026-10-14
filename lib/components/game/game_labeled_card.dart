import 'package:flutter/material.dart';

class GameLabeledCard extends StatelessWidget {
  final String title;
  final Widget child;

  const GameLabeledCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        child,
      ],
    );
  }
}
