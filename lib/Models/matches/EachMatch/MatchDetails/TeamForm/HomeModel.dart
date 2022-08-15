class HomeModel{
  String status;
  String teamLogo;
  String teamLink;
  String matchLink;
  String date;

  HomeModel({this.status, this.teamLogo, this.teamLink, this.matchLink, this.date});

  factory HomeModel.json(Map json){
    return HomeModel(
      status: json['status']??'',
      teamLogo: json['teamLogo']??'',
      teamLink: json['teamLink']??'',
      matchLink: json['matchLink']??'',
      date: json['date']??"",
    );
  }

  static List<HomeModel>listFromJson(List jsonData){
    return jsonData.map((e) => HomeModel.json(e)).toList();
  }
}