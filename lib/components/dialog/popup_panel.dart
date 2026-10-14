import 'package:aval1pmob/components/dialog/popup_style.dart';
import 'package:flutter/material.dart';

class PopupPanel extends StatelessWidget {
  static const double panelRadius = 20;
  static const Rect panelCenterSlice = Rect.fromLTWH(24, 24, 460, 444);

  final String backgroundAsset;
  final PopupStyle style;
  final Widget child;

  const PopupPanel({
    super.key,
    required this.backgroundAsset,
    required this.style,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(
        horizontal: style.hInset,
        vertical: style.vInset,
      ),
      child: SizedBox(
        width: style.dialogWidth,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: style.maxDialogHeight),
          child: Container(
            width: style.dialogWidth,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(panelRadius),
              image: DecorationImage(
                image: AssetImage(backgroundAsset),
                fit: BoxFit.fill,
                centerSlice: panelCenterSlice,
              ),
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                style.sidePadding,
                style.topPadding,
                style.sidePadding,
                style.bottomPadding,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
