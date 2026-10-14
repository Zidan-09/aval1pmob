import 'package:aval1pmob/components/game/game_info_card.dart';
import 'package:aval1pmob/components/game/game_labeled_card.dart';
import 'package:flutter/material.dart';

class GameTopBarSlot extends StatelessWidget {
  final String title;
  final String label;

  const GameTopBarSlot({super.key, required this.title, required this.label});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 130),
        child: GameLabeledCard(
          title: title,
          child: GameInfoCard(label: label),
        ),
      ),
    );
  }
}
