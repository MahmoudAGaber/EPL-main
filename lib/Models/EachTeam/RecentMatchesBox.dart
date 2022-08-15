
import 'package:arseli/Models/EachTeam/MatchInBoxModel.dart';

class RecentMatchesBox{
  String date;
  List<MatchInBoxModel> matchInBoxModel;

  RecentMatchesBox({this.date, this.matchInBoxModel});

  factory RecentMatchesBox.json(Map json){

    return RecentMatchesBox(
      date: json["date"],
      matchInBoxModel: MatchInBoxModel.listFromJson(json["matches"])
    );
  }

  static toList(List recentMatches){
    return recentMatches.map((obj) => RecentMatchesBox.json(obj)).toList();
  }

}