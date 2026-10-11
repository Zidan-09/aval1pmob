import 'package:aval1pmob/entities/answer_category.dart';
import 'package:aval1pmob/entities/difficulty.dart';
import 'package:aval1pmob/entities/word_challenge.dart';

abstract class WordChallengeRepository {
  Future<void> init({bool forceReload = false});

  bool get isLoaded;

  List<WordChallenge> loadAll();

  List<AnswerCategory> loadCategories();

  List<Difficulty> loadDifficulties();

  List<WordChallenge> findBy(
    AnswerCategory category,
    Difficulty difficulty,
  );

  WordChallenge draw(AnswerCategory category, Difficulty difficulty);

  int remainingCount(AnswerCategory category, Difficulty difficulty);

  int get usedCount;

  void resetUsed();
}
