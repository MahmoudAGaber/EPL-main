class HeaderModel{
  int homeTeamWins;
  int draws;
  int awayTeamWins;

  HeaderModel({this.homeTeamWins, this.draws, this.awayTeamWins});

  factory HeaderModel.json(Map json){
    return HeaderModel(
      homeTeamWins: json['homeTeamWins'],
      draws: json['draws'],
      awayTeamWins: json['awayTeamWins'],
    );
  }
}