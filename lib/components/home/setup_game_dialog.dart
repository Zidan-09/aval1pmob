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
      title: const Center(child: Text('Nova partida')),
      content: SizedBox(
        width: 350,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Categoria',
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 8,
                runSpacing: 8,
                children: categories.map((category) {
                  final isSelected = selectedCategory == category;
                  return ChoiceChip(
                    label: Text(category.labelPt),
                    selected: isSelected,
                    showCheckmark: false,
                    backgroundColor: const Color(0xFF3A3A46),
                    selectedColor: Colors.red,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                    ),
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: isSelected ? Colors.red : Colors.white24,
                      ),
                    ),
                    onSelected: (_) {
                      setState(() => selectedCategory = category);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                'Dificuldade',
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: difficulties.map((difficulty) {
                  final isSelected = selectedDifficulty == difficulty;
                  return ChoiceChip(
                    label: Text(difficulty.labelPt),
                    selected: isSelected,
                    showCheckmark: false,
                    backgroundColor: const Color(0xFF3A3A46),
                    selectedColor: Colors.red,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                    ),
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: isSelected ? Colors.red : Colors.white24,
                      ),
                    ),
                    onSelected: (_) {
                      setState(() => selectedDifficulty = difficulty);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                'Seleção',
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${selectedCategory.labelPt} • ${selectedDifficulty.labelPt}',
                      style: const TextStyle(
                        color: Colors.amber,
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
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(foregroundColor: Colors.white),
          child: const Text('CANCELAR'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            shape: const StadiumBorder(),
          ),
          onPressed: canPlay
              ? () => widget.startGame(
                  context,
                  selectedCategory,
                  selectedDifficulty,
                )
              : null,
          child: const Text('JOGAR'),
        ),
      ],
    );
  }
}
