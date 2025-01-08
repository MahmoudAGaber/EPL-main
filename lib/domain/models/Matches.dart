class MatchesModel {
  final League league;
  final List<MatchItem> items;

  MatchesModel({
    required this.league,
    required this.items,
  });

  factory MatchesModel.fromJson(Map<String, dynamic> json) {
    return MatchesModel(
      league: League.fromJson(json['league']),
      items: (json['items'] as List).map((item) => MatchItem.fromJson(item)).toList(),
    );
  }

  static List<MatchesModel> listFromJson(List jsonData){
    return jsonData.map((e) => MatchesModel.fromJson(e)).toList();
  }
}

class League {
  final String id;
  final String name;
  final String country;
  final String logo;
  final String? flag;
  final String season;
  final Round round;

  League({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
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
      round: Round.fromJson(json['round']),
    );
  }
}

class Round {
  final String roundId;
  final String name;
  final String startDate;
  final String endDate;
  final String type;
  final String groups;
  final String hasOutgroupMatches;
  final String lastUpdated;

  Round({
    required this.roundId,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.groups,
    required this.hasOutgroupMatches,
    required this.lastUpdated,
  });

  factory Round.fromJson(Map<String, dynamic> json) {
    return Round(
      roundId: json['round_id']??"",
      name: json['name']??"",
      startDate: json['start_date']??"",
      endDate: json['end_date']??"",
      type: json['type']??"",
      groups: json['groups']??"",
      hasOutgroupMatches: json['has_outgroup_matches'],
      lastUpdated: json['last_updated'],
    );
  }
}

class MatchItem {
  final Fixture fixture;
  final Goals goals;
  final Teams teams;
  final Score score;

  MatchItem({
    required this.fixture,
    required this.goals,
    required this.teams,
    required this.score,
  });

  factory MatchItem.fromJson(Map<String, dynamic> json) {
    return MatchItem(
      fixture: Fixture.fromJson(json['fixture']),
      goals: Goals.fromJson(json['goals']),
      teams: Teams.fromJson(json['teams']),
      score: Score.fromJson(json['score']),
    );
  }
}

class Fixture {
  final String id;
  final String referee;
  final String timezone;
  final String? groupName;
  final String groupId;
  final String date;
  final int timestamp;
  final Periods periods;
  final Venue venue;
  final Status status;
  final bool collectInfo;

  Fixture({
    required this.id,
    required this.referee,
    required this.timezone,
    this.groupName,
    required this.groupId,
    required this.date,
    required this.timestamp,
    required this.periods,
    required this.venue,
    required this.status,
    required this.collectInfo,
  });

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      id: json['id']??"",
      referee: json['referee']??"",
      timezone: json['timezone']??"",
      groupName: json['group_name']??"",
      groupId: json['group_id']??"",
      date: json['date']??"",
      timestamp: json['timestamp']??0,
      periods: Periods.fromJson(json['periods']),
      venue: Venue.fromJson(json['venue']),
      status: Status.fromJson(json['status']),
      collectInfo: json['collect_info']??false,
    );
  }
}

class Periods {
  final String first;
  final String second;

  Periods({
    required this.first,
    required this.second,
  });

  factory Periods.fromJson(Map<String, dynamic> json) {
    return Periods(
      first: json['first']??"",
      second: json['second']??"",
    );
  }
}

class Venue {
  final String id;
  final String name;
  final String city;

  Venue({
    required this.id,
    required this.name,
    required this.city,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id']??"",
      name: json['name']??"",
      city: json['city']??"",
    );
  }
}

class Status {
  final String long;
  final String short;
  final String elapsed;
  final String? extraTime;

  Status({
    required this.long,
    required this.short,
    required this.elapsed,
    this.extraTime,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      long: json['long']??"",
      short: json['short']??"",
      elapsed: json['elapsed']??"",
      extraTime: json['extratime']??"",
    );
  }
}

class Goals {
  final int home;
  final int away;

  Goals({
    required this.home,
    required this.away,
  });

  factory Goals.fromJson(Map<String, dynamic> json) {
    return Goals(
      home: json['home']??0,
      away: json['away']??0,
    );
  }
}

class Teams {
  final Team home;
  final Team away;

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
}

class Team {
  final String id;
  final String name;
  final String logo;
  final bool? winner;

  Team({
    required this.id,
    required this.name,
    required this.logo,
    this.winner,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id']??"",
      name: json['name']??"",
      logo: json['logo']??"",
      winner: json['winner']??false,
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

  HalfTime({
    required this.home,
    required this.away,
  });

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

  FullTime({
    required this.home,
    required this.away,
  });

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

  ExtraTime({
    required this.home,
    required this.away,
  });

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

  Penalty({
    required this.home,
    required this.away,
  });

  factory Penalty.fromJson(Map<String, dynamic> json) {
    return Penalty(
      home: json['home']??"",
      away: json['away']??"",
    );
  }
}
