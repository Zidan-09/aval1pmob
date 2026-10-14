import 'package:aval1pmob/entities/answer_category.dart';
import 'package:aval1pmob/entities/difficulty.dart';
import 'package:aval1pmob/services/word_challenge_repository.dart';
import 'package:flutter/material.dart';

class SetupGameDialog extends StatefulWidget {
  static const String popupAsset = 'lib/assets/images/buttons/panel-popup.png';

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

  List<Widget> _chipRows<T>({
    required List<T> items,
    required int perRow,
    required Widget Function(T item) buildChip,
  }) {
    final rows = <Widget>[];
    for (var i = 0; i < items.length; i += perRow) {
      final slice = items.sublist(
        i,
        i + perRow > items.length ? items.length : i + perRow,
      );
      rows.add(
        Row(
          children: [
            for (var j = 0; j < slice.length; j++) ...[
              if (j > 0) const SizedBox(width: 8),
              Expanded(child: buildChip(slice[j])),
            ],
          ],
        ),
      );
      if (i + perRow < items.length) {
        rows.add(const SizedBox(height: 8));
      }
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    final remaining = widget.repository.remainingCount(
      selectedCategory,
      selectedDifficulty,
    );
    final canPlay = remaining > 0;
    final size = MediaQuery.sizeOf(context);
    final sidePadding = (size.width * 0.10).clamp(36.0, 52.0);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.05,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 500,
          maxHeight: size.height * 0.90,
        ),
        child: Container(
          width: double.infinity,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage(SetupGameDialog.popupAsset),
              fit: BoxFit.fill,
              centerSlice: Rect.fromLTWH(24, 24, 460, 444),
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(sidePadding, 56, sidePadding, 48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Nova partida',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Categoria',
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
                const SizedBox(height: 8),
                ..._chipRows<AnswerCategory>(
                  items: categories,
                  perRow: 2,
                  buildChip: (category) {
                    final isSelected = selectedCategory == category;
                    return ChoiceChip(
                      label: SizedBox(
                        width: double.infinity,
                        child: Text(
                          category.labelPt,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      selected: isSelected,
                      showCheckmark: false,
                      visualDensity: VisualDensity.compact,
                      backgroundColor: const Color(0xFF3A3A46),
                      selectedColor: Colors.red,
                      labelStyle: TextStyle(
                        fontSize: 13,
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
                  },
                ),
                const SizedBox(height: 12),
                const Text(
                  'Dificuldade',
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
                const SizedBox(height: 8),
                ..._chipRows<Difficulty>(
                  items: difficulties,
                  perRow: 3,
                  buildChip: (difficulty) {
                    final isSelected = selectedDifficulty == difficulty;
                    return ChoiceChip(
                      label: SizedBox(
                        width: double.infinity,
                        child: Text(
                          difficulty.labelPt,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      selected: isSelected,
                      showCheckmark: false,
                      visualDensity: VisualDensity.compact,
                      backgroundColor: const Color(0xFF3A3A46),
                      selectedColor: Colors.red,
                      labelStyle: TextStyle(
                        fontSize: 13,
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
                  },
                ),
                const SizedBox(height: 12),
                const Text(
                  'Seleção',
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
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
                        const SizedBox(height: 2),
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
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Cancelar'),
                    ),
                    const SizedBox(width: 8),
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
                      child: const Text('Jogar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
