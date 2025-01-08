

class PlayerStatsModel {
  String statsName;
  List<StatsModel> statsModel;

  PlayerStatsModel({required this.statsModel, required this.statsName});

  static List<PlayerStatsModel> fromJson(Map<String, dynamic> jsonData) {
    return jsonData.entries.map((entry){
      String dynamicKey = entry.key;
      List<dynamic> statsItems = entry.value;
      
      return PlayerStatsModel(
        statsName: dynamicKey,
          statsModel: statsItems.map((item) => StatsModel.fromJson(item)).toList());
    }).toList();
  }


}

class StatsModel {
  final String personId;
  final String name;
  final String teamId;
  final String teamName;
  final Statistic statistic;

  StatsModel({
    required this.personId,
    required this.name,
    required this.teamId,
    required this.teamName,
    required this.statistic,
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) {
    return StatsModel(
      personId: json['person_id'],
      name: json['name'],
      teamId: json['team_id'],
      teamName: json['team_name'],
      statistic: Statistic.fromJson(json['statistic']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'person_id': personId,
      'name': name,
      'team_id': teamId,
      'team_name': teamName,
      'statistic': statistic.toJson(),
    };
  }
}

class Statistic {
  final String type;
  final String value;

  Statistic({required this.type, required this.value});

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(
      type: json['type'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'value': value,
    };
  }
}
