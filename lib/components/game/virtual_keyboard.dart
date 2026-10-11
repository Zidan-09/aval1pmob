import 'package:aval1pmob/components/game/keyboard_key.dart';
import 'package:flutter/material.dart';

class VirtualKeyboard extends StatefulWidget {
  final ValueChanged<String> onKeyPressed;

  const VirtualKeyboard({
    super.key,
    required this.onKeyPressed,
  });

  @override
  State<StatefulWidget> createState() => _VirtualKeyboardState();
}

class _VirtualKeyboardState extends State<VirtualKeyboard> {
  static const List<List<String>> keyboardRows = [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
    ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
  ];

  final Set<String> pressedKeys = {};

  void handleKeyPressed(String character) {
    setState(() {
      pressedKeys.add(character);
    });

    widget.onKeyPressed(character);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: keyboardRows.map((rowKeys) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: rowKeys.map((character) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: SizedBox(
                  width: 36,
                  height: 48,
                  child: KeyboardKey(
                    character: character,
                    active: !pressedKeys.contains(character),
                    onPressed: () => handleKeyPressed(character),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}