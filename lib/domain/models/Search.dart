class SearchModel {
  final List<Competition> competitions;
  List<Team> teams;

  SearchModel({required this.competitions, required this.teams});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      competitions: (json['competitions'] as List?)?.map((e) => Competition.fromJson(e)).toList() ?? [],
      teams: (json['teams'] as List?)?.map((e) => Team.fromJson(e)).toList() ?? [],
    );
  }

}

class Competition {
  final String id;
  final String name;
  final String country;

  Competition({required this.id, required this.name, required this.country});

  factory Competition.fromJson(Map<String, dynamic> json) {
    return Competition(
      id: json['id'],
      name: json['name'],
      country: json['country'],
    );
  }
}

class Team {
  final String id;
  final String name;
  final String type;
  final String teamType;

  Team({required this.id, required this.name, required this.type, required this.teamType});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      teamType: json['teamType'],
    );
  }
}
