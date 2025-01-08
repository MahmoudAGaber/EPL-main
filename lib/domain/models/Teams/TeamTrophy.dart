class TrophyModel {
  final Competition competition;
  final List<TeamResult> firstPlace;
  final List<TeamResult> secondPlace;

  TrophyModel({
    required this.competition,
    required this.firstPlace,
    required this.secondPlace,
  });

  factory TrophyModel.fromJson(Map<String, dynamic> json) {
    return TrophyModel(
      competition: Competition.fromJson(json['competition']),
      firstPlace: (json['first_place'] as List<dynamic>).map((item) => TeamResult.fromJson(item)).toList(),
      secondPlace: (json['second_place'] as List<dynamic>).map((item) => TeamResult.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'competition': competition.toJson(),
      'first_place': firstPlace.map((e) => e.toJson()).toList(),
      'second_place': secondPlace.map((e) => e.toJson()).toList(),
    };
  }

  static List<TrophyModel> listFromJson(List jsonData){
    return jsonData.map((e) => TrophyModel.fromJson(e)).toList();
  }
}

class Competition {
  final String competitionId;
  final String owCompetitionId;
  final String competitionName;
  final String teamType;
  final String competitionType;
  final String areaId;
  final String areaName;
  final String lastUpdated;
  final String seasonId;
  final String name;
  final String startDate;
  final String endDate;

  Competition({
    required this.competitionId,
    required this.owCompetitionId,
    required this.competitionName,
    required this.teamType,
    required this.competitionType,
    required this.areaId,
    required this.areaName,
    required this.lastUpdated,
    required this.seasonId,
    required this.name,
    required this.startDate,
    required this.endDate,
  });

  factory Competition.fromJson(Map<String, dynamic> json) {
    return Competition(
      competitionId: json['competition_id']??"",
      owCompetitionId: json['ow_competition_id']??"",
      competitionName: json['competition_name']??"",
      teamType: json['teamtype'],
      competitionType: json['competition_type']??"",
      areaId: json['area_id']??"",
      areaName: json['area_name']??"",
      lastUpdated: json['last_updated']??"",
      seasonId: json['season_id']??"",
      name: json['name']??"",
      startDate: json['start_date']??"",
      endDate: json['end_date']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'competition_id': competitionId,
      'ow_competition_id': owCompetitionId,
      'competition_name': competitionName,
      'teamtype': teamType,
      'competition_type': competitionType,
      'area_id': areaId,
      'area_name': areaName,
      'last_updated': lastUpdated,
      'season_id': seasonId,
      'name': name,
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}

class TeamResult {
  final String? seasonTitle;
  final String winnerTeamId;
  final String winnerName;
  final String winnerArea;
  final String runnerupTeamId;
  final String runnerupName;
  final String runnerupArea;
  final String owWinnerTeamId;
  final String owRunnerupTeamId;
  final String? trophyId;
  final String startDate;
  final String endDate;

  TeamResult({
    this.seasonTitle,
    required this.winnerTeamId,
    required this.winnerName,
    required this.winnerArea,
    required this.runnerupTeamId,
    required this.runnerupName,
    required this.runnerupArea,
    required this.owWinnerTeamId,
    required this.owRunnerupTeamId,
    this.trophyId,
    required this.startDate,
    required this.endDate,
  });

  factory TeamResult.fromJson(Map<String, dynamic> json) {
    return TeamResult(
      seasonTitle: json['season_title']??"",
      winnerTeamId: json['winner_team_id']??"",
      winnerName: json['winner_name']??"",
      winnerArea: json['winner_area']??"",
      runnerupTeamId: json['runnerup_team_id']??"",
      runnerupName: json['runnerup_name']??"",
      runnerupArea: json['runnerup_area']??"",
      owWinnerTeamId: json['ow_winner_team_id']??"",
      owRunnerupTeamId: json['ow_runnerup_team_id']??"",
      trophyId: json['trophy_id']??"",
      startDate: json['start_date']??"",
      endDate: json['end_date']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'season_title': seasonTitle,
      'winner_team_id': winnerTeamId,
      'winner_name': winnerName,
      'winner_area': winnerArea,
      'runnerup_team_id': runnerupTeamId,
      'runnerup_name': runnerupName,
      'runnerup_area': runnerupArea,
      'ow_winner_team_id': owWinnerTeamId,
      'ow_runnerup_team_id': owRunnerupTeamId,
      'trophy_id': trophyId,
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}
