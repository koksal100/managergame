enum PlayerPosition {
  goalkeeper,
  defender,
  midfielder,
  forward;

  String get shortName {
    switch (this) {
      case PlayerPosition.goalkeeper:
        return 'GK';
      case PlayerPosition.defender:
        return 'DEF';
      case PlayerPosition.midfielder:
        return 'MID';
      case PlayerPosition.forward:
        return 'FWD';
    }
  }
}
