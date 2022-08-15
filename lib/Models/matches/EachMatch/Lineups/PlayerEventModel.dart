class PlayerEventModel{
  String name;
  String type;
  var time;

  PlayerEventModel({this.name, this.type,this.time});

  factory PlayerEventModel.json(Map json){
    return PlayerEventModel(
      name: json['name'],
      type: json['type'],
      time: json['time'],
    );
  }
  static List<PlayerEventModel> listFromJson(List jsonData){
    return jsonData.map((e) => PlayerEventModel.json(e)).toList();
  }
}