class PlayerModel {
  final Person person;
  final TeamCareer teamCareer;
  final List<CompetitionCareer> competitionCareer;

  PlayerModel({
    required this.person,
    required this.teamCareer,
    required this.competitionCareer,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      person: Person.fromJson(json['person']),
      teamCareer: TeamCareer.fromJson(json['team_career']),
      competitionCareer: json['competition_career'] is List
          ? CompetitionCareer.listFromJson(json['competition_career'])
          : [CompetitionCareer.fromJson(json['competition_career'])],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'person': person.toJson(),
      'team_career': teamCareer.toJson(),
      'competition_career': competitionCareer,
    };
  }
}

class Person {
  final String peopleId;
  final String personId;
  final String owPersonId;
  final String name;
  final String type;
  final String position;
  final String lastUpdated;
  final String nationalityId;
  final String nationality;
  final String firstName;
  final String middleName;
  final String lastName;
  final String dateOfBirth;
  final String placeOfBirth;
  final String countryOfBirthId;
  final String countryOfBirth;
  final String height;
  final String? weight;
  final String? foot;
  final String status;
  final List<Membership> membership;

  Person({
    required this.peopleId,
    required this.personId,
    required this.owPersonId,
    required this.name,
    required this.type,
    required this.position,
    required this.lastUpdated,
    required this.nationalityId,
    required this.nationality,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dateOfBirth,
    required this.placeOfBirth,
    required this.countryOfBirthId,
    required this.countryOfBirth,
    required this.height,
    this.weight,
    this.foot,
    required this.status,
    required this.membership,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      peopleId: json['people_id'],
      personId: json['person_id'],
      owPersonId: json['ow_person_id'],
      name: json['name'],
      type: json['type'],
      position: json['position'],
      lastUpdated: json['last_updated'],
      nationalityId: json['nationality_id'],
      nationality: json['nationality'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      dateOfBirth: json['date_of_birth'],
      placeOfBirth: json['place_of_birth'],
      countryOfBirthId: json['country_of_birth_id'],
      countryOfBirth: json['country_of_birth'],
      height: json['height'],
      weight: json['weight'],
      foot: json['foot'],
      status: json['status'],
      membership: json['membership'] is List
          ? Membership.listFromJson(json['membership'])
          : [Membership.fromJson(json['membership'])]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'people_id': peopleId,
      'person_id': personId,
      'ow_person_id': owPersonId,
      'name': name,
      'type': type,
      'position': position,
      'last_updated': lastUpdated,
      'nationality_id': nationalityId,
      'nationality': nationality,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth,
      'place_of_birth': placeOfBirth,
      'country_of_birth_id': countryOfBirthId,
      'country_of_birth': countryOfBirth,
      'height': height,
      'weight': weight,
      'foot': foot,
      'status': status,
      'membership': membership,
    };
  }
}

class Membership {
  final String teamPeopleId;
  final String teamId;
  final String owTeamId;
  final String teamType;
  final String clubName;
  final String active;
  final String startDate;
  final String endDate;
  final String role;
  final List<Statistics> statistics;

  Membership({
    required this.teamPeopleId,
    required this.teamId,
    required this.owTeamId,
    required this.teamType,
    required this.clubName,
    required this.active,
    required this.startDate,
    required this.endDate,
    required this.role,
    required this.statistics,
  });

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
      teamPeopleId: json['team_people_id'],
      teamId: json['team_id'],
      owTeamId: json['ow_team_id'],
      teamType: json['team_type'],
      clubName: json['club_name'],
      active: json['active'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      role: json['role'],
      statistics: json['statistics'] is List
          ? Statistics.listFromJson(json['statistics'])
          : [Statistics.fromJson(json['statistics'])]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'team_people_id': teamPeopleId,
      'team_id': teamId,
      'ow_team_id': owTeamId,
      'team_type': teamType,
      'club_name': clubName,
      'active': active,
      'start_date': startDate,
      'end_date': endDate,
      'role': role,
      'statistics': statistics,

    };
  }

  static List<Membership> listFromJson(List jsonData){
    return jsonData.map((e) => Membership.fromJson(e)).toList();
  }
}

class Statistics {
  final String competitionId;
  final String owCompetitionId;
  final String competitionName;
  final String seasonId;
  final String seasonName;
  final String goals;
  final String assists;
  final String penaltyGoals;
  final String appearances;
  final String yellowCards;
  final String secondYellowCards;
  final String redCards;
  final String substituteIn;
  final String substituteOut;
  final String subsOnBench;
  final String minutesPlayed;
  final String? shirtnumber;

  Statistics({
    required this.competitionId,
    required this.owCompetitionId,
    required this.competitionName,
    required this.seasonId,
    required this.seasonName,
    required this.goals,
    required this.assists,
    required this.penaltyGoals,
    required this.appearances,
    required this.yellowCards,
    required this.secondYellowCards,
    required this.redCards,
    required this.substituteIn,
    required this.substituteOut,
    required this.subsOnBench,
    required this.minutesPlayed,
    this.shirtnumber,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      competitionId: json['competition_id'],
      owCompetitionId: json['ow_competition_id'],
      competitionName: json['competition_name'],
      seasonId: json['season_id'],
      seasonName: json['season_name'],
      goals: json['goals'],
      assists: json['assists'],
      penaltyGoals: json['penalty_goals'],
      appearances: json['appearances'],
      yellowCards: json['yellow_cards'],
      secondYellowCards: json['second_yellow_cards'],
      redCards: json['red_cards'],
      substituteIn: json['substitute_in'],
      substituteOut: json['substitute_out'],
      subsOnBench: json['subs_on_bench'],
      minutesPlayed: json['minutes_played'],
      shirtnumber: json['shirtnumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'competition_id': competitionId,
      'ow_competition_id': owCompetitionId,
      'competition_name': competitionName,
      'season_id': seasonId,
      'season_name': seasonName,
      'goals': goals,
      'assists': assists,
      'penalty_goals': penaltyGoals,
      'appearances': appearances,
      'yellow_cards': yellowCards,
      'second_yellow_cards': secondYellowCards,
      'red_cards': redCards,
      'substitute_in': substituteIn,
      'substitute_out': substituteOut,
      'subs_on_bench': subsOnBench,
      'minutes_played': minutesPlayed,
      'shirtnumber': shirtnumber,
    };
  }

  static List<Statistics> listFromJson(List jsonData){
    return jsonData.map((e) => Statistics.fromJson(e)).toList();
  }
}

class TeamCareer {
  final List<Club> club;
  final List national;

  TeamCareer({
    required this.club,
    required this.national,
  });

  factory TeamCareer.fromJson(Map<String, dynamic> json) {
    return TeamCareer(
      club: json['club'] is List
          ? Club.listFromJson(json['club'])
          : [Club.fromJson(json['club'])],
      national: json['national'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'club': club,
      'national': national,
    };
  }
}

class Club {
  final String clubName;
  final String teamId;
  final String teamType;
  final String startDate;
  final String endDate;
  final String role;
  final String active;
  final StatisticsInClub statistics;

  Club({
    required this.clubName,
    required this.teamId,
    required this.teamType,
    required this.startDate,
    required this.endDate,
    required this.role,
    required this.active,
    required this.statistics,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      clubName: json['club_name'],
      teamId: json['team_id'],
      teamType: json['team_type'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      role: json['role'],
      active: json['active'],
      statistics: StatisticsInClub.fromJson(json['statistics']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'club_name': clubName,
      'team_id': teamId,
      'team_type': teamType,
      'start_date': startDate,
      'end_date': endDate,
      'role': role,
      'active': active,
      'statistics': StatisticsInClub,
    };
  }

  static List<Club> listFromJson(List jsonData){
    return jsonData.map((e) => Club.fromJson(e)).toList();
  }
}

class StatisticsInClub {
  final int minutesPlayed;
  final int goals;
  final int secondYellowCards;
  final int redCards;
  final int appearances;

  StatisticsInClub({
    required this.minutesPlayed,
    required this.goals,
    required this.secondYellowCards,
    required this.redCards,
    required this.appearances,
  });

  factory StatisticsInClub.fromJson(Map<String, dynamic> json) {
    return StatisticsInClub(
      minutesPlayed: json['minutes_played'] ?? 0,
      goals: json['goals'] ?? 0,
      secondYellowCards: json['second_yellow_cards'] ?? 0,
      redCards: json['red_cards'] ?? 0,
      appearances: json['appearances'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'minutes_played': minutesPlayed,
      'goals': goals,
      'second_yellow_cards': secondYellowCards,
      'red_cards': redCards,
      'appearances': appearances,
    };
  }
}


class CompetitionCareer {
  final String competitionName;
  final String competitionId;
  final String seasonName;
  final String seasonId;
  final String teamName;
  final String teamId;
  final String active;

  CompetitionCareer({
    required this.competitionName,
    required this.competitionId,
    required this.seasonName,
    required this.seasonId,
    required this.teamName,
    required this.teamId,
    required this.active,
  });

  factory CompetitionCareer.fromJson(Map<String, dynamic> json) {
    return CompetitionCareer(
      competitionName: json['competition_name'],
      competitionId: json['competition_id'],
      seasonName: json['season_name'],
      seasonId: json['season_id'],
      teamName: json['team_name'],
      teamId: json['team_id'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'competition_name': competitionName,
      'competition_id': competitionId,
      'season_name': seasonName,
      'season_id': seasonId,
      'team_name': teamName,
      'team_id': teamId,
      'active': active,
    };
  }

  static List<CompetitionCareer> listFromJson(List jsonData){
    return jsonData.map((e) => CompetitionCareer.fromJson(e)).toList();
  }
}