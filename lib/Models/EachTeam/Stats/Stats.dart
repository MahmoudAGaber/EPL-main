
import 'package:arseli/Models/EachTeam/Stats/Players/Players.dart';
import 'package:arseli/Models/EachTeam/Stats/Teams/Teams.dart';

class StatsModel{
  List<PlayersModel> playersModel;
  List<TeamsModel> teamsModel;

  StatsModel({this.playersModel, this.teamsModel});

  factory StatsModel.json(Map json){
    return StatsModel(
      playersModel:PlayersModel.listFromJson(json['players']),
      teamsModel:TeamsModel.listFromJson(json['teams']),
    );
  }
}