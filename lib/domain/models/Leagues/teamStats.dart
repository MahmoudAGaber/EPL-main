

class TeamStatsModel {
  String statsName;
  List<StatsModel> statsModel;

  TeamStatsModel({required this.statsModel, required this.statsName});

  static List<TeamStatsModel> fromJson(Map<String, dynamic> jsonData) {
    return jsonData.entries.map((entry){
      String dynamicKey = entry.key;
      List<dynamic> statsItems = entry.value;

      return TeamStatsModel(
          statsName: dynamicKey,
          statsModel: statsItems.map((item) => StatsModel.fromJson(item)).toList());
    }).toList();
  }


}

class StatsModel {
  final String teamId;
  final String teamName;
  final int count;


  StatsModel({
    required this.teamId,
    required this.teamName,
    required this.count,

  });

  factory StatsModel.fromJson(Map<String, dynamic> json) {
    return StatsModel(
      teamId: json['team_id'],
      teamName: json['team_name'],
      count: json['count'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'team_id': teamId,
      'team_name': teamName,
      'count': count,

    };
  }
}

