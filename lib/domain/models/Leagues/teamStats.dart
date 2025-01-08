class TeamsStatisticsModel {
  final List<TeamStatistics> teamsStatistics;

  TeamsStatisticsModel({required this.teamsStatistics});

  factory TeamsStatisticsModel.fromJson(Map<String, dynamic> json) {
    return TeamsStatisticsModel(
      teamsStatistics: (json['teams_statistics'] as List)
          .map((team) => TeamStatistics.fromJson(team))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teams_statistics': teamsStatistics.map((team) => team.toJson()).toList(),
    };
  }
}

class TeamStatistics {
  final String teamId;
  final String clubName;
  final int squadSize;
  final Statistics statistics;

  TeamStatistics({
    required this.teamId,
    required this.clubName,
    required this.squadSize,
    required this.statistics,
  });

  factory TeamStatistics.fromJson(Map<String, dynamic> json) {
    return TeamStatistics(
      teamId: json['team_id'],
      clubName: json['club_name'],
      squadSize: json['squad_size'],
      statistics: Statistics.fromJson(json['statistics']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'team_id': teamId,
      'club_name': clubName,
      'squad_size': squadSize,
      'statistics': statistics.toJson(),
    };
  }
}

class Statistics {
  final int goals;
  final int assists;
  final int penaltyGoals;
  final int appearances;
  final int yellowCards;
  final int secondYellowCards;
  final int redCards;
  final int substituteIn;
  final int substituteOut;
  final int subsOnBench;
  final int minutesPlayed;

  Statistics({
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
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
    };
  }
}
