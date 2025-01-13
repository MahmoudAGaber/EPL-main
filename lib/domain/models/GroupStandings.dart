class GroupTableModel {
  final String country;
  final String flag;
  final String id;
  final String logo;
  final String name;
  final String season;
  final String seasonId;
  final String type;
  final String format;
  final List<List<Group>> standings;

  GroupTableModel({
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

  factory GroupTableModel.fromJson(Map<String, dynamic> json) {
    return GroupTableModel(
      country: json['country']??'',
      flag: json['flag']??"",
      id: json['id']??'',
      logo: json['logo']??"",
      name: json['name']??"",
      season: json['season']??"",
      seasonId: json['season_id'],
      type: json['type'],
      format: json['format'],
        standings: (json['standings'] as List).map((e) => (e as List).map((item) => Group.fromJson(item)).toList()).toList()
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

class Group {
  final String groupId;
  final String groupTitle;
  final List<TeamStanding> teams;

  Group({
    required this.groupId,
    required this.groupTitle,
    required this.teams,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      groupId: json['group_id']??"",
      groupTitle: json['group_title']??"",
      teams: (json['teams'] as List<dynamic>).map((team) => TeamStanding.fromJson(team as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'group_id': groupId,
      'group_title': groupTitle,
      'teams': teams.map((team) => team.toJson()).toList(),
    };
  }
}

class TeamStanding {
  final MatchStats all;
  final MatchStats home;
  final MatchStats away;
  final String points;
  final String rank;
  final Team team;

  TeamStanding({
    required this.all,
    required this.away,
    required this.home,
    required this.points,
    required this.rank,
    required this.team,
  });

  factory TeamStanding.fromJson(Map<String, dynamic> json) {
    return TeamStanding(
      all: MatchStats.fromJson(json['all']),
      away: MatchStats.fromJson(json['away']),
      home: MatchStats.fromJson(json['home']),
      points: json['points']??"",
      rank: json['rank']??"",
      team: Team.fromJson(json['team']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'all': all.toJson(),
      'away': away.toJson(),
      'points': points,
      'rank': rank,
      'team': team.toJson(),
    };
  }
}

class MatchStats {
  final String played;
  final String win;
  final String draw;
  final String lose;
  final String points;
  final String rank;
  final Goals goals;
  final String zoneStart;
  final String zoneColor;


  MatchStats({
    required this.played,
    required this.win,
    required this.draw,
    required this.lose,
    required this.points,
    required this.rank,
    required this.goals,
    required this.zoneStart,
    required this.zoneColor,
  });

  factory MatchStats.fromJson(Map<String, dynamic> json) {
    return MatchStats(
      played: json['played'] ?? '',
      win: json['win'] ?? '',
      draw: json['draw'] ?? '',
      lose: json['lose'] ?? '',
      points: json['points'] ?? '',
      rank: json['rank'] ?? '',
      goals: Goals.fromJson(json['goals'] ?? {}),
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
    };
  }
}

class Goals {
  final String forGoals;
  final String againstGoals;

  Goals({
    required this.forGoals,
    required this.againstGoals,
  });

  factory Goals.fromJson(Map<String, dynamic> json) {
    return Goals(
      forGoals: json['for'] ?? '',
      againstGoals: json['against'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'for': forGoals,
      'against': againstGoals,
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
      id: json['id']??"",
      logo: json['logo']??"",
      name: json['name']??"",
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
