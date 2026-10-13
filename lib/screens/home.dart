import 'package:aval1pmob/components/home/setup_game_dialog.dart';
import 'package:aval1pmob/entities/answer_category.dart';
import 'package:aval1pmob/entities/difficulty.dart';
import 'package:aval1pmob/entities/player_stats.dart';
import 'package:aval1pmob/screens/game.dart';
import 'package:aval1pmob/services/word_challenge_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String backgroundAsset = 'lib/assets/images/background.png';
  static const String startButtonAsset = 'lib/assets/images/button-start.png';

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

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(parent: _pulse, curve: Curves.easeInOut));
    if (widget.openSetupOnStart) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _showSetupDialog(context);
      });
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage(HomeScreen.backgroundAsset), context);
    precacheImage(const AssetImage(HomeScreen.startButtonAsset), context);
  }

  Future<void> _onStartTap() async {
    if (_pulse.isAnimating) return;
    await _pulse.forward();
    await _pulse.reverse();
    if (mounted) _showSetupDialog(context);
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: _onStartTap,
                      borderRadius: BorderRadius.circular(24),
                      child: ScaleTransition(
                        scale: _scale,
                        child: Image.asset(
                          HomeScreen.startButtonAsset,
                          width: 300,
                          fit: BoxFit.contain,
                          semanticLabel: 'Começar',
                        ),
                      ),
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
