import 'package:aval1pmob/components/dialog/popup_style.dart';
import 'package:flutter/material.dart';

class PopupTitle extends StatelessWidget {
  final String text;
  final PopupStyle style;

  const PopupTitle({super.key, required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: style.titleSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
