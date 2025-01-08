
class TableModel {
  final String country;
  final String flag;
  final String id;
  final String logo;
  final String name;
  final String season;
  final String seasonId;
  final String type;
  final String format;
  final List<List<Standing>> standings;

  TableModel({
    required this.country,
    required this.flag,
    required this.id,
    required this.logo,
    required this.name,
    required this.season,
    required this.seasonId,
    required this.type,
    required this.format,
    required this.standings,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      country: json['country'] ?? '',
      flag: json['flag'] ?? '',
      id: json['id'] ?? '',
      logo: json['logo'] ?? '',
      name: json['name'] ?? '',
      season: json['season'] ?? '',
      seasonId: json['season_id'] ?? '',
      type: json['type'] ?? '',
      format: json['format'] ?? '',
      standings: (json['standings'] as List).map((e) => (e as List).map((item) => Standing.fromJson(item)).toList()).toList()
    ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'flag': flag,
      'id': id,
      'logo': logo,
      'name': name,
      'season': season,
      'season_id': seasonId,
      'type': type,
      'format': format,
      'standings': standings.map((e) => e.map((item) => item.toJson()).toList()).toList(),
    };
  }
}

class Standing {
  final String type;
  final All all;
  final String points;
  final String rank;
  final Team team;

  Standing({
    required this.type,
    required this.all,
    required this.points,
    required this.rank,
    required this.team,
  });

  factory Standing.fromJson(Map<String, dynamic> json) {
    return Standing(
      type: json['type'] ?? '',
      all: All.fromJson(json['all']),
      points: json['points'] ?? '',
      rank: json['rank'] ?? '',
      team: Team.fromJson(json['team']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'all': all.toJson(),
      'points': points,
      'rank': rank,
      'team': team.toJson(),
    };
  }
}

class All {
  final String played;
  final String win;
  final String draw;
  final String lose;
  final String points;
  final Goals goals;
  final String zoneStart;
  final String zoneColor;

  All({
    required this.played,
    required this.win,
    required this.draw,
    required this.lose,
    required this.points,
    required this.goals,
    required this.zoneStart,
    required this.zoneColor
  });

  factory All.fromJson(Map<String, dynamic> json) {
    return All(
      played: json['played'] ?? '',
      win: json['win'] ?? '',
      draw: json['draw'] ?? '',
      lose: json['lose'] ?? '',
      points: json['points'] ?? '',
      goals: Goals.fromJson(json['goals']),
      zoneStart: json['zone_start'] ?? '',
      zoneColor: json['zone_color'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'played': played,
      'win': win,
      'draw': draw,
      'lose': lose,
      'points': points,
      'goals': goals.toJson(),
      'zone_start': zoneStart,
      'zone_color': zoneColor,

    };
  }
}

class Goals {
  final String goalsFor;
  final String goalsAgainst;

  Goals({
    required this.goalsFor,
    required this.goalsAgainst,
  });

  factory Goals.fromJson(Map<String, dynamic> json) {
    return Goals(
      goalsFor: json['for'] ?? '',
      goalsAgainst: json['against'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'for': goalsFor,
      'against': goalsAgainst,
    };
  }
}

class Team {
  final String id;
  final String logo;
  final String name;

  Team({
    required this.id,
    required this.logo,
    required this.name,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'] ?? '',
      logo: json['logo'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo': logo,
      'name': name,
    };
  }
}

