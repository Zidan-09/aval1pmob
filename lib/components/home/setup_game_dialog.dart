import 'package:aval1pmob/entities/answer_category.dart';
import 'package:aval1pmob/entities/difficulty.dart';
import 'package:aval1pmob/services/word_challenge_repository.dart';
import 'package:flutter/material.dart';

class SetupGameDialog extends StatefulWidget {
  final WordChallengeRepository repository;
  final void Function(BuildContext, AnswerCategory, Difficulty) startGame;

  const SetupGameDialog({
    super.key,
    required this.repository,
    required this.startGame,
  });

  @override
  State<SetupGameDialog> createState() => _SetupGameDialogState();
}

class _SetupGameDialogState extends State<SetupGameDialog> {
  late final List<AnswerCategory> categories;
  late final List<Difficulty> difficulties;
  late AnswerCategory selectedCategory;
  late Difficulty selectedDifficulty;

  @override
  void initState() {
    super.initState();
    categories = widget.repository.loadCategories();
    difficulties = widget.repository.loadDifficulties();
    selectedCategory = categories.first;
    selectedDifficulty = difficulties.first;
  }

  @override
  Widget build(BuildContext context) {
    final remaining = widget.repository.remainingCount(
      selectedCategory,
      selectedDifficulty,
    );
    final canPlay = remaining > 0;

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
              children: categories.map((category) {
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
              children: difficulties.map((difficulty) {
                return ChoiceChip(
                  label: Text(difficulty.labelPt),
                  selected: selectedDifficulty == difficulty,
                  onSelected: (_) {
                    setState(() => selectedDifficulty = difficulty);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Text(
              'Seleção: ${selectedCategory.labelPt} • ${selectedDifficulty.labelPt}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              canPlay
                  ? (remaining == 1
                        ? 'Resta 1 palavra'
                        : 'Restam $remaining palavras')
                  : 'Todas as respostas dessa combinação já foram usadas.',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: canPlay
              ? () => widget.startGame(
                  context,
                  selectedCategory,
                  selectedDifficulty,
                )
              : null,
          child: const Text('Jogar'),
        ),
      ],
    );
  }
}
