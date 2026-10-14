import 'package:aval1pmob/components/dialog/popup_panel.dart';
import 'package:aval1pmob/components/dialog/popup_style.dart';
import 'package:aval1pmob/components/dialog/popup_title.dart';
import 'package:aval1pmob/components/home/setup/popup_choice_chip.dart';
import 'package:aval1pmob/components/home/setup/setup_section_label.dart';
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
              if (j > 0) const SizedBox(width: 4),
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

  PopupChoiceChip _buildChip({
    required String label,
    required bool isSelected,
    required PopupStyle style,
    required VoidCallback onTap,
  }) {
    return PopupChoiceChip(
      label: label,
      isSelected: isSelected,
      style: style,
      onTap: onTap,
    );
  }

  List<Widget> _chipSection<T>({
    required String title,
    required PopupStyle style,
    required List<T> items,
    required int perRow,
    required String Function(T item) labelOf,
    required bool Function(T item) isSelected,
    required void Function(T item) onSelect,
  }) {
    return [
      SetupSectionLabel(title, style),
      SizedBox(height: style.gapLabel),
      ..._chipRows<T>(
        items: items,
        perRow: perRow,
        buildChip: (item) => _buildChip(
          label: labelOf(item),
          isSelected: isSelected(item),
          style: style,
          onTap: () => setState(() => onSelect(item)),
        ),
      ),
    ];
  }

  Widget _buildSelectionCard(PopupStyle style, int remaining, bool canPlay) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: style.narrow ? 8 : 12,
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
              style: TextStyle(
                color: popupPrimaryBackground,
                fontSize: style.narrow ? 14 : 16,
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
              style: TextStyle(
                color: Colors.white,
                fontSize: style.narrow ? 11 : 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(PopupStyle style, bool canPlay) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: popupButtonStyle(popupOptionBackground, Colors.white, style)
              .copyWith(
                side: const WidgetStatePropertyAll(
                  BorderSide(color: popupOptionBorder),
                ),
              ),
          child: const Text('Cancelar'),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: popupButtonStyle(popupPrimaryBackground, Colors.black, style),
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

  @override
  Widget build(BuildContext context) {
    final remaining = widget.repository.remainingCount(
      selectedCategory,
      selectedDifficulty,
    );
    final canPlay = remaining > 0;
    final style = PopupStyle.resolve(MediaQuery.sizeOf(context));

    return PopupPanel(
      backgroundAsset: SetupGameDialog.popupAsset,
      style: style,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PopupTitle(text: 'Nova partida', style: style),
          SizedBox(height: style.gapSection),
          ..._chipSection<AnswerCategory>(
            title: 'Categoria',
            style: style,
            items: categories,
            perRow: 2,
            labelOf: (category) => category.labelPt,
            isSelected: (category) => selectedCategory == category,
            onSelect: (category) => selectedCategory = category,
          ),
          SizedBox(height: style.gapSection),
          ..._chipSection<Difficulty>(
            title: 'Dificuldade',
            style: style,
            items: difficulties,
            perRow: 3,
            labelOf: (difficulty) => difficulty.labelPt,
            isSelected: (difficulty) => selectedDifficulty == difficulty,
            onSelect: (difficulty) => selectedDifficulty = difficulty,
          ),
          SizedBox(height: style.gapSection),
          SetupSectionLabel('Seleção', style),
          SizedBox(height: style.gapLabel),
          _buildSelectionCard(style, remaining, canPlay),
          SizedBox(height: style.gapSection),
          _buildActions(style, canPlay),
        ],
      ),
    );
  }
}
