import '../../features/players/domain/enums/player_position.dart';

class CountryDTO {
  final String name;
  final String code;
  final int reputation;
  final String nameSource;

  CountryDTO({
    required this.name, 
    required this.code, 
    required this.reputation,
    required this.nameSource,
  });

  factory CountryDTO.fromJson(Map<String, dynamic> json) {
    return CountryDTO(
      name: json['name'],
      code: json['code'],
      reputation: json['reputation'],
      nameSource: json['nameSource'] ?? json['name'],
    );
  }
}

class LeagueDTO {
  final String name;
  final String nationality;
  final int reputation;
  final List<String> teamNames;

  LeagueDTO({
    required this.name,
    required this.nationality,
    required this.reputation,
    required this.teamNames,
  });

  factory LeagueDTO.fromJson(Map<String, dynamic> json) {
    return LeagueDTO(
      name: json['name'],
      nationality: json['nationality'],
      reputation: json['reputation'],
      teamNames: List<String>.from(json['teams']),
    );
  }
}

class TeamDTO {
  final String name;
  final int reputation;
  final double wageBudget;
  final double transferBudget;

  TeamDTO({
    required this.name,
    required this.reputation,
    required this.wageBudget,
    required this.transferBudget,
  });

  factory TeamDTO.fromJson(Map<String, dynamic> json) {
    return TeamDTO(
      name: json['name'],
      reputation: json['reputation'],
      wageBudget: (json['wageBudget'] as num).toDouble(),
      transferBudget: (json['transferBudget'] as num).toDouble(),
    );
  }
}

class NamesDTO {
  final Map<String, NameSet> countries;

  NamesDTO({required this.countries});

  factory NamesDTO.fromJson(Map<String, dynamic> json) {
    final map = <String, NameSet>{};
    json.forEach((key, value) {
      map[key] = NameSet.fromJson(value);
    });
    return NamesDTO(countries: map);
  }
}

class NameSet {
  final List<String> names;
  final List<String> surnames;

  NameSet({required this.names, required this.surnames});

  factory NameSet.fromJson(Map<String, dynamic> json) {
    return NameSet(
      names: List<String>.from(json['names']),
      surnames: List<String>.from(json['surnames']),
    );
  }
}
