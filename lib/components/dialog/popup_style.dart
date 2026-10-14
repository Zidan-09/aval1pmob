import 'package:flutter/material.dart';

const double popupNarrowBreakpoint = 400;

const double popupMaxDialogWidth = 500;

const Color popupOptionBackground = Color(0xFF3A3A46);

const Color popupOptionBorder = Colors.white38;

const Color popupSelectedBackground = Colors.red;

const Color popupPrimaryBackground = Colors.amber;

class PopupStyle {
  final bool narrow;
  final double sidePadding;
  final double topPadding;
  final double bottomPadding;
  final double titleSize;
  final double labelSize;
  final double chipFontSize;
  final double btnFontSize;
  final double gapSection;
  final double gapLabel;
  final double hInset;
  final double vInset;
  final double dialogWidth;
  final double maxDialogHeight;

  const PopupStyle({
    required this.narrow,
    required this.sidePadding,
    required this.topPadding,
    required this.bottomPadding,
    required this.titleSize,
    required this.labelSize,
    required this.chipFontSize,
    required this.btnFontSize,
    required this.gapSection,
    required this.gapLabel,
    required this.hInset,
    required this.vInset,
    required this.dialogWidth,
    required this.maxDialogHeight,
  });

  factory PopupStyle.resolve(
    Size screen, {
    double maxDialogWidth = popupMaxDialogWidth,
  }) {
    final narrow = screen.width < popupNarrowBreakpoint;
    final hInset = screen.width * (narrow ? 0.06 : 0.04);
    return PopupStyle(
      narrow: narrow,
      sidePadding: narrow ? 52.0 : (screen.width * 0.15).clamp(36.0, 52.0),
      topPadding: narrow ? 36.0 : 56.0,
      bottomPadding: narrow ? 28.0 : 48.0,
      titleSize: narrow ? 20.0 : 25.0,
      labelSize: narrow ? 12.0 : 14.0,
      chipFontSize: narrow ? 11.5 : 13.0,
      btnFontSize: narrow ? 12.0 : 14.0,
      gapSection: narrow ? 8.0 : 12.0,
      gapLabel: narrow ? 6.0 : 8.0,
      hInset: hInset,
      vInset: screen.height * 0.05,
      dialogWidth: (screen.width - hInset * 2).clamp(0.0, maxDialogWidth),
      maxDialogHeight: screen.height * 0.90,
    );
  }
}

ButtonStyle popupButtonStyle(Color bg, Color fg, PopupStyle style) {
  return ElevatedButton.styleFrom(
    backgroundColor: bg,
    foregroundColor: fg,
    shape: const StadiumBorder(),
    textStyle: TextStyle(fontSize: style.btnFontSize),
    padding: EdgeInsets.symmetric(
      horizontal: style.narrow ? 12 : 16,
      vertical: style.narrow ? 8 : 10,
    ),
    minimumSize: Size(0, style.narrow ? 32 : 36),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}
