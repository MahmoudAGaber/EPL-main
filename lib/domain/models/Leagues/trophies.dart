class LeagueTrophies {
  final String competitionId;
  final String owCompetitionId;
  final String name;
  final String teamType;
  final String type;
  final String areaId;
  final String areaName;
  final String lastUpdated;
  final List<Season> seasons;
  final List<HistoricalSeason> historicalSeasons; // New field

  LeagueTrophies({
    required this.competitionId,
    required this.owCompetitionId,
    required this.name,
    required this.teamType,
    required this.type,
    required this.areaId,
    required this.areaName,
    required this.lastUpdated,
    required this.seasons,
    required this.historicalSeasons, // New field
  });

  factory LeagueTrophies.fromJson(Map<String, dynamic> json) {
    var seasonList = json['season'] as List;
    List<Season> seasons = seasonList.map((i) => Season.fromJson(i)).toList();

    var historicalSeasonList = json['historical_seasons']['trophy'] as List;
    List<HistoricalSeason> historicalSeasons =
    historicalSeasonList.map((i) => HistoricalSeason.fromJson(i)).toList();

    return LeagueTrophies(
      competitionId: json['competition_id'],
      owCompetitionId: json['ow_competition_id'],
      name: json['name'],
      teamType: json['teamtype'],
      type: json['type'],
      areaId: json['area_id'],
      areaName: json['area_name'],
      lastUpdated: json['last_updated'],
      seasons: seasons,
      historicalSeasons: historicalSeasons, // New field
    );
  }
}

class Season {
  final String seasonId;
  final String name;
  final String startDate;
  final String endDate;
  final String lastUpdated;
  final Trophy trophy;

  Season({
    required this.seasonId,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.lastUpdated,
    required this.trophy,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      seasonId: json['season_id'],
      name: json['name'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      lastUpdated: json['last_updated'],
      trophy: Trophy.fromJson(json['trophy']),
    );
  }
}

class Trophy {
  final String trophyId;
  final String winnerTeamId;
  final String winnerName;
  final String winnerArea;
  final String runnerupTeamId;
  final String runnerupName;
  final String runnerupArea;
  final String owWinnerTeamId;
  final String owRunnerupTeamId;

  Trophy({
    required this.trophyId,
    required this.winnerTeamId,
    required this.winnerName,
    required this.winnerArea,
    required this.runnerupTeamId,
    required this.runnerupName,
    required this.runnerupArea,
    required this.owWinnerTeamId,
    required this.owRunnerupTeamId,
  });

  factory Trophy.fromJson(Map<String, dynamic> json) {
    return Trophy(
      trophyId: json['trophy_id'],
      winnerTeamId: json['winner_team_id'],
      winnerName: json['winner_name'],
      winnerArea: json['winner_area'],
      runnerupTeamId: json['runnerup_team_id'],
      runnerupName: json['runnerup_name'],
      runnerupArea: json['runnerup_area'],
      owWinnerTeamId: json['ow_winner_team_id'],
      owRunnerupTeamId: json['ow_runnerup_team_id'],
    );
  }
}

class HistoricalSeason {
  final String seasonTitle;
  final String winnerTeamId;
  final String winnerName;
  final String winnerArea;
  final String runnerupTeamId;
  final String runnerupName;
  final String runnerupArea;
  final String owWinnerTeamId;
  final String owRunnerupTeamId;

  HistoricalSeason({
    required this.seasonTitle,
    required this.winnerTeamId,
    required this.winnerName,
    required this.winnerArea,
    required this.runnerupTeamId,
    required this.runnerupName,
    required this.runnerupArea,
    required this.owWinnerTeamId,
    required this.owRunnerupTeamId,
  });

  factory HistoricalSeason.fromJson(Map<String, dynamic> json) {
    return HistoricalSeason(
      seasonTitle: json['season_title'],
      winnerTeamId: json['winner_team_id'],
      winnerName: json['winner_name'],
      winnerArea: json['winner_area'],
      runnerupTeamId: json['runnerup_team_id'],
      runnerupName: json['runnerup_name'],
      runnerupArea: json['runnerup_area'],
      owWinnerTeamId: json['ow_winner_team_id'],
      owRunnerupTeamId: json['ow_runnerup_team_id'],
    );
  }
}