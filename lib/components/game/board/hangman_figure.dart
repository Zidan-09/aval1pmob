import 'package:flutter/material.dart';

class HangmanFigure extends StatelessWidget {
  final int errors;
  final double size;

  const HangmanFigure({super.key, required this.errors, this.size = 180});

  @override
  Widget build(BuildContext context) {
    final stage = errors.clamp(0, 6);
    return SizedBox(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'lib/assets/images/sonic/$stage.jpg',
          fit: BoxFit.cover,
          semanticLabel: 'Progresso da forca: $stage de 6 erros',
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(
                Icons.broken_image_outlined,
                color: Colors.white70,
                size: 48,
              ),
            );
          },
        ),
      ),
    );
  }
}
