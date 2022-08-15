class SubOfMathes{
  String matchURL;
  String time;
  String id;
  String matchID;
  String status;
  int matchTime;
  String homeID;
  String homeName;
  String homeLogo;
  String awayID;
  String awayName;
  String awayLogo;
  int homeScore;
  int awayScore;

  SubOfMathes(
     {this.matchURL,
      this.time,
      this.id,
      this.matchID,
      this.status,
      this.matchTime,
      this.homeID,
      this.homeName,
      this.homeLogo,
      this.awayID,
      this.awayName,
      this.awayLogo,
      this.homeScore,
      this.awayScore});

  factory SubOfMathes.Json(Map json){
    return SubOfMathes(
      matchURL: json['matchURL'],
      time: json['time'],
      id: json['id'],
      matchID: json['matchID'],
      status: json['status'],
      matchTime: json['matchTime'],
      homeID: json['homeID'],
      homeName: json['homeName'],
      homeLogo: json['homeLogo'],
      awayID: json['awayID'],
      awayName: json['awayName'],
      awayLogo: json['awayLogo'],
      homeScore: json['homeScore']??0,
      awayScore: json['awayScore']??0,
    );
  }

  static List<SubOfMathes> listFromJson(List jsonData){
    return jsonData.map((obj) => SubOfMathes.Json(obj)).toList();
  }
}