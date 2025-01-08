

class SeasonModel {
  final String seasonId;
  final String name;
  final String startDate;
  final String endDate;
  final String serviceLevel;
  final String lastUpdated;
  final String competitionId;
  final String owCompetitionId;
  final String competitionName;
  final String teamType;
  final String displayOrder;
  final String competitionType;
  final String areaId;
  final String areaName;
  final String soccerType;
  final String format;

  SeasonModel({
    required this.seasonId,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.serviceLevel,
    required this.lastUpdated,
    required this.competitionId,
    required this.owCompetitionId,
    required this.competitionName,
    required this.teamType,
    required this.displayOrder,
    required this.competitionType,
    required this.areaId,
    required this.areaName,
    required this.soccerType,
    required this.format,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) {
    return SeasonModel(
      seasonId: json['season_id'] ?? '',
      name: json['name'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      serviceLevel: json['service_level'] ?? '',
      lastUpdated: json['last_updated'] ?? '',
      competitionId: json['competition_id'] ?? '',
      owCompetitionId: json['ow_competition_id'] ?? '',
      competitionName: json['competition_name'] ?? '',
      teamType: json['teamtype'] ?? '',
      displayOrder: json['display_order'] ?? '',
      competitionType: json['competition_type'] ?? '',
      areaId: json['area_id'] ?? '',
      areaName: json['area_name'] ?? '',
      soccerType: json['soccertype'] ?? '',
      format: json['format'] ?? '',
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
      'competition_id': competitionId,
      'ow_competition_id': owCompetitionId,
      'competition_name': competitionName,
      'teamtype': teamType,
      'display_order': displayOrder,
      'competition_type': competitionType,
      'area_id': areaId,
      'area_name': areaName,
      'soccertype': soccerType,
      'format': format,
    };
  }

  static List<SeasonModel> listFromJson(List<dynamic> json) {
    return json.map((item) => SeasonModel.fromJson(item)).toList();
  }
}
