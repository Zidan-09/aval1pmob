import 'package:flutter/material.dart';

class LoadErrorApp extends StatelessWidget {
  final Object error;

  const LoadErrorApp({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Falha ao carregar dados do jogo:\n$error',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
