import 'package:arseli/Models/matches/EachMatch/Lineups/PlayerEventModel.dart';

class PlayerInFieldModel{
  String name;
  var number;
  String id;
  String img;
  String quickViewLink;
  String link;
  List<PlayerEventModel> events;
  String rating;
  String formationPlace;

  PlayerInFieldModel(
      {this.name,
      this.number,
      this.id,
      this.img,
      this.quickViewLink,
      this.link,
      this.events,
      this.rating,
      this.formationPlace});

  factory PlayerInFieldModel.json(Map json){
    return PlayerInFieldModel(
      name: json['name'],
      number: json['number'],
      id: json['id'],
      img: json['img'],
      quickViewLink: json['quickViewLink'],
      link: json['link'],
      events:  PlayerEventModel.listFromJson(json['events']).isEmpty?null:PlayerEventModel.listFromJson(json['events']),
      rating: json['rating']??"",
      formationPlace: json['formationPlace'],
    );
  }

  static List<PlayerInFieldModel> listFromJson(List jsonData){
    return jsonData.map((e) => PlayerInFieldModel.json(e)).toList();
  }
}