class PlayerStats {
  int games = 0;
  int wins = 0;
  int loses = 0;
  int errors = 0;
  int tipsUseds = 0;

  void incrementGames() {
    games++;
  }

  void incrementWins() {
    wins++;
  }

  void incrementLoses() {
    loses++;
  }

  void incrementErrors() {
    errors++;
  }

  void addErrors(int count) {
    errors += count;
  }

  void incrementTipsUseds() {
    tipsUseds++;
  }

  double get winsPercentage {
    if (games == 0) return 0;
    return wins / games * 100;
  }

  double get lossesPercentage {
    if (games == 0) return 0;
    return loses / games * 100;
  }
}
