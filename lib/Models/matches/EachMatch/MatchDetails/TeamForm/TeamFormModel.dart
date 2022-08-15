import 'package:arseli/Models/matches/EachMatch/MatchDetails/TeamForm/AwayModel.dart';
import 'package:arseli/Models/matches/EachMatch/MatchDetails/TeamForm/HomeModel.dart';

class TeamFormModel{
  List<HomeModel> home;
  List<AwayModel> away;

  TeamFormModel({this.home, this.away});

  factory  TeamFormModel.json(Map json){
    return TeamFormModel(
      home:HomeModel.listFromJson(json['home']??[]) ,
      away:AwayModel.listFromJson(json['away']??[]),
    );
  }
}