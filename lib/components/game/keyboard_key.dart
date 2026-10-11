import 'package:flutter/material.dart';

class KeyboardKey extends StatelessWidget {
  final String character;
  final bool active;
  final VoidCallback onPressed;

  const KeyboardKey({super.key, required this.character, required this.active, required this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: active ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 90, 77, 83),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        disabledBackgroundColor: const Color.fromARGB(50, 90, 77, 83),
        disabledForegroundColor: Colors.transparent
      ),
      child: Text(character,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: active ? Colors.white : Colors.amber,
        ),
      )
    );
  }
}