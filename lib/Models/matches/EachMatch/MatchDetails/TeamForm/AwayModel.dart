class AwayModel{
  String status;
  String teamLogo;
  String teamLink;
  String matchLink;
  String date;

  AwayModel(
      {this.status, this.teamLogo, this.teamLink, this.matchLink, this.date});

  factory AwayModel.json(Map json){
    return AwayModel(
      status: json['status'],
      teamLogo: json['teamLogo'],
      teamLink: json['teamLink'],
      matchLink: json['matchLink'],
      date: json['date'],
    );
  }

  static List<AwayModel>listFromJson(List jsonData){
    return jsonData.map((e) => AwayModel.json(e)).toList();
  }
}