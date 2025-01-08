class SquadModel {
  final String teamId;
  final String owTeamId;
  final String type;
  final String soccerType;
  final String teamType;
  final String clubName;
  final List<Person> person;

  SquadModel({
    required this.teamId,
    required this.owTeamId,
    required this.type,
    required this.soccerType,
    required this.teamType,
    required this.clubName,
    required this.person,
  });

  factory SquadModel.fromJson(Map<String, dynamic> json) {
    return SquadModel(
      teamId: json['team_id'] ?? '',
      owTeamId: json['ow_team_id'] ?? '',
      type: json['type'] ?? '',
      soccerType: json['soccertype'] ?? '',
      teamType: json['teamtype'] ?? '',
      clubName: json['club_name'] ?? '',
      person: (json['person'] as List<dynamic>?)
          ?.map((e) => Person.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'team_id': teamId,
      'ow_team_id': owTeamId,
      'type': type,
      'soccertype': soccerType,
      'teamtype': teamType,
      'club_name': clubName,
      'person': person.map((e) => e.toJson()).toList(),
    };
  }
}

class Person {
  final String personId;
  final String owPersonId;
  final String name;
  final String type;
  final String position;
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
  final String weight;
  final String foot;
  final String status;
  final String internationalCaps;
  final String internationalGoals;
  final Statistics statistics;

  Person({
    required this.personId,
    required this.owPersonId,
    required this.name,
    required this.type,
    required this.position,
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
    required this.weight,
    required this.foot,
    required this.status,
    required this.internationalCaps,
    required this.internationalGoals,
    required this.statistics,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      personId: json['person_id'] ?? '',
      owPersonId: json['ow_person_id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      position: json['position'] ?? '',
      nationalityId: json['nationality_id'] ?? '',
      nationality: json['nationality'] ?? '',
      firstName: json['first_name'] ?? '',
      middleName: json['middle_name'] ?? '',
      lastName: json['last_name'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      placeOfBirth: json['place_of_birth'] ?? '',
      countryOfBirthId: json['country_of_birth_id'] ?? '',
      countryOfBirth: json['country_of_birth'] ?? '',
      height: json['height'] ?? '',
      weight: json['weight'] ?? '',
      foot: json['foot'] ?? '',
      status: json['status'] ?? '',
      internationalCaps: json['international_caps'] ?? '',
      internationalGoals: json['international_goals'] ?? '',
      statistics: Statistics.fromJson(json['statistics'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'person_id': personId,
      'ow_person_id': owPersonId,
      'name': name,
      'type': type,
      'position': position,
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
      'international_caps': internationalCaps,
      'international_goals': internationalGoals,
      'statistics': statistics.toJson(),
    };
  }
}

class Statistics {
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
  final String shirtNumber;

  Statistics({
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
    required this.shirtNumber,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      seasonId: json['season_id'] ?? '',
      seasonName: json['season_name'] ?? '',
      goals: json['goals'] ?? '',
      assists: json['assists'] ?? '',
      penaltyGoals: json['penalty_goals'] ?? '',
      appearances: json['appearances'] ?? '',
      yellowCards: json['yellow_cards'] ?? '',
      secondYellowCards: json['second_yellow_cards'] ?? '',
      redCards: json['red_cards'] ?? '',
      substituteIn: json['substitute_in'] ?? '',
      substituteOut: json['substitute_out'] ?? '',
      subsOnBench: json['subs_on_bench'] ?? '',
      minutesPlayed: json['minutes_played'] ?? '',
      shirtNumber: json['shirtnumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'shirtnumber': shirtNumber,
    };
  }
}
