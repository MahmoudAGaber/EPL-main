import 'package:arseli/Models/matches/EachMatch/Lineups/Players.dart';

class HomeAndAwayModel{
String teamName;
String teamLogo;
String formation;
String formationStr;
Players players;
List formationArr;

HomeAndAwayModel({this.teamName, this.teamLogo, this.formation,
      this.formationStr, this.players, this.formationArr});

factory HomeAndAwayModel.json(Map json){
  return HomeAndAwayModel(
    teamName: json['teamName'],
    teamLogo: json['teamLogo'],
    formation: json['formation'],
    formationStr: json['formationStr'],
    players: Players.json(json['players'])??'',
    formationArr: json['formationArr'],
  );
}
}