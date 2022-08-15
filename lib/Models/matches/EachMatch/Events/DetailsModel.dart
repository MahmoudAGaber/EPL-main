class DetailsModel{
  String name;
  int time;
  String id;
  String type;
  String belongsToName;
  String belongsToURL;
  int homeScore;
  int awayScore;
  var timestamp;
  String goalMakerURL;
  String goalMakerName;
  String id2;
  String type2;
  String name2;
  String subWithName;
  String subWithURL;
  String subOfName;
  String subOfURL;
  String outcome;
  String status;
  var extra;

  DetailsModel({this.name, this.time, this.id, this.type, this.belongsToName,
      this.belongsToURL, this.homeScore, this.awayScore, this.timestamp,this.goalMakerURL,
    this.goalMakerName,this.id2,this.type2,this.name2,this.subWithName,this.subWithURL,
    this.subOfName,this.subOfURL,this.outcome,this.extra,this.status});

  factory DetailsModel.json(Map json){
    return DetailsModel(
      name: json['name'],
      time: json['time'],
      id: json['id'],
      type: json['type'],
      belongsToName: json['belongsToName'],
      belongsToURL: json['belongsToURL'],
      homeScore: json['homeScore'],
      awayScore: json['awayScore'],
      timestamp: json['timestamp'],
      goalMakerURL: json['goalMakerURL']??'',
      goalMakerName: json['goalMakerName']??'',
      id2: json['id2']??'',
      type2: json['type2']??'',
      name2: json['name2']??'',
      subWithName: json['subWithName']??'',
      subWithURL: json['subWithURL']??'',
      subOfName: json['subOfName']??'',
      subOfURL: json['subOfURL']??'',
      outcome: json['outcome']??'',
      extra: json['extra']??'',
        status:json['status']??''
    );
  }


}
