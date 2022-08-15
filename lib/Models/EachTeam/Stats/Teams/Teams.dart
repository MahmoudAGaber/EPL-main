import 'package:arseli/Models/EachTeam/Stats/Teams/First.dart';
import 'package:arseli/Models/EachTeam/Stats/Teams/Second.dart';
import 'package:arseli/Models/EachTeam/Stats/Teams/Third.dart';

class TeamsModel{
  String title;
  String titleEn;
  FirstModel firstModel;
  SecondModel secondModel;
  ThirdModel thirdModel;
  String viewMore;

  TeamsModel({this.title, this.titleEn, this.firstModel, this.secondModel,
      this.thirdModel, this.viewMore});

  factory TeamsModel.json(Map json){
    return TeamsModel(
      title: json['title'],
      titleEn: json['titleEn'],
      firstModel: FirstModel.json(json['first']),
      secondModel:SecondModel.json(json['second']),
      thirdModel: ThirdModel.json(json['third']),
      viewMore: json['viewMore'],

    );
  }
  static List<TeamsModel>listFromJson(List jsonData){
    return jsonData.map((e) => TeamsModel.json(e)).toList();
  }
}