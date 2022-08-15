class DropTableRowsModel{
  String text;
  String value;


  DropTableRowsModel({this.text, this.value,});

  factory DropTableRowsModel.json(Map json){
    return DropTableRowsModel(
      text: json['text'],
      value: json['value'],
    );
  }

  static List<DropTableRowsModel> listFromJson(List jsonData){
    return jsonData.map((obj) => DropTableRowsModel.json(obj)).toList();
  }
}