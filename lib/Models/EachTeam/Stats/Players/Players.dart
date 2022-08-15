
import 'package:arseli/Models/EachTeam/Stats/Players/First.dart';
import 'package:arseli/Models/EachTeam/Stats/Players/Second.dart';
import 'package:arseli/Models/EachTeam/Stats/Players/Third.dart';

class PlayersModel{
  String title;
  String titleEn;
  FirstModel firstModel;
  SecondModel secondModel;
  ThirdModel thirdModel;
  String viewMore;

  PlayersModel({this.title, this.titleEn, this.firstModel, this.secondModel,
      this.thirdModel, this.viewMore});

  factory PlayersModel.json(Map json){
    return PlayersModel(
      title: json['title'],
      titleEn: json['titleEn'],
      firstModel: FirstModel.json(json['first']),
      secondModel:SecondModel.json(json['second']),
      thirdModel: ThirdModel.json(json['third']),
      viewMore: json['viewMore'],

    );
  }
  static List<PlayersModel>listFromJson(List jsonData){
    return jsonData.map((e) => PlayersModel.json(e)).toList();
  }
}