class MatchStatisticsModel {
  String team;
  List<Statistic> statistics;

  MatchStatisticsModel({required this.team, required this.statistics});

  factory MatchStatisticsModel.fromJson(Map<String, dynamic> json) {
    return MatchStatisticsModel(
      team: json['team']??"",
      statistics: List<Statistic>.from(
        json['statistics'].map((x) => Statistic.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'team': team,
      'statistics': statistics.map((x) => x.toJson()).toList(),
    };
  }

  static List<MatchStatisticsModel> listFromJson(List jsonData){
    return jsonData.map((e) => MatchStatisticsModel.fromJson(e)).toList();
  }
}

class Statistic {
  String type;
  int value;

  Statistic({required this.type, required this.value});

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(
      type: json['type']??"",
      value: json['value']??0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'value': value,
    };
  }
}
