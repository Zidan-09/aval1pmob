import 'package:aval1pmob/entities/answer_category.dart';
import 'package:aval1pmob/entities/difficulty.dart';
import 'package:aval1pmob/entities/word_challenge.dart';

abstract class WordChallengeRepository {
  Future<List<WordChallenge>> loadAll({bool forceReload = false});

  Future<List<AnswerCategory>> loadCategories();

  Future<List<Difficulty>> loadDifficulties();

  Future<List<WordChallenge>> findBy(
    AnswerCategory category,
    Difficulty difficulty,
  );

  Future<WordChallenge> draw(AnswerCategory category, Difficulty difficulty);

  int remainingCount(AnswerCategory category, Difficulty difficulty);

  int get usedCount;

  void resetUsed();
}
