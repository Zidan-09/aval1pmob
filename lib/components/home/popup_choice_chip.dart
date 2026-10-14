import 'package:aval1pmob/components/dialog/popup_style.dart';
import 'package:flutter/material.dart';

class PopupChoiceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final PopupStyle style;
  final VoidCallback onTap;

  const PopupChoiceChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.style,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: SizedBox(
        width: double.infinity,
        child: Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      selected: isSelected,
      showCheckmark: false,
      backgroundColor: popupOptionBackground,
      selectedColor: popupSelectedBackground,
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      labelPadding: EdgeInsets.symmetric(horizontal: style.narrow ? 2 : 8),
      padding: EdgeInsets.symmetric(
        horizontal: style.narrow ? 4 : 8,
        vertical: style.narrow ? 2 : 4,
      ),
      labelStyle: TextStyle(
        fontSize: style.chipFontSize,
        color: isSelected ? Colors.white : Colors.white70,
      ),
      shape: StadiumBorder(
        side: BorderSide(
          color: isSelected ? popupSelectedBackground : popupOptionBorder,
        ),
      ),
      onSelected: (_) => onTap(),
    );
  }
}
