import 'package:aval1pmob/components/dialog/popup_style.dart';
import 'package:flutter/material.dart';

class SetupSectionLabel extends StatelessWidget {
  final String text;
  final PopupStyle style;

  const SetupSectionLabel(this.text, this.style, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.white54, fontSize: style.labelSize),
    );
  }
}
