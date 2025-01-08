

class TeamFormModel {
  final List<FixtureDetail> teamForm1;
  final List<FixtureDetail> teamForm2;

  TeamFormModel({required this.teamForm1, required this.teamForm2});

  factory TeamFormModel.fromJson(Map<String, dynamic> json) {
    return TeamFormModel(
      teamForm1: (json['teamForm1'] as List).map((item) => FixtureDetail.fromJson(item)).toList(),
      teamForm2: (json['teamForm2'] as List).map((item) => FixtureDetail.fromJson(item)).toList(),
    );
  }
}

class FixtureDetail {
  final Fixture fixture;
  final League league;
  final Teams teams;
  final Goals goals;
  final Score score;

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

  static List<FixtureDetail> listFromJson(List jsonData){
    return jsonData.map((e) => FixtureDetail.fromJson(e)).toList();
  }
}

class Fixture {
  final String id;
  final String? referee;
  final String timezone;
  final String date;
  final int? timestamp;
  final Periods periods;
  final Status status;

  Fixture({
    required this.id,
    required this.referee,
    required this.timezone,
    required this.date,
    required this.timestamp,
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
}

class Periods {
  final String first;
  final String second;

  Periods({required this.first, required this.second});

  factory Periods.fromJson(Map<String, dynamic> json) {
    return Periods(
      first: json['first']??"",
      second: json['second']??"",
    );
  }
}

class Status {
  final String long;
  final String short;
  final int? elapsed;

  Status({required this.long, required this.short, this.elapsed});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      long: json['long']??"",
      short: json['short']??"",
      elapsed: json['elapsed']??0,
    );
  }
}

class League {
  final String id;
  final String name;
  final String country;
  final String? logo;
  final String? flag;
  final String season;
  final String round;

  League({
    required this.id,
    required this.name,
    required this.country,
    this.logo,
    this.flag,
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
}

class Teams {
  final Team home;
  final Team away;

  Teams({required this.home, required this.away});

  factory Teams.fromJson(Map<String, dynamic> json) {
    return Teams(
      home: Team.fromJson(json['home']),
      away: Team.fromJson(json['away']),
    );
  }
}

class Team {
  final String id;
  final String name;
  final String? logo;
  final String? winner;

  Team({required this.id, required this.name, this.logo, this.winner});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id']??"",
      name: json['name']??"",
      logo: json['logo']??"",
      winner: json['winner']??"",
    );
  }
}

class Goals {
  final int home;
  final int away;

  Goals({required this.home, required this.away});

  factory Goals.fromJson(Map<String, dynamic> json) {
    return Goals(
      home: json['home']??"",
      away: json['away']??"",
    );
  }
}

class Score {
  final HalfTime halftime;
  final FullTime fulltime;
  final ExtraTime extratime;
  final Penalty penalty;

  Score({
    required this.halftime,
    required this.fulltime,
    required this.extratime,
    required this.penalty,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      halftime: HalfTime.fromJson(json['halftime']),
      fulltime: FullTime.fromJson(json['fulltime']),
      extratime: ExtraTime.fromJson(json['extratime']),
      penalty: Penalty.fromJson(json['penalty']),
    );
  }
}

class HalfTime {
  final String home;
  final String away;

  HalfTime({required this.home, required this.away});

  factory HalfTime.fromJson(Map<String, dynamic> json) {
    return HalfTime(
      home: json['home']??"",
      away: json['away']??"",
    );
  }
}

class FullTime {
  final String home;
  final String away;

  FullTime({required this.home, required this.away});

  factory FullTime.fromJson(Map<String, dynamic> json) {
    return FullTime(
      home: json['home']??"",
      away: json['away']??"",
    );
  }
}

class ExtraTime {
  final String home;
  final String away;

  ExtraTime({required this.home, required this.away});

  factory ExtraTime.fromJson(Map<String, dynamic> json) {
    return ExtraTime(
      home: json['home']??"",
      away: json['away']??"",
    );
  }
}

class Penalty {
  final String home;
  final String away;

  Penalty({required this.home, required this.away});

  factory Penalty.fromJson(Map<String, dynamic> json) {
    return Penalty(
      home: json['home']??"",
      away: json['away']??"",
    );
  }
}
