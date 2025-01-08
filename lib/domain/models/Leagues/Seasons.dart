
class LeagueSeasonsModel {
  final String version;
  final String sport;
  final String lang;
  final DateTime lastGenerated;
  final Method method;
  final Competition competition;

  LeagueSeasonsModel({
    required this.version,
    required this.sport,
    required this.lang,
    required this.lastGenerated,
    required this.method,
    required this.competition,
  });

  factory LeagueSeasonsModel.fromJson(Map<String, dynamic> json) {
    return LeagueSeasonsModel(
      version: json['version'],
      sport: json['sport'],
      lang: json['lang'],
      lastGenerated: DateTime.parse(json['last_generated']),
      method: Method.fromJson(json['method']),
      competition: Competition.fromJson(json['competition']),
    );
  }

  Map<String, dynamic> toJson() => {
    'version': version,
    'sport': sport,
    'lang': lang,
    'last_generated': lastGenerated.toIso8601String(),
    'method': method.toJson(),
    'competition': competition.toJson(),
  };
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
      methodId: json['method_id'],
      name: json['name'],
      parameter: (json['parameter'] as List)
          .map((e) => Parameter.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'method_id': methodId,
    'name': name,
    'parameter': parameter.map((e) => e.toJson()).toList(),
  };
}

class Parameter {
  final String name;
  final String value;

  Parameter({
    required this.name,
    required this.value,
  });

  factory Parameter.fromJson(Map<String, dynamic> json) {
    return Parameter(
      name: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'value': value,
  };
}

class Competition {
  final String competitionId;
  final String owCompetitionId;
  final String name;
  final String teamtype;
  final String displayOrder;
  final String type;
  final String areaId;
  final String areaName;
  final DateTime lastUpdated;
  final String soccertype;
  final String format;
  final List<Season> season;

  Competition({
    required this.competitionId,
    required this.owCompetitionId,
    required this.name,
    required this.teamtype,
    required this.displayOrder,
    required this.type,
    required this.areaId,
    required this.areaName,
    required this.lastUpdated,
    required this.soccertype,
    required this.format,
    required this.season,
  });

  factory Competition.fromJson(Map<String, dynamic> json) {
    return Competition(
      competitionId: json['competition_id'],
      owCompetitionId: json['ow_competition_id'],
      name: json['name'],
      teamtype: json['teamtype'],
      displayOrder: json['display_order'],
      type: json['type'],
      areaId: json['area_id'],
      areaName: json['area_name'],
      lastUpdated: DateTime.parse(json['last_updated']),
      soccertype: json['soccertype'],
      format: json['format'],
      season: (json['season'] as List)
          .map((e) => Season.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'competition_id': competitionId,
    'ow_competition_id': owCompetitionId,
    'name': name,
    'teamtype': teamtype,
    'display_order': displayOrder,
    'type': type,
    'area_id': areaId,
    'area_name': areaName,
    'last_updated': lastUpdated.toIso8601String(),
    'soccertype': soccertype,
    'format': format,
    'season': season.map((e) => e.toJson()).toList(),
  };
}

class Season {
  final String seasonId;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String serviceLevel;
  final DateTime lastUpdated;
  final List<Coverage> coverage;

  Season({
    required this.seasonId,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.serviceLevel,
    required this.lastUpdated,
    required this.coverage,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      seasonId: json['season_id'],
      name: json['name'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      serviceLevel: json['service_level'],
      lastUpdated: DateTime.parse(json['last_updated']),
      coverage: (json['coverage'] as List)
          .map((e) => Coverage.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'season_id': seasonId,
    'name': name,
    'start_date': startDate.toIso8601String(),
    'end_date': endDate.toIso8601String(),
    'service_level': serviceLevel,
    'last_updated': lastUpdated.toIso8601String(),
    'coverage': coverage.map((e) => e.toJson()).toList(),
  };
}

class Coverage {
  final String type;
  final String code;
  final String interval;

  Coverage({
    required this.type,
    required this.code,
    required this.interval,
  });

  factory Coverage.fromJson(Map<String, dynamic> json) {
    return Coverage(
      type: json['type'],
      code: json['code'],
      interval: json['interval'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'code': code,
    'interval': interval,
  };
}
