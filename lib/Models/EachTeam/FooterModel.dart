class FooterModel {
  String id;
  String text;
  String color;

  FooterModel({this.id, this.text, this.color});

  factory FooterModel.json(Map json){
    return FooterModel(
      id: json["id"],
      text: json["text"],
      color: json["color"],
    );
  }

  static List<FooterModel> listFromJson(List jsonData){
    return jsonData.map((obj) => FooterModel.json(obj)).toList();
  }
}