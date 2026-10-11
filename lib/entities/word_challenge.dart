import 'package:aval1pmob/entities/answer_category.dart';
import 'package:aval1pmob/entities/difficulty.dart';

class WordChallenge {
  final String answer;
  final AnswerCategory category;
  final Difficulty difficulty;
  final List<String> hints;

  const WordChallenge({
    required this.answer,
    required this.category,
    required this.difficulty,
    required this.hints,
  });

  factory WordChallenge.fromJson(Map<String, dynamic> json) {
    final dynamic rawAnswer = json['answer'];
    final dynamic rawCategory = json['category'];
    final dynamic rawDifficulty = json['difficulty'];
    final dynamic rawHints = json['hints'];

    if (rawAnswer is! String || rawAnswer.trim().isEmpty) {
      throw const FormatException('Invalid or missing "answer" field.');
    }
    if (rawCategory is! String) {
      throw const FormatException('Invalid or missing "category" field.');
    }
    if (rawDifficulty is! String) {
      throw const FormatException('Invalid or missing "difficulty" field.');
    }
    if (rawHints is! List || rawHints.isEmpty) {
      throw const FormatException('Invalid or missing "hints" field.');
    }

    final hints = rawHints.map((item) {
      if (item is! String || item.trim().isEmpty) {
        throw const FormatException('Invalid hint entry: must be non-empty.');
      }
      return item;
    }).toList();

    return WordChallenge(
      answer: rawAnswer,
      category: AnswerCategoryMapper.fromValue(rawCategory),
      difficulty: DifficultyMapper.fromValue(rawDifficulty),
      hints: hints,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
      'category': category.value,
      'difficulty': difficulty.value,
      'hints': hints,
    };
  }

  bool get hasTips => hints.isNotEmpty;

  String consumeTip() {
    if (hints.isEmpty) {
      throw StateError('No tips remaining for this challenge.');
    }
    return hints.removeAt(0);
  }
}
