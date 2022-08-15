class HeaderProfileModel{
  String logo;
  String name;
  String belongsTo;

  HeaderProfileModel({this.logo, this.name, this.belongsTo});

  factory HeaderProfileModel.json(Map json){
    return HeaderProfileModel(
      logo: json['logo']==null ? "" : json['logo'],
      name: json['name'] == null ? "": json['name'] ,
      belongsTo: json['belongsTo']==null ? "": json['belongsTo'] ,
    );
  }
}