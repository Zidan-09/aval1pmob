import 'package:aval1pmob/components/game/keyboard_row.dart';
import 'package:flutter/material.dart';

class VirtualKeyboard extends StatelessWidget {
  final ValueChanged<String> onKeyPressed;

  final Set<String> usedLetters;

  final bool enabled;

  const VirtualKeyboard({
    super.key,
    required this.onKeyPressed,
    this.usedLetters = const {},
    this.enabled = true,
  });

  static const List<List<String>> keyboardRows = [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
    ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 4.0;
        final maxLen = keyboardRows
            .map((row) => row.length)
            .reduce((a, b) => a > b ? a : b);
        final keyWidth =
            ((constraints.maxWidth - spacing * (maxLen + 1)) / maxLen).clamp(
              0.0,
              38.0,
            );
        final keyHeight = constraints.maxWidth < 350 ? 40.0 : 48.0;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: keyboardRows.map((rowKeys) {
            return KeyboardRow(
              rowKeys: rowKeys,
              keyWidth: keyWidth,
              keyHeight: keyHeight,
              usedLetters: usedLetters,
              enabled: enabled,
              onKeyPressed: onKeyPressed,
              spacing: spacing,
            );
          }).toList(),
        );
      },
    );
  }
}
