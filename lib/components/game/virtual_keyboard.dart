import 'package:aval1pmob/components/game/keyboard_key.dart';
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
        final keyWidth = ((constraints.maxWidth - 60) / 10).clamp(28.0, 36.0);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: keyboardRows.map((rowKeys) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: rowKeys.map((character) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: SizedBox(
                      width: keyWidth,
                      height: 48,
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
          }).toList(),
        );
      },
    );
  }
}
