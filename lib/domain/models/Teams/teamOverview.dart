
import '../News.dart';

class TeamOverviewModel {
  final String teamName;
  final String teamId;
  List<FixtureOverview> fixtures;
  final News news;
  final PlayerStatistics playersStatistics;

  TeamOverviewModel({
    required this.teamName,
    required this.teamId,
    required this.fixtures,
    required this.news,
    required this.playersStatistics,
  });

  factory TeamOverviewModel.fromJson(Map<String, dynamic> json) {
    return TeamOverviewModel(
      teamName: json['team_name']??"",
      teamId: json['team_id']??"",
      fixtures: (json['fixtures'] as List).map((doc) => FixtureOverview.fromJson(doc)).toList(),
      news: News.fromJson(json['news']),
      playersStatistics: PlayerStatistics.fromJson(json['players_statistics']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'team_name': teamName,
      'team_id': teamId,
      'fixtures': fixtures,
      'news': news.toJson(),
      'players_statistics': playersStatistics.toJson(),
    };
  }
}

class FixtureOverview {
  final FixtureDetailOverview fixture;
  final League league;
  final Teams teams;
  final Goals goals;
  final Score score;

  FixtureOverview({
    required this.fixture,
    required this.league,
    required this.teams,
    required this.goals,
    required this.score,
  });

  factory FixtureOverview.fromJson(Map<String, dynamic> json) {
    return FixtureOverview(
      fixture: FixtureDetailOverview.fromJson(json['fixture']),
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

  static List<FixtureOverview> listFromJson(List jsonData){
    return jsonData.map((e) => FixtureOverview.fromJson(e)).toList();
  }
}

class FixtureDetailOverview {
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

  FixtureDetailOverview({
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
  });

  factory FixtureDetailOverview.fromJson(Map<String, dynamic> json) {
    return FixtureDetailOverview(
      id: json['id']??"",
      referee: json['referee']??"",
      timezone: json['timezone']??"",
      groupName: json['group_name']??"",
      groupId: json['group_id']??"",
      date: json['date']??"",
      timestamp: json['timestamp']??1,
      periods: Periods.fromJson(json['periods']),
      venue: Venue.fromJson(json['venue']),
      status: Status.fromJson(json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'referee': referee,
      'timezone': timezone,
      'group_name': groupName,
      'group_id': groupId,
      'date': date,
      'timestamp': timestamp,
      'periods': periods.toJson(),
      'venue': venue.toJson(),
      'status': status.toJson(),
    };
  }

  static List<FixtureDetailOverview> listFromJson(List jsonData){
    return jsonData.map((e) => FixtureDetailOverview.fromJson(e)).toList();
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

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'second': second,
    };
  }
}

class Venue {
  final String id;
  final String name;
  final String city;

  Venue({required this.id, required this.name, required this.city});

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id']??"",
      name: json['name']??"",
      city: json['city']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city': city,
    };
  }
}

class Status {
  final String long;
  final String short;
  final String elapsed;

  Status({required this.long, required this.short, required this.elapsed});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      long: json['long']??"",
      short: json['short']??"",
      elapsed: json['elapsed']??"",
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'logo': logo,
      'flag': flag,
      'season': season,
      'round': round.toJson(),
    };
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
      hasOutgroupMatches: json['has_outgroup_matches']??"",
      lastUpdated: json['last_updated']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'round_id': roundId,
      'name': name,
      'start_date': startDate,
      'end_date': endDate,
      'type': type,
      'groups': groups,
      'has_outgroup_matches': hasOutgroupMatches,
      'last_updated': lastUpdated,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'home': home.toJson(),
      'away': away.toJson(),
    };
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
  final int home;
  final int away;

  Goals({required this.home, required this.away});

  factory Goals.fromJson(Map<String, dynamic> json) {
    return Goals(
      home: json['home']??0,
      away: json['away']??0,
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

  Map<String, dynamic> toJson() {
    return {
      'halftime': halftime.toJson(),
      'fulltime': fulltime.toJson(),
      'extratime': extratime.toJson(),
      'penalty': penalty.toJson(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'home': home,
      'away': away,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'home': home,
      'away': away,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'home': home,
      'away': away,
    };
  }
}

class Penalty {
  final String home;
  final String away;

  Penalty({required this.home, required this.away});

  factory Penalty.fromJson(Map<String, dynamic> json) {
    return Penalty(
      home: json['home']??'',
      away: json['away']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home': home,
      'away': away,
    };
  }
}


class News {
  final List<NewsModel> documents;
  String type;

  News({required this.documents, required this.type});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      documents: (json['documents'] as List).map((doc) => NewsModel.fromJson(doc)).toList(),
      type: json['type']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'documents': documents.map((doc) => doc.toJson()).toList(),
      'type': type
    };
  }
}


class PlayerStatistics {
  final String version;
  final String sport;
  final String lang;
  final String lastGenerated;
  final Method method;
  final Competition competition;

  PlayerStatistics({
    required this.version,
    required this.sport,
    required this.lang,
    required this.lastGenerated,
    required this.method,
    required this.competition,
  });

  factory PlayerStatistics.fromJson(Map<String, dynamic> json) {
    return PlayerStatistics(
      version: json['version']??"",
      sport: json['sport']??"",
      lang: json['lang']??"",
      lastGenerated: json['last_generated']??"",
      method: Method.fromJson(json['method']),
      competition: Competition.fromJson(json['competition']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'sport': sport,
      'lang': lang,
      'last_generated': lastGenerated,
      'method': method.toJson(),
      'competition': competition.toJson(),
    };
  }
}

class Method {
  final String methodId;
  final String name;
  final List<Parameter> parameter;

  Method({
    required this.methodId,
    required this.name,
    required this.parameter,
  });

  factory Method.fromJson(Map<String, dynamic> json) {
    return Method(
      methodId: json['method_id']??"",
      name: json['name']??"",
      parameter: (json['parameter'] as List).map((param) => Parameter.fromJson(param)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'method_id': methodId,
      'name': name,
      'parameter': parameter.map((param) => param.toJson()).toList(),
    };
  }
}

class Parameter {
  final String name;
  final String value;

  Parameter({required this.name, required this.value});

  factory Parameter.fromJson(Map<String, dynamic> json) {
    return Parameter(
      name: json['name']??"",
      value: json['value']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
    };
  }
}

class Competition {
  final String competitionId;
  final String owCompetitionId;
  final String name;
  final String teamType;
  final String displayOrder;
  final String type;
  final String areaId;
  final String areaName;
  final String lastUpdated;
  final String soccerType;
  final Season season;

  Competition({
    required this.competitionId,
    required this.owCompetitionId,
    required this.name,
    required this.teamType,
    required this.displayOrder,
    required this.type,
    required this.areaId,
    required this.areaName,
    required this.lastUpdated,
    required this.soccerType,
    required this.season,
  });

  factory Competition.fromJson(Map<String, dynamic> json) {
    return Competition(
      competitionId: json['competition_id']??"",
      owCompetitionId: json['ow_competition_id']??"",
      name: json['name']??"",
      teamType: json['teamtype']??"",
      displayOrder: json['display_order']??"",
      type: json['type']??"",
      areaId: json['area_id']??"",
      areaName: json['area_name']??"",
      lastUpdated: json['last_updated']??"",
      soccerType: json['soccertype']??"",
      season: Season.fromJson(json['season']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'competition_id': competitionId,
      'ow_competition_id': owCompetitionId,
      'name': name,
      'teamtype': teamType,
      'display_order': displayOrder,
      'type': type,
      'area_id': areaId,
      'area_name': areaName,
      'last_updated': lastUpdated,
      'soccertype': soccerType,
      'season': season.toJson(),
    };
  }
}

class Season {
  final String seasonId;
  final String name;
  final String startDate;
  final String endDate;
  final String serviceLevel;
  final String lastUpdated;
  final dynamic yellowCards;
  final dynamic redCards;
  final dynamic goals;
  final dynamic assists;

  Season({
    required this.seasonId,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.serviceLevel,
    required this.lastUpdated,
    required this.yellowCards,
    required this.redCards,
    required this.goals,
    required this.assists,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      seasonId: json['season_id']??"",
      name: json['name']??"",
      startDate: json['start_date']??"",
      endDate: json['end_date']??"",
      serviceLevel: json['service_level']??"",
      lastUpdated: json['last_updated']??"",
      yellowCards: json['yellow_cards'] == ""  ? "" : YellowCards.fromJson(json['yellow_cards']),
      redCards:json['red_cards'] == ""  ? "" : RedCards.fromJson(json['red_cards']),
      goals:json['goals'] == ""  ? "" : PersonGoals.fromJson(json['goals']),
      assists:json['yellow_cards'] == ""  ? "" :Assists.fromJson(json['assists']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'season_id': seasonId,
      'name': name,
      'start_date': startDate,
      'end_date': endDate,
      'service_level': serviceLevel,
      'last_updated': lastUpdated,
      'yellow_cards': yellowCards.toJson(),
      'red_cards': redCards.toJson(),
      'goals': goals.toJson(),
      'assists': assists.toJson(),
    };
  }
}

class YellowCards {
  final List<TeamOverviewPersonModel> person;

  YellowCards({required this.person});

  factory YellowCards.fromJson(Map<String, dynamic> json) {
    var personData = json['person'];
    return YellowCards(
      person: (personData is List
          ? personData
          : personData != null
          ? [personData]
          : [])
          .map((personJson) => TeamOverviewPersonModel.fromJson(personJson))
          .toList(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'person': person.map((p) => p.toJson()).toList(),
    };
  }
}

class RedCards {
  final List<TeamOverviewPersonModel> person;

  RedCards({required this.person});

  factory RedCards.fromJson(Map<String, dynamic> json) {
    var personData = json['person'];
    return RedCards(
      person: (personData is List
          ? personData
          : personData != null
          ? [personData]
          : [])
          .map((personJson) => TeamOverviewPersonModel.fromJson(personJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'person': person.map((p) => p.toJson()).toList(),
    };
  }
}

class PersonGoals {
  final List<TeamOverviewPersonModel> person;

  PersonGoals({required this.person});

  factory PersonGoals.fromJson(Map<String, dynamic> json) {
    var personData = json['person'];
    return PersonGoals(
        person: (personData is List
        ? personData
            : personData != null
        ? [personData]
        : [])
        .map((personJson) => TeamOverviewPersonModel.fromJson(personJson))
        .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'person': person.map((p) => p.toJson()).toList(),
    };
  }
}

class Assists {
  final List<TeamOverviewPersonModel> person;

  Assists({required this.person});

  factory Assists.fromJson(Map<String, dynamic> json) {
    var personData = json['person'];
    return Assists(
      person: (personData is List
          ? personData
          : personData != null
          ? [personData]
          : [])
          .map((personJson) => TeamOverviewPersonModel.fromJson(personJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'person': person.map((p) => p.toJson()).toList(),
    };
  }
}

class TeamOverviewPersonModel {
  final String personId;
  final String name;
  final String teamId;
  final String teamName;
  final String count;
  final String owPersonId;
  final String owTeamId;

  TeamOverviewPersonModel({
    required this.personId,
    required this.name,
    required this.teamId,
    required this.teamName,
    required this.count,
    required this.owPersonId,
    required this.owTeamId,
  });

  factory TeamOverviewPersonModel.fromJson(Map<String, dynamic> json) {
    return TeamOverviewPersonModel(
      personId: json['person_id'],
      name: json['name'],
      teamId: json['team_id'],
      teamName: json['team_name'],
      count: json['count'],
      owPersonId: json['ow_person_id'],
      owTeamId: json['ow_team_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'person_id': personId,
      'name': name,
      'team_id': teamId,
      'team_name': teamName,
      'count': count,
      'ow_person_id': owPersonId,
      'ow_team_id': owTeamId,
    };
  }
}

