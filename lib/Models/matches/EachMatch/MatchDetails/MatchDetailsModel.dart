import 'package:arseli/Matches/EndMatches/MatchStats.dart';
import 'package:arseli/Models/matches/EachMatch/MatchDetails/TeamForm/TeamFormModel.dart';

class MatchDetailsModel{
  String date;
  String leagueName;
  String CalName;
  String leagueURL;
  String groundName;
  String refreeName;
  TeamFormModel teamFormModel;

  MatchDetailsModel({this.date, this.leagueName, this.CalName, this.leagueURL,
      this.groundName,this.refreeName,this.teamFormModel});

  factory MatchDetailsModel.json(Map json){
    return MatchDetailsModel(
      date: json['date']??'',
      leagueName: json['leagueName'],
      CalName: json['CalName'],
      leagueURL: json['leagueURL'],
      groundName: json['groundName'],
      refreeName: json['refreeName']??'',
      teamFormModel: TeamFormModel.json(json['teamForm']??Map()),
    );
  }
}