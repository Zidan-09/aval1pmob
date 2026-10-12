class PlayerStats {
  num games = 0;
  num wins = 0;
  num loses = 0;
  num errors = 0;
  num tipsUseds = 0;

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

  void incrementTipsUseds() {
    tipsUseds++;
  }

  num getWinsPercentage() {
    return wins * (games / 100);
  }

  num getLosesPercentage() {
    return loses * (games / 100);
  }
}