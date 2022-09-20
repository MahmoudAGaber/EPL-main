class MatchInBoxModel{
  String matchURL;
  String matchDate;
  String matchDateEn;
  String matchTime;
  String timestamp;
  String location;
  String description;
  String status;
  int periodId;
  String homeTeamName;
  String homeTeamNameEn;
  String homeTeamLogo;
  String homeTeamLogoAlt;
  String matchID;
  String awayTeamName;
  String awayTeamNameEn;
  String awayTeamLogoAlt;
  String awayTeamLogo;
  String competition;
  String belongsTo;
  String belongsToEn;
  String date;
  String ID;
  int homeTeamScore;
  int awayTeamScore;

  MatchInBoxModel(
      {this.matchURL,
      this.matchDate,
      this.matchDateEn,
      this.matchTime,
      this.timestamp,
      this.location,
      this.description,
      this.status,
      this.periodId,
      this.homeTeamName,
      this.homeTeamNameEn,
      this.homeTeamLogo,
      this.homeTeamLogoAlt,
      this.matchID,
      this.awayTeamName,
      this.awayTeamNameEn,
      this.awayTeamLogoAlt,
      this.awayTeamLogo,
        this.belongsTo,
        this.belongsToEn,
        this.date,
      this.competition,
      this.homeTeamScore,
      this.awayTeamScore});

  factory MatchInBoxModel.json(Map json){
    return MatchInBoxModel(
      matchURL: json['matchURL'],
      matchDate: json['matchDate'],
      matchDateEn: json['matchDateEn'],
      matchTime: json['matchTime'],
      timestamp: json['timestamp'],
      location: json['location'],
      description: json['description'],
      status: json['status'],
      periodId: json['periodId'],
      homeTeamName: json['homeTeamName'],
      homeTeamNameEn: json['homeTeamNameEn'],
      homeTeamLogo: json['homeTeamLogo'],
      homeTeamLogoAlt: json['homeTeamLogoAlt'],
      awayTeamName: json['awayTeamName'],
      awayTeamNameEn: json['awayTeamNameEn'],
      awayTeamLogoAlt: json['awayTeamLogoAlt'],
      awayTeamLogo: json['awayTeamLogo'],
      belongsTo: json['belongsTo'],
      belongsToEn: json['belongsToEn'],
      date: json['date'],
      competition: json['competition'],
      homeTeamScore: json['homeTeamScore'],
      awayTeamScore: json['awayTeamScore'],
    );
  }
  static List<MatchInBoxModel>listFromJson(List jsonData){
    return jsonData.map((e) => MatchInBoxModel.json(e)).toList();
  }
}