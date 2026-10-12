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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: const Color.fromARGB(255, 43, 43, 54),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: const TextStyle(color: Colors.white70),
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
                final isSelected = selectedCategory == category;
                return ChoiceChip(
                  label: Text(category.labelPt),
                  selected: isSelected,
                  selectedColor: Colors.red,
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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
                final isSelected = selectedDifficulty == difficulty;
                return ChoiceChip(
                  label: Text(difficulty.labelPt),
                  selected: isSelected,
                  selectedColor: Colors.red,
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onSelected: (_) {
                    setState(() => selectedDifficulty = difficulty);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text('Seleção'),
            const SizedBox(height: 8),
            Text('${selectedCategory.labelPt} • ${selectedDifficulty.labelPt}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              canPlay
                  ? (remaining == 1
                        ? 'Resta 1 palavra'
                        : 'Restam $remaining palavras')
                  : 'Todas as respostas dessa combinação já foram usadas.',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
          ),
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
