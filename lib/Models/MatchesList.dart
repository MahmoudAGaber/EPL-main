import 'package:arseli/Models/matchesNoti.dart';

class MatchesList{
  String matchId;
  MatchesCheckNoti matchesCheckNoti;

  MatchesList({this.matchId, this.matchesCheckNoti});

  Map<String,dynamic> toMap(){
    return {
      'matchId':matchId,
      'matchesCheckNoti':matchesCheckNoti.toMap()
    };
  }

  factory MatchesList.json(Map json){
    return MatchesList(
      matchId: json['matchId'],
      matchesCheckNoti: MatchesCheckNoti.json(json['matchesCheckNoti'])
    );
  }

  static List<MatchesList>listFromJson(List data){
    return data.map((e) => MatchesList.json(e)).toList();
  }

}