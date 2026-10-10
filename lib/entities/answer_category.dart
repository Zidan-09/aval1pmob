enum AnswerCategory { 
  animals, 
  humanBody, 
  sports, 
  technology 
}

extension AnswerCategoryMapper on AnswerCategory {
  static AnswerCategory fromValue(String value) {
    switch (value) {
      case 'animals':
        return AnswerCategory.animals;
      case 'humanBody':
        return AnswerCategory.humanBody;
      case 'sports':
        return AnswerCategory.sports;
      case 'technology':
        return AnswerCategory.technology;
      default:
        throw FormatException('Unknown AnswerCategory value: $value');
    }
  }

  String get value {
    switch (this) {
      case AnswerCategory.animals:
        return 'animals';
      case AnswerCategory.humanBody:
        return 'humanBody';
      case AnswerCategory.sports:
        return 'sports';
      case AnswerCategory.technology:
        return 'technology';
    }
  }

  String get labelPt {
    switch (this) {
      case AnswerCategory.animals:
        return 'Animais';
      case AnswerCategory.humanBody:
        return 'Corpo humano';
      case AnswerCategory.sports:
        return 'Esportes';
      case AnswerCategory.technology:
        return 'Tecnologia';
    }
  }
}
