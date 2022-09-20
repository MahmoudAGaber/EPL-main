class StatsModel{
  String competitionName;
  String tournamentCalendarName;
  int appearances;
  int goals;
  int assists;
  String rank;

  StatsModel({this.competitionName, this.goals, this.assists,this.tournamentCalendarName,this.appearances,this.rank});

  factory StatsModel.json(Map json){
    return StatsModel(
      competitionName: json['competitionName'] ?? '',
      tournamentCalendarName: json['tournamentCalendarName']??'',
      appearances: json['appearances']??0,
      goals: json['goals']??0,
      rank: json['rank']??'',
      assists: json['assists']??0,
    );
  }


}