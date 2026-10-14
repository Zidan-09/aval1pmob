import 'package:aval1pmob/entities/player_stats.dart';
import 'package:aval1pmob/screens/home.dart';
import 'package:aval1pmob/services/word_challenge_repository.dart';
import 'package:aval1pmob/utils/word_challenge_repository_imp.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repository = WordChallengeRepositoryImpl();
  final PlayerStats playerStats = PlayerStats();

  try {
    await repository.init();
  } catch (error) {
    runApp(LoadErrorApp(error: error));
    return;
  }

  runApp(MyApp(repository: repository, playerStats: playerStats));
}

class MyApp extends StatelessWidget {
  final WordChallengeRepository repository;
  final PlayerStats playerStats;

  const MyApp({super.key, required this.repository, required this.playerStats});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Forca do Sonic.exe',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: HomeScreen(repository: repository, playerStats: playerStats),
    );
  }
}

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
