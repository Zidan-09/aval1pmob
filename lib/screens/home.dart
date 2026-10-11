import 'package:aval1pmob/components/home/setup_game_dialog.dart';
import 'package:aval1pmob/services/word_challenge_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String backgroundAsset =
      'lib/assets/images/background.png';

  final WordChallengeRepository repository;

  const HomeScreen({super.key, required this.repository});

  void _showSetupDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => SetupGameDialog(repository: repository),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(backgroundAsset, fit: BoxFit.cover),
          Container(color: Colors.black.withValues(alpha: 0.35)),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () => _showSetupDialog(context),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      child: const Text('Começar'),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}