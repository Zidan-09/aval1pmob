import 'package:aval1pmob/components/status_bar_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppScaffold extends StatelessWidget {
  final List<Widget> backgrounds;
  final List<Widget> children;

  const AppScaffold({
    super.key,
    required this.backgrounds,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          fit: StackFit.expand,
          children: [...backgrounds, ...children, const StatusBarBackground()],
        ),
      ),
    );
  }
}
