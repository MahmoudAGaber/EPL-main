class CareerModel{
  String teamName;
  String link;
  String Logo;
  String startDate;
  String endDate;
  String from;
  String to;
  String transferType;
  int goals;
  int assists;
  int appearances;
  int minutesPlayed;

  CareerModel(
      {
        this.teamName,
        this.link,
        this.Logo,
        this.startDate,
        this.endDate,
        this.from,
        this.to,
        this.transferType,
        this.goals,
        this.assists,
        this.appearances,
        this.minutesPlayed});

  factory CareerModel.json(Map json){
    return CareerModel(
      teamName: json['teamName'] ?? '',
      link: json['link']??'',
      Logo: json['Logo']??'',
      startDate: json['startDate']??'',
      endDate: json['endDate']??'',
      from: json['from']??'',
      to: json['to']??'',
      transferType: json['transferType']??'',
      goals: json['goals']??0,
      assists: json['assists']??0,
      appearances: json['appearances']??0,
      minutesPlayed: json['minutesPlayed']??0,
    );
  }

  static List<CareerModel>listFromJson(List jsonData){
    return jsonData.map((e) => CareerModel.json(e)).toList();
  }
}