import 'package:arseli/Models/Leagues/Tournaments.dart';

class ResponseModelLeagues{
  String id;
  String name;
  String name_en;
  String countryCode;
  String countryImage;
  List<TournamentsModel> Tournaments;

  ResponseModelLeagues({this.id,this.name,this.name_en,this.countryCode,this.Tournaments,this.countryImage});

  factory ResponseModelLeagues.Json(Map json){
    return ResponseModelLeagues(
        id:json["id"],
        name:json["name"],
        name_en:json["name_en"],
        countryCode:json["countryCode"],
        countryImage:json["countryImage"],
        Tournaments:TournamentsModel.listFromJson(json["Tournaments"])
    );
  }

  static List<ResponseModelLeagues> listFromJson(List list){
    return list.map((e) => ResponseModelLeagues.Json(e)).toList();
  }
}