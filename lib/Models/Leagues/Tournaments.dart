class TournamentsModel {
  Map oid;
  String id;
  String competitionCode;
  String competitionFormat;
  String competitionType;
  String country;
  String countryCode;
  String countryId;
  int displayOrder;
  String isFriendly;
  String name;
  String ocId;
  String opId;
  dynamic tournamentCalendar;
  String type;
  bool active;
  bool logo;
  int sort_order;
  String url;
  String country_en;
  String name_en;
  String LogoImage;

  TournamentsModel(
      {this.oid,
      this.id,
      this.competitionCode,
      this.competitionFormat,
      this.competitionType,
      this.country,
      this.countryCode,
      this.countryId,
      this.displayOrder,
      this.isFriendly,
      this.name,
      this.ocId,
      this.opId,
      this.tournamentCalendar,
      this.type,
      this.active,
      this.logo,
      this.sort_order,
      this.url,
      this.country_en,
      this.name_en,
        this.LogoImage});

  factory TournamentsModel.json(Map json){
    return TournamentsModel(
      oid: json["oid"],
      id: json["id"],
      competitionCode: json["competitionCode"],
      competitionFormat: json["competitionFormat"],
      competitionType: json["competitionType"],
      country: json["country"],
      countryCode: json["countryCode"],
      countryId: json["countryId"],
      displayOrder: json["displayOrder"],
      isFriendly: json["isFriendly"],
      name: json["name"],
      ocId: json["ocId"],
      opId: json["opId"],
      tournamentCalendar: json["tournamentCalendar"],
      type: json["type"],
      active: json["active"],
      logo: json["logo"],
      sort_order: json["sort_order"],
      url: json["url"],
      country_en: json["country_en"],
      name_en: json["name_en"],
        LogoImage:json['LogoImage']
    );
  }

  static List<TournamentsModel> listFromJson(List jsonData){
    return jsonData.map((obj) => TournamentsModel.json(obj)).toList();
  }
}