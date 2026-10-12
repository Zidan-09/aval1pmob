import 'package:aval1pmob/components/home/setup_game_dialog.dart';
import 'package:aval1pmob/entities/answer_category.dart';
import 'package:aval1pmob/entities/difficulty.dart';
import 'package:aval1pmob/entities/player_stats.dart';
import 'package:aval1pmob/screens/game.dart';
import 'package:aval1pmob/services/word_challenge_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String backgroundAsset = 'lib/assets/images/background.png';

  final WordChallengeRepository repository;
  final PlayerStats playerStats;
  final bool openSetupOnStart;

  const HomeScreen({
    super.key,
    required this.repository,
    required this.playerStats,
    this.openSetupOnStart = false,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.openSetupOnStart) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _showSetupDialog(context);
      });
    }
  }

  void _showSetupDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) =>
          SetupGameDialog(repository: widget.repository, startGame: _startGame),
    );
  }

  void _startGame(
    BuildContext context,
    AnswerCategory category,
    Difficulty difficulty,
  ) {
    if (widget.repository.remainingCount(category, difficulty) == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Todas as respostas dessa combinação já foram usadas.'),
        ),
      );
      return;
    }
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => GameScreen(
          repository: widget.repository,
          playerStats: widget.playerStats,
          category: category,
          difficulty: difficulty,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(HomeScreen.backgroundAsset, fit: BoxFit.cover),
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
                        foregroundColor: Colors.black,
                        minimumSize: const Size.fromHeight(72),
                        textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
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
