import 'package:aval1pmob/entities/answer_category.dart';
import 'package:aval1pmob/entities/difficulty.dart';
import 'package:aval1pmob/screens/game.dart';
import 'package:aval1pmob/services/word_challenge_repository.dart';
import 'package:flutter/material.dart';

class SetupGameDialog extends StatefulWidget {
  final WordChallengeRepository repository;

  const SetupGameDialog({super.key, required this.repository});

  @override
  State<SetupGameDialog> createState() => _SetupGameDialogState();
}

class _SetupGameDialogState extends State<SetupGameDialog> {
  AnswerCategory selectedCategory = AnswerCategory.animals;
  Difficulty selectedDifficulty = Difficulty.easy;

  void _startGame() {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => GameScreen(
          repository: widget.repository,
          category: selectedCategory,
          difficulty: selectedDifficulty,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nova partida'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Categoria'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: AnswerCategory.values.map((category) {
                return ChoiceChip(
                  label: Text(category.labelPt),
                  selected: selectedCategory == category,
                  onSelected: (_) {
                    setState(() => selectedCategory = category);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text('Dificuldade'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: Difficulty.values.map((difficulty) {
                return ChoiceChip(
                  label: Text(difficulty.labelPt),
                  selected: selectedDifficulty == difficulty,
                  onSelected: (_) {
                    setState(() => selectedDifficulty = difficulty);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(onPressed: _startGame, child: const Text('Jogar')),
      ],
    );
  }
}
