import 'package:aval1pmob/components/game/session_stats_dialog.dart';
import 'package:aval1pmob/components/game/stats_menu_button.dart';
import 'package:aval1pmob/components/home/setup_game_dialog.dart';
import 'package:aval1pmob/entities/answer_category.dart';
import 'package:aval1pmob/entities/difficulty.dart';
import 'package:aval1pmob/entities/player_stats.dart';
import 'package:aval1pmob/screens/about.dart';
import 'package:aval1pmob/screens/game.dart';
import 'package:aval1pmob/services/word_challenge_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  static const String backgroundAsset =
      'lib/assets/images/backgrounds/home-background.png';
  static const String startButtonAsset =
      'lib/assets/images/buttons/start-button.png';
  static const String aboutButtonAsset =
      'lib/assets/images/buttons/about-button.png';
  static const String statsButtonAsset =
      'lib/assets/images/buttons/stats-button.png';

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

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _pulse;
  late final Animation<double> _scale;
  late final AnimationController _pulseAbout;
  late final Animation<double> _scaleAbout;

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
    _pulseAbout = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAbout = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(parent: _pulseAbout, curve: Curves.easeInOut));
    if (widget.openSetupOnStart) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _showSetupDialog(context);
      });
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    _pulseAbout.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage(HomeScreen.backgroundAsset), context);
    precacheImage(const AssetImage(HomeScreen.startButtonAsset), context);
    precacheImage(const AssetImage(HomeScreen.aboutButtonAsset), context);
    precacheImage(const AssetImage(HomeScreen.statsButtonAsset), context);
  }

  Future<void> _onStartTap() async {
    if (_pulse.isAnimating) return;
    await _pulse.forward();
    await _pulse.reverse();
    if (mounted) _showSetupDialog(context);
  }

  Future<void> _onAboutTap() async {
    if (_pulseAbout.isAnimating) return;
    await _pulseAbout.forward();
    await _pulseAbout.reverse();
    if (mounted) _openAbout(context);
  }

  void _showSetupDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) =>
          SetupGameDialog(repository: widget.repository, startGame: _startGame),
    );
  }

  void _openAbout(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (context) => const AboutScreen()));
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
    final size = MediaQuery.sizeOf(context);
    final statusH = MediaQuery.paddingOf(context).top;
    final buttonWidth = (size.width * 0.68).clamp(200.0, 300.0);

    return Scaffold(
      backgroundColor: Colors.black,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(HomeScreen.backgroundAsset, fit: BoxFit.cover),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(height: statusH, color: Colors.black),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 80),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: _onStartTap,
                      borderRadius: BorderRadius.circular(24),
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment.center,
                          heightFactor: 0.6,
                          child: ScaleTransition(
                            scale: _scale,
                            child: Image.asset(
                              HomeScreen.startButtonAsset,
                              width: buttonWidth,
                              fit: BoxFit.contain,
                              semanticLabel: 'Começar',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 0),
                    InkWell(
                      onTap: _onAboutTap,
                      borderRadius: BorderRadius.circular(24),
                      child: ScaleTransition(
                        scale: _scaleAbout,
                        child: ClipRect(
                          child: Align(
                            alignment: Alignment.center,
                            heightFactor: 0.6,
                            child: Image.asset(
                              HomeScreen.aboutButtonAsset,
                              width: buttonWidth,
                              fit: BoxFit.contain,
                              semanticLabel: 'Sobre',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: statusH + 8,
              right: 8,
              child: StatsMenuButton(
                stats: widget.playerStats,
                variant: SessionStatsVariant.home,
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      HomeScreen.statsButtonAsset,
                      width: 68,
                      height: 68,
                      fit: BoxFit.contain,
                      semanticLabel: 'Estatísticas',
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Estatísticas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
