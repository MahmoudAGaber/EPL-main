import 'package:arseli/Models/EachTeam/Squad/CoachModel.dart';

class SquadsModel{
  List<SquadSubModel> coach;
  List<SquadSubModel> Goalkeeper;
  List<SquadSubModel> Defender;
  List<SquadSubModel> Midfielder;
  List<SquadSubModel> Attacker;

  SquadsModel({this.coach, this.Goalkeeper, this.Defender, this.Midfielder,
      this.Attacker});

  factory SquadsModel.json(Map json){
    return SquadsModel(
      coach: SquadSubModel.listFromJson(json['coach']),
      Goalkeeper: SquadSubModel.listFromJson(json['Goalkeeper']),
      Defender: SquadSubModel.listFromJson(json['Defender']),
      Midfielder: SquadSubModel.listFromJson(json['Midfielder']),
      Attacker: SquadSubModel.listFromJson(json['Attacker']),
    );
  }
}