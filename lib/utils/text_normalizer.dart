class TextNormalizer {
  static const Map<String, String> _accentMap = {
    'Á': 'A',
    'À': 'A',
    'Â': 'A',
    'Ã': 'A',
    'É': 'E',
    'Ê': 'E',
    'Í': 'I',
    'Ó': 'O',
    'Ô': 'O',
    'Õ': 'O',
    'Ú': 'U',
    'Ç': 'C',
  };

  static String normalizeLetter(String character) {
    if (character.isEmpty) return character;
    final upper = character.toUpperCase();
    return _accentMap[upper] ?? upper;
  }

  static String normalizeText(String text) {
    final buffer = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      buffer.write(normalizeLetter(text[i]));
    }
    return buffer.toString();
  }

  static bool isPlayableLetter(String character) {
    if (character.isEmpty) return false;
    final normalized = normalizeLetter(character);
    return normalized.length == 1 &&
        normalized.codeUnitAt(0) >= 65 &&
        normalized.codeUnitAt(0) <= 90;
  }
}
