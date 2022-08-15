class CategoriesModel{
  String name;
  String ocId;
  List accounts;

  CategoriesModel({this.name, this.ocId, this.accounts});

  factory CategoriesModel.json(Map json){
    return CategoriesModel(
      name: json['name'],
      ocId: json['ocId'],
      accounts: json['accounts'],
    );
  }

  static List<CategoriesModel> listFromJson(List jsonData){
    return jsonData.map((obj) => CategoriesModel.json(obj)).toList();
  }
}