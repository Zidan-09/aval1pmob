import 'package:aval1pmob/components/dialog/popup_style.dart';
import 'package:flutter/material.dart';

class SessionStatRow extends StatelessWidget {
  final String label;
  final String value;
  final double fontSize;
  final bool isLast;

  const SessionStatRow({
    super.key,
    required this.label,
    required this.value,
    required this.fontSize,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white70, fontSize: fontSize),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: popupPrimaryBackground,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
