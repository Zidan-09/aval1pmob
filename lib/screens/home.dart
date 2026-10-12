import 'package:aval1pmob/components/home/setup_game_dialog.dart';
import 'package:aval1pmob/entities/answer_category.dart';
import 'package:aval1pmob/entities/difficulty.dart';
import 'package:aval1pmob/entities/player_stats.dart';
import 'package:aval1pmob/screens/game.dart';
import 'package:aval1pmob/services/word_challenge_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String backgroundAsset =
      'lib/assets/images/background.png';

  final WordChallengeRepository repository;
  final PlayerStats playerStats;

  const HomeScreen({super.key, required this.repository, required this.playerStats});

  void _showSetupDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => SetupGameDialog(repository: repository, startGame: _startGame,),
    );
  }

  void _startGame(BuildContext context, AnswerCategory category, Difficulty difficulty) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => GameScreen(
          repository: repository,
          playerStats: playerStats,
          category: category,
          difficulty: difficulty,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("$playerStats");
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(backgroundAsset, fit: BoxFit.cover),
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