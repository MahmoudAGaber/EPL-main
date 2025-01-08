class MatchInfoModel {
  Fixture fixture;
  League league;
  Teams teams;
  Goals goals;
  Score score;
  DetailedMinutes? detailedMinutes;

  MatchInfoModel({
    required this.fixture,
    required this.league,
    required this.teams,
    required this.goals,
    required this.score,
    this.detailedMinutes,
  });

  factory MatchInfoModel.fromJson(Map<String, dynamic> json) {
    return MatchInfoModel(
      fixture: Fixture.fromJson(json['fixture']),
      league: League.fromJson(json['league']),
      teams: Teams.fromJson(json['teams']),
      goals: Goals.fromJson(json['goals']),
      score: Score.fromJson(json['score']),
      detailedMinutes: json['detailedMinutes'] != null
          ? DetailedMinutes.fromJson(json['detailedMinutes'])
          : DetailedMinutes(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fixture': fixture.toJson(),
      'league': league.toJson(),
      'teams': teams.toJson(),
      'goals': goals.toJson(),
      'score': score.toJson(),
      'detailedMinutes': detailedMinutes?.toJson(),
    };
  }
}

class Fixture {
  String id;
  String? referee;
  String timezone;
  String date;
  int timestamp;
  Periods? periods;
  Venue? venue;
  Status? status;
  bool collectInfo;

  Fixture({
    required this.id,
    this.referee,
    required this.timezone,
    required this.date,
    required this.timestamp,
    this.periods,
    this.venue,
    this.status,
    required this.collectInfo,
  });

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      id: json['id'] ?? "",
      referee: json['referee'],
      timezone: json['timezone'] ?? "",
      date: json['date'] ?? "",
      timestamp: json['timestamp'] ?? 0,
      periods: json['periods'] != null ? Periods.fromJson(json['periods']) : null,
      venue: json['venue'] != null ? Venue.fromJson(json['venue']) : null,
      status: json['status'] != null ? Status.fromJson(json['status']) : null,
      collectInfo: json['collect_info'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'referee': referee,
      'timezone': timezone,
      'date': date,
      'timestamp': timestamp,
      'periods': periods?.toJson(),
      'venue': venue?.toJson(),
      'status': status?.toJson(),
      'collect_info': collectInfo,
    };
  }
}

class Periods {
  String? first;
  String? second;

  Periods({
    this.first,
    this.second,
  });

  factory Periods.fromJson(Map<String, dynamic> json) {
    return Periods(
      first: json['first'],
      second: json['second'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'second': second,
    };
  }
}

class Venue {
  String id;
  String? name;
  String? city;
  String? area;

  Venue({
    required this.id,
    this.name,
    this.city,
    this.area,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'] ?? "",
      name: json['name'],
      city: json['city'],
      area: json['area'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'area': area,
    };
  }
}

class Status {
  String? long;
  String? shortStatus;

  Status({
    this.long,
    this.shortStatus,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      long: json['long'],
      shortStatus: json['short'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'long': long,
      'short': shortStatus,
    };
  }
}

class League {
  String id;
  String? name;
  String? country;
  String? logo;
  String? flag;
  String? season;
  String? round;

  League({
    required this.id,
    this.name,
    this.country,
    this.logo,
    this.flag,
    this.season,
    this.round,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'] ?? "",
      name: json['name'],
      country: json['country'],
      logo: json['logo'],
      flag: json['flag'],
      season: json['season'],
      round: json['round'],
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

  Teams({
    required this.home,
    required this.away,
  });

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
  String? name;
  String? logo;
  dynamic winner;

  Team({
    required this.id,
    this.name,
    this.logo,
    this.winner,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'] ?? "",
      name: json['name'],
      logo: json['logo'],
      winner: json['winner']?? "",
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
  int home;
  int away;

  Goals({
    required this.home,
    required this.away,
  });

  factory Goals.fromJson(Map<String, dynamic> json) {
    return Goals(
      home: json['home'] ?? 0,
      away: json['away'] ?? 0,
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
  HalfTime? halftime;
  FullTime? fulltime;
  ExtraTime? extratime;
  Penalty? penalty;

  Score({
    this.halftime,
    this.fulltime,
    this.extratime,
    this.penalty,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      halftime: json['halftime'] != null ? HalfTime.fromJson(json['halftime']) : null,
      fulltime: json['fulltime'] != null ? FullTime.fromJson(json['fulltime']) : null,
      extratime: json['extratime'] != null ? ExtraTime.fromJson(json['extratime']) : null,
      penalty: json['penalty'] != null ? Penalty.fromJson(json['penalty']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'halftime': halftime?.toJson(),
      'fulltime': fulltime?.toJson(),
      'extratime': extratime?.toJson(),
      'penalty': penalty?.toJson(),
    };
  }
}

class HalfTime {
  String? home;
  String? away;

  HalfTime({
    this.home,
    this.away,
  });

  factory HalfTime.fromJson(Map<String, dynamic> json) {
    return HalfTime(
      home: json['home'],
      away: json['away'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home': home,
      'away': away,
    };
  }
}

class FullTime {
  String? home;
  String? away;

  FullTime({
    this.home,
    this.away,
  });

  factory FullTime.fromJson(Map<String, dynamic> json) {
    return FullTime(
      home: json['home'],
      away: json['away'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home': home,
      'away': away,
    };
  }
}

class ExtraTime {
  String? home;
  String? away;

  ExtraTime({
    this.home,
    this.away,
  });

  factory ExtraTime.fromJson(Map<String, dynamic> json) {
    return ExtraTime(
      home: json['home'],
      away: json['away'],
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
  String? home;
  String? away;

  Penalty({
    this.home,
    this.away,
  });

  factory Penalty.fromJson(Map<String, dynamic> json) {
    return Penalty(
      home: json['home'],
      away: json['away'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home': home,
      'away': away,
    };
  }
}

class DetailedMinutes {
  List<MinuteDetails>? minuteDetails;

  DetailedMinutes({
    this.minuteDetails,
  });

  factory DetailedMinutes.fromJson(Map<String, dynamic> json) {
    var minuteDetails = json['minuteDetails'] as List?;
    return DetailedMinutes(
      minuteDetails: minuteDetails != null
          ? minuteDetails.map((e) => MinuteDetails.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'minuteDetails': minuteDetails?.map((e) => e.toJson()).toList(),
    };
  }
}

class MinuteDetails {
  int minute;
  String? type;
  String? detail;

  MinuteDetails({
    required this.minute,
    this.type,
    this.detail,
  });

  factory MinuteDetails.fromJson(Map<String, dynamic> json) {
    return MinuteDetails(
      minute: json['minute'] ?? 0,
      type: json['type'],
      detail: json['detail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'minute': minute,
      'type': type,
      'detail': detail,
    };
  }
}
