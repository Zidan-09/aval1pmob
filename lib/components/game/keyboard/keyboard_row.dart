import 'package:aval1pmob/components/game/keyboard/keyboard_key.dart';
import 'package:flutter/material.dart';

class KeyboardRow extends StatelessWidget {
  final List<String> rowKeys;
  final double? keyWidth;
  final double keyHeight;
  final Set<String> usedLetters;
  final bool enabled;
  final ValueChanged<String> onKeyPressed;
  final double spacing;

  const KeyboardRow({
    super.key,
    required this.rowKeys,
    required this.keyWidth,
    required this.keyHeight,
    required this.usedLetters,
    required this.enabled,
    required this.onKeyPressed,
    this.spacing = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: rowKeys.map((character) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: spacing / 2),
            child: SizedBox(
              width: keyWidth,
              height: keyHeight,
              child: KeyboardKey(
                character: character,
                active: enabled && !usedLetters.contains(character),
                onPressed: () => onKeyPressed(character),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
