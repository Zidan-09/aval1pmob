class WordChallengeLoadException implements Exception {
  final String message;
  final Object? cause;

  const WordChallengeLoadException(this.message, [this.cause]);

  @override
  String toString() =>
      'WordChallengeLoadException: $message'
      '${cause == null ? '' : ' ($cause)'}';
}
