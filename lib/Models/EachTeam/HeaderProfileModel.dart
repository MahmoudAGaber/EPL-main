class HeaderProfileModel{
  String logo;
  String clas_s;
  String name;
  String belongsTo;

  HeaderProfileModel({this.logo, this.clas_s, this.name, this.belongsTo});

  factory HeaderProfileModel.json(Map json){
    return HeaderProfileModel(
      logo: json['logo'],
      clas_s: json['class'],
      name: json['name'],
      belongsTo: json['belongsTo'],
    );
  }
}