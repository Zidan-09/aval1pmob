import 'package:aval1pmob/screens/home.dart';
import 'package:aval1pmob/services/word_challenge_repository.dart';
import 'package:aval1pmob/utils/word_challenge_repository_imp.dart';
import 'package:flutter/material.dart';

void main() {
  final repository = WordChallengeRepositoryImpl();

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final WordChallengeRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jodo da Forca do Sonic.exe',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: HomeScreen(repository: repository),
    );
  }
}
