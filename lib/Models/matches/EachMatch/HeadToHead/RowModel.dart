class RowModel{
  String leagueName;
  String leagueURL;
  String matchURL;
  String date;
  String homeTeamName;
  String homeTeamLogo;
  String homeTeamScore;
  String awayTeamName;
  String awayTeamLogo;
  String awayTeamScore;


  RowModel({
    this.leagueName,
    this.leagueURL,
    this.matchURL,
    this.date,
    this.homeTeamName,
    this.homeTeamLogo,
    this.homeTeamScore,
    this.awayTeamName,
    this.awayTeamLogo,
    this.awayTeamScore,
  });

  factory RowModel.Json(Map json){
    return RowModel(
      leagueName: json['leagueName'],
      leagueURL: json['leagueURL'],
      matchURL: json['matchURL'],
      date: json['date'],
      homeTeamName: json['homeTeamName'],
      homeTeamLogo: json['homeTeamLogo'],
      homeTeamScore: json['homeTeamScore'],
      awayTeamName: json['awayTeamName'],
      awayTeamLogo: json['awayTeamLogo'],
      awayTeamScore: json['awayTeamScore'],
    );
  }

  static List<RowModel> listFromJson(List jsonData){
    return jsonData.map((obj) => RowModel.Json(obj)).toList();
  }
}