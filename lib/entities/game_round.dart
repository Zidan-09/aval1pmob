import 'package:aval1pmob/entities/word_challenge.dart';
import 'package:aval1pmob/utils/text_normalizer.dart';

enum GuessOutcome { hit, miss, repeated, invalid, finished }

class GameRound {
  static const int maxErrors = 6;

  final WordChallenge challenge;

  final Set<String> guessedLetters;

  int errors = 0;

  bool revealAll = false;

  GameRound({required this.challenge, Set<String>? guessed})
    : guessedLetters = {...?guessed};

  bool containsLetter(String rawLetter) {
    final trimmed = rawLetter.trim();
    if (trimmed.isEmpty || !TextNormalizer.isPlayableLetter(trimmed)) {
      return false;
    }
    final target = TextNormalizer.normalizeLetter(trimmed);
    final answer = challenge.answer;
    for (var i = 0; i < answer.length; i++) {
      final current = answer[i];
      if (!TextNormalizer.isPlayableLetter(current)) continue;
      if (TextNormalizer.normalizeLetter(current) == target) return true;
    }
    return false;
  }

  GuessOutcome guess(String rawLetter) {
    if (isFinished) {
      return GuessOutcome.finished;
    }
    final trimmed = rawLetter.trim();
    if (trimmed.length != 1 || !TextNormalizer.isPlayableLetter(trimmed)) {
      return GuessOutcome.invalid;
    }
    final normalized = TextNormalizer.normalizeLetter(trimmed);
    if (guessedLetters.contains(normalized)) {
      return GuessOutcome.repeated;
    }
    guessedLetters.add(normalized);
    if (containsLetter(normalized)) {
      return GuessOutcome.hit;
    }
    errors++;
    return GuessOutcome.miss;
  }

  bool get won {
    final answer = challenge.answer;
    for (var i = 0; i < answer.length; i++) {
      final current = answer[i];
      if (!TextNormalizer.isPlayableLetter(current)) continue;
      if (!guessedLetters.contains(TextNormalizer.normalizeLetter(current))) {
        return false;
      }
    }
    return true;
  }

  bool get lost => errors >= maxErrors;

  bool get isFinished => won || lost;

  bool isStructural(int index) {
    return !TextNormalizer.isPlayableLetter(challenge.answer[index]);
  }

  bool isRevealed(int index) {
    if (revealAll) return true;
    final original = challenge.answer[index];
    if (!TextNormalizer.isPlayableLetter(original)) return true;
    return guessedLetters.contains(TextNormalizer.normalizeLetter(original));
  }

  String displayCharAt(int index) {
    if (isRevealed(index)) return challenge.answer[index];
    return '_';
  }
}
