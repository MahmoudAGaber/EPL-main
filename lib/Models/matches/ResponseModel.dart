
class ResponseModel{
  dynamic matches;
  String tommorow;
  String today;
  String yesterday;
  ResponseModel({this.matches,this.tommorow,this.today,this.yesterday});

  factory ResponseModel.Json(Map json){
    return ResponseModel(
        matches:json["matches"],
        tommorow:json["tommorow"],
        today:json["today"],
        yesterday:json["yesterday"]
    );
  }
}