import 'package:intl/intl.dart';

class TrophiesBoxes{
  String CalendarYear;
  String winnerName;
  String winnerNameEn;
  String winnerLogo;
  String winnerURL;
  String runnerUpName;
  String runnerUpNameEn;
  String runnerUplogo;
  String runnerUpURL;

  TrophiesBoxes(
      {this.CalendarYear,
      this.winnerName,
      this.winnerNameEn,
      this.winnerLogo,
      this.winnerURL,
      this.runnerUpName,
      this.runnerUpNameEn,
      this.runnerUplogo,
      this.runnerUpURL});


  factory TrophiesBoxes.json(Map json){
    return TrophiesBoxes(
      CalendarYear: json['CalendarYear'],
      winnerName: json['winnerName'],
      winnerNameEn: json['winnerNameEn'],
      winnerLogo: json['winnerLogo'],
      winnerURL: json['winnerURL'],
      runnerUpName: json['runnerUpName']??'',
      runnerUpNameEn: json['runnerUpNameEn']??'',
      runnerUplogo: json['runnerUplogo']??'',
      runnerUpURL: json['runnerUpURL']??'',
    );
  }

  static List<TrophiesBoxes>listFromJson(List jsonData){
    return jsonData.map((e) => TrophiesBoxes.json(e)).toList();
  }


}