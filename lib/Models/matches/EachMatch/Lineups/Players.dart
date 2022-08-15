import 'package:arseli/Models/matches/EachMatch/Lineups/CoachModel.dart';
import 'package:arseli/Models/matches/EachMatch/Lineups/PlayerInFieldModel.dart';
import 'package:arseli/Models/matches/EachMatch/Lineups/PlayersOutFieldModel.dart';


class Players{
  List<PlayerInFieldModel> inField;
  List<PlayerOutFieldModel> outField;
  CoachModel coach;

  Players({this.inField, this.outField, this.coach});

  factory Players.json(Map json){
    return Players(
      inField: PlayerInFieldModel.listFromJson(json['inField']),
      outField:PlayerOutFieldModel.listFromJson(json['outField']),
      coach: CoachModel.json(json['coach']),
    );
  }
}