import 'package:aval1pmob/entities/answer_category.dart';
import 'package:aval1pmob/entities/difficulty.dart';
import 'package:aval1pmob/screens/game.dart';
import 'package:aval1pmob/services/word_challenge_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String backgroundAsset =
      'lib/assets/data/images/Gemini_Generated_Image_eyj0w5eyj0w5eyj0.png';

  final WordChallengeRepository repository;

  const HomeScreen({super.key, required this.repository});

  void _showSetupDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => SetupGameDialog(repository: repository),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(backgroundAsset, fit: BoxFit.cover),
          Container(color: Colors.black.withValues(alpha: 0.35)),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () => _showSetupDialog(context),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      child: const Text('Começar'),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
