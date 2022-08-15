class MSNModel{
  String homeTeamURL;
  String homeTeamName;
  String homeTeamLogo;
  var homeTeamScores;
  String matchID;
  String matchStatus;
  String awayTeamURL;
  String awayTeamName;
  String awayTeamLogo;
  var awayTeamScores;
  var matchTime;

  MSNModel(
      {this.homeTeamURL,
      this.homeTeamName,
      this.homeTeamLogo,
      this.homeTeamScores,
      this.matchID,
      this.matchStatus,
      this.awayTeamURL,
      this.awayTeamName,
      this.awayTeamLogo,
      this.awayTeamScores,
      this.matchTime});

  factory MSNModel.json(Map json){
    return MSNModel(
      homeTeamURL: json['homeTeamURL'],
      homeTeamName: json['homeTeamName'],
      homeTeamLogo: json['homeTeamLogo'],
      homeTeamScores: json['homeTeamScores'],
      matchID: json['matchID'],
      matchStatus: json['matchStatus'],
      awayTeamURL: json['awayTeamURL'],
      awayTeamName: json['awayTeamName'],
      awayTeamLogo: json['awayTeamLogo'],
      awayTeamScores: json['awayTeamScores'],
      matchTime: json['matchTime'],
    );
  }
}