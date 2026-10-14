import 'dart:async';
import 'dart:math';

import 'package:aval1pmob/entities/answer_category.dart';
import 'package:aval1pmob/entities/difficulty.dart';
import 'package:aval1pmob/entities/word_challenge.dart';
import 'package:aval1pmob/services/word_challenge_repository.dart';
import 'package:aval1pmob/utils/json_mapper.dart';
import 'package:aval1pmob/utils/no_answers_available_exception.dart';
import 'package:aval1pmob/utils/word_challenge_load_exception.dart';
import 'package:flutter/services.dart';

class WordChallengeRepositoryImpl implements WordChallengeRepository {
  static const String assetPath = 'lib/assets/data/hangman.json';

  final Future<String> Function(String path) _assetLoader;
  final Random _random;

  List<WordChallenge>? _cache;

  final Set<String> _usedKeys = {};

  WordChallengeRepositoryImpl({
    Future<String> Function(String path)? assetLoader,
    Random? random,
  }) : _assetLoader = assetLoader ?? rootBundle.loadString,
       _random = random ?? Random();

  static String _usedKey(WordChallenge challenge) {
    return '${challenge.category.value}|'
        '${challenge.difficulty.value}|'
        '${challenge.answer}';
  }

  static List<WordChallenge> parseChallenges(String jsonString) {
    try {
      return JsonMapper.toEntityList(
        jsonString,
        listKey: 'entries',
        fromJson: WordChallenge.fromJson,
      );
    } on FormatException {
      rethrow;
    } catch (error) {
      throw WordChallengeLoadException('Failed to parse challenges.', error);
    }
  }

  List<WordChallenge> _requireCache() {
    final cached = _cache;
    if (cached == null) {
      throw StateError(
        'Repository not initialized. Call await init() before querying.',
      );
    }
    return cached;
  }

  @override
  Future<void> init({bool forceReload = false}) async {
    if (_cache != null && !forceReload) {
      return;
    }
    late final String raw;
    try {
      raw = await _assetLoader(assetPath);
    } catch (error) {
      throw WordChallengeLoadException(
        'Failed to load asset $assetPath.',
        error,
      );
    }
    _cache = parseChallenges(raw);
  }

  @override
  List<AnswerCategory> loadCategories() {
    final challenges = _requireCache();
    final ordered = AnswerCategory.values.where(
      (category) => challenges.any((item) => item.category == category),
    );
    return List.unmodifiable(ordered);
  }

  @override
  List<Difficulty> loadDifficulties() {
    final challenges = _requireCache();
    final ordered = Difficulty.values.where(
      (difficulty) => challenges.any((item) => item.difficulty == difficulty),
    );
    return List.unmodifiable(ordered);
  }

  @override
  List<WordChallenge> findBy(AnswerCategory category, Difficulty difficulty) {
    final challenges = _requireCache();
    final filtered = challenges
        .where(
          (item) => item.category == category && item.difficulty == difficulty,
        )
        .toList();
    return List.unmodifiable(filtered);
  }

  @override
  WordChallenge draw(AnswerCategory category, Difficulty difficulty) {
    final candidates = findBy(category, difficulty);
    if (candidates.isEmpty) {
      throw NoAnswersAvailableException(
        'No answers for ${category.value}/${difficulty.value}.',
      );
    }
    final remaining = candidates
        .where((item) => !_usedKeys.contains(_usedKey(item)))
        .toList();
    if (remaining.isEmpty) {
      throw NoAnswersAvailableException(
        'All answers for ${category.value}/${difficulty.value} '
        'were already used in this session.',
      );
    }
    final drawn = remaining[_random.nextInt(remaining.length)];
    _usedKeys.add(_usedKey(drawn));
    return drawn;
  }

  @override
  int remainingCount(AnswerCategory category, Difficulty difficulty) {
    final cached = _cache;
    if (cached == null) {
      return 0;
    }
    return cached
        .where(
          (item) =>
              item.category == category &&
              item.difficulty == difficulty &&
              !_usedKeys.contains(_usedKey(item)),
        )
        .length;
  }
}
