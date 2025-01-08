class H2HModel {
  List<FixtureDetail> h2h;
  Statistics statisticsH2h;
  Summary summary;
  H2HModel({required this.h2h, required this.statisticsH2h, required this.summary});

  factory H2HModel.fromJson(Map<String, dynamic> json) {
    return H2HModel(
      h2h: List<FixtureDetail>.from(json['h2h'].map((x) => FixtureDetail.fromJson(x)),),
      statisticsH2h: Statistics.fromJson(json['statistics']),
        summary:  Summary.fromJson(json['summary'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'h2h': h2h.map((x) => x.toJson()).toList(),
    };
  }
}

class FixtureDetail {
  Fixture fixture;
  League league;
  Teams teams;
  Goals goals;
  Score score;

  FixtureDetail({
    required this.fixture,
    required this.league,
    required this.teams,
    required this.goals,
    required this.score,
  });

  factory FixtureDetail.fromJson(Map<String, dynamic> json) {
    return FixtureDetail(
      fixture: Fixture.fromJson(json['fixture']),
      league: League.fromJson(json['league']),
      teams: Teams.fromJson(json['teams']),
      goals: Goals.fromJson(json['goals']),
      score: Score.fromJson(json['score']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fixture': fixture.toJson(),
      'league': league.toJson(),
      'teams': teams.toJson(),
      'goals': goals.toJson(),
      'score': score.toJson(),
    };
  }
}

class Fixture {
  String id;
  String? referee;
  String timezone;
  String date;
  int? timestamp;
  Periods periods;
  Status status;

  Fixture({
    required this.id,
    this.referee,
    required this.timezone,
    required this.date,
    this.timestamp,
    required this.periods,
    required this.status,
  });

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      id: json['id']??"",
      referee: json['referee']??"",
      timezone: json['timezone']??"",
      date: json['date']??"",
      timestamp: json['timestamp']??0,
      periods: Periods.fromJson(json['periods']),
      status: Status.fromJson(json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'referee': referee,
      'timezone': timezone,
      'date': date,
      'timestamp': timestamp,
      'periods': periods.toJson(),
      'status': status.toJson(),
    };
  }
}

class Periods {
  String first;
  String second;

  Periods({required this.first, required this.second});

  factory Periods.fromJson(Map<String, dynamic> json) {
    return Periods(
      first: json['first']??"",
      second: json['second']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'second': second,
    };
  }
}

class Status {
  String long;
  String short;
  int? elapsed;

  Status({required this.long, required this.short, this.elapsed});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      long: json['long']??0,
      short: json['short']??0,
      elapsed: json['elapsed']??0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'long': long,
      'short': short,
      'elapsed': elapsed,
    };
  }
}

class League {
  String id;
  String name;
  String country;
  String logo;
  String flag;
  String season;
  String round;

  League({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.flag,
    required this.season,
    required this.round,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id']??"",
      name: json['name']??"",
      country: json['country']??"",
      logo: json['logo']??"",
      flag: json['flag']??"",
      season: json['season']??"",
      round: json['round']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'logo': logo,
      'flag': flag,
      'season': season,
      'round': round,
    };
  }
}

class Teams {
  Team home;
  Team away;

  Teams({required this.home, required this.away});

  factory Teams.fromJson(Map<String, dynamic> json) {
    return Teams(
      home: Team.fromJson(json['home']),
      away: Team.fromJson(json['away']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home': home.toJson(),
      'away': away.toJson(),
    };
  }
}

class Team {
  String id;
  String name;
  String logo;
  String? winner;

  Team({required this.id, required this.name, required this.logo, this.winner});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id']??"",
      name: json['name']??"",
      logo: json['logo']??"",
      winner: json['winner']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'winner': winner,
    };
  }
}

class Goals {
  String home;
  String away;

  Goals({required this.home, required this.away});

  factory Goals.fromJson(Map<String, dynamic> json) {
    return Goals(
      home: json['home']??"",
      away: json['away']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home': home,
      'away': away,
    };
  }
}

class Score {
  Halftime halftime;
  Fulltime fulltime;
  Extratime extratime;
  Penalty penalty;

  Score({
    required this.halftime,
    required this.fulltime,
    required this.extratime,
    required this.penalty,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      halftime: Halftime.fromJson(json['halftime']),
      fulltime: Fulltime.fromJson(json['fulltime']),
      extratime: Extratime.fromJson(json['extratime']),
      penalty: Penalty.fromJson(json['penalty']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'halftime': halftime.toJson(),
      'fulltime': fulltime.toJson(),
      'extratime': extratime.toJson(),
      'penalty': penalty.toJson(),
    };
  }
}

class Halftime {
  String home;
  String away;

  Halftime({required this.home, required this.away});

  factory Halftime.fromJson(Map<String, dynamic> json) {
    return Halftime(
      home: json['home']??"",
      away: json['away']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home': home,
      'away': away,
    };
  }
}

class Fulltime {
  String home;
  String away;

  Fulltime({required this.home, required this.away});

  factory Fulltime.fromJson(Map<String, dynamic> json) {
    return Fulltime(
      home: json['home']??"",
      away: json['away']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home': home,
      'away': away,
    };
  }
}

class Extratime {
  String home;
  String away;

  Extratime({required this.home, required this.away});

  factory Extratime.fromJson(Map<String, dynamic> json) {
    return Extratime(
      home: json['home']??"",
      away: json['away']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home': home,
      'away': away,
    };
  }
}

class Penalty {
  String home;
  String away;

  Penalty({required this.home, required this.away});

  factory Penalty.fromJson(Map<String, dynamic> json) {
    return Penalty(
      home: json['home']??"",
      away: json['away']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home': home,
      'away': away,
    };
  }
}


class Statistics {
  String team1Id;
  String owTeam1Id;
  String team1Name;
  String team2Id;
  String owTeam2Id;
  String team2Name;
  List<StatisticsData> data;

  Statistics({
    required this.team1Id,
    required this.owTeam1Id,
    required this.team1Name,
    required this.team2Id,
    required this.owTeam2Id,
    required this.team2Name,
    required this.data,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      team1Id: json['team_1_id']??"",
      owTeam1Id: json['ow_team_1_id']??"",
      team1Name: json['team_1_name']??"",
      team2Id: json['team_2_id']??"",
      owTeam2Id: json['ow_team_2_id']??"",
      team2Name: json['team_2_name']??"",
      data: List<StatisticsData>.from(
        json['data'].map((item) => StatisticsData.fromJson(item)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'team_1_id': team1Id,
      'ow_team_1_id': owTeam1Id,
      'team_1_name': team1Name,
      'team_2_id': team2Id,
      'ow_team_2_id': owTeam2Id,
      'team_2_name': team2Name,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class StatisticsData {
  String type;
  String matches;
  String team1Percent;
  String team2Percent;
  String drawPercent;

  StatisticsData({
    required this.type,
    required this.matches,
    required this.team1Percent,
    required this.team2Percent,
    required this.drawPercent,
  });

  factory StatisticsData.fromJson(Map<String, dynamic> json) {
    return StatisticsData(
      type: json['type']??"",
      matches: json['fixture']??"",
      team1Percent: json['team_1_percent']??"",
      team2Percent: json['team_2_percent']??"",
      drawPercent: json['draw_percent']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'fixture': matches,
      'team_1_percent': team1Percent,
      'team_2_percent': team2Percent,
      'draw_percent': drawPercent,
    };
  }
}

class Summary {
  final TeamStats firstTeam;
  final TeamStats secondTeam;
  final int draws;

  Summary({
    required this.firstTeam,
    required this.secondTeam,
    required this.draws,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      firstTeam: TeamStats.fromJson(json['firstTeam']),
      secondTeam: TeamStats.fromJson(json['secondTeam']),
      draws: json['draws'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstTeam': firstTeam.toJson(),
      'secondTeam': secondTeam.toJson(),
      'draws': draws,
    };
  }
}

class TeamStats {
  final String name;
  final int wins;

  TeamStats({
    required this.name,
    required this.wins,
  });

  factory TeamStats.fromJson(Map<String, dynamic> json) {
    return TeamStats(
      name: json['name'],
      wins: json['wins'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'wins': wins,
    };
  }
}

