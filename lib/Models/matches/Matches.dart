

import 'SubOfMatches.dart';

class MatchesModel{
  String comID;
  String comName;
  String comURL;
  String comImg;
  List<SubOfMathes> subOfMathes;

  MatchesModel({this.comID, this.comName, this.comURL, this.comImg, this.subOfMathes});

  factory MatchesModel.fromjson(Map json){
    return MatchesModel(
      comID:json["comID"],
      comName:json["comName"],
      comURL:json["comURL"],
      comImg:json["comImg"],
      subOfMathes: SubOfMathes.listFromJson(json['matches']??[]),
    );
  }

  static List<MatchesModel> listFromJson(List jsonData){
    return jsonData.map((obj) => MatchesModel.fromjson(obj)).toList();
  }

}