
import 'package:arseli/Models/EachTeam/MatchInBoxModel.dart';

class RecentMatches{
  String date;
  List<MatchInBoxModel> matchInBoxModel;

  RecentMatches({this.date, this.matchInBoxModel});

  factory RecentMatches.json(Map json){

    return RecentMatches(
      date: json["date"],
      matchInBoxModel: MatchInBoxModel.listFromJson(json["matches"])
    );
  }

  static toList(List recentMatches){
    return recentMatches.map((obj) => RecentMatches.json(obj)).toList();
  }

}