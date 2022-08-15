class SquadSubModel{
  String link;
  String name;
  String IMGAlt;
  String IMG;
  String belongsToName;
  String belongsToLogo;
  String belongsToLogoAlt;

  SquadSubModel({this.link, this.name, this.IMGAlt, this.IMG, this.belongsToName,
      this.belongsToLogo, this.belongsToLogoAlt});

  factory SquadSubModel.json(Map json){
    return SquadSubModel(
      link: json['link'],
      name: json['name'],
      IMGAlt: json['IMGAlt'],
      IMG: json['IMG'],
      belongsToName: json['belongsToName'],
      belongsToLogo: json['belongsToLogo'],
      belongsToLogoAlt: json['belongsToLogoAlt'],
    );
  }

  static List<SquadSubModel>listFromJson(List jsonData){
    return jsonData.map((e) => SquadSubModel.json(e)).toList();
  }
}