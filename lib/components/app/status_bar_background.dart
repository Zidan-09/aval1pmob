import 'package:flutter/material.dart';

class StatusBarBackground extends StatelessWidget {
  const StatusBarBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.paddingOf(context).top,
        color: Colors.black,
      ),
    );
  }
}
