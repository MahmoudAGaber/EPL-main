import 'package:intl/intl.dart';

class TrophiesBoxes{
  String name;
  int winnerCount;
  int runnerCount;
  String winner;
  String runner;

  TrophiesBoxes({this.name, this.winnerCount, this.runnerCount, this.winner,this.runner});

  factory TrophiesBoxes.json(Map json){
    return TrophiesBoxes(
      name: json['name'],
      winnerCount: json['winnerCount'],
      runnerCount: json['runnerCount'],
      winner: json['winner'],
      runner: json['runner'],
    );
  }

  static List<TrophiesBoxes>listFromJson(List jsonData){
    return jsonData.map((e) => TrophiesBoxes.json(e)).toList();
  }
}