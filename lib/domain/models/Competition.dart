class CompetitionModel {
  final Country country;
  final List<Leagues> leagues;

  CompetitionModel({
    required this.country,
    required this.leagues,
  });

  factory CompetitionModel.fromJson(Map<String, dynamic> json) {
    return CompetitionModel(
      country: Country.fromJson(json['country']),
      leagues: (json['items'] as List).map((item) => Leagues.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country.toJson(),
      'items': leagues.map((item) => item.toJson()).toList(),
    };
  }

  static List<CompetitionModel> listFromJson(List jsonDate){
    return jsonDate.map((e) => CompetitionModel.fromJson(e)).toList();
  }
}

class Country {
  final String name;
  final String? code;
  final String? flag;
  final String? id;

  Country({
    required this.name,
    this.code,
    this.flag,
    this.id
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      code: json['code'],
      flag: json['flag'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'flag': flag,
      'id': id,
    };
  }
}

class Leagues {
  final League league;

  Leagues({
    required this.league,
  });

  factory Leagues.fromJson(Map<String, dynamic> json) {
    return Leagues(
      league: League.fromJson(json['league']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'league': league.toJson(),
    };
  }

  static List<Leagues> listFromJson(List jsonDate){
    return jsonDate.map((e) => Leagues.fromJson(e)).toList();
  }
}

class League {
  dynamic id;
  dynamic ow_id;
  final String name;
  final String type;
  final String logo;

  League({
    this.id,
    this.ow_id,
    required this.name,
    this.type = '',
    required this.logo,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id']??"",
      ow_id: json['ow_id']??"",
      name: json['name']??'',
      type: json['type'] ?? '',
      logo: json['logo']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ow_id': ow_id,
      'name': name,
      'type': type,
      'logo': logo,
    };
  }
}
