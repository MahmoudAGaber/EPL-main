class VideosModel {
  String title;
  String url;
  String imgJPG;
  String imgWEBP;
  String date;
  String Sdate;
  String timestamp;
  String since;
  String username;
  String userURL;

  VideosModel(
      {this.title,
      this.url,
      this.imgJPG,
      this.imgWEBP,
      this.date,
        this.Sdate,
      this.timestamp,
      this.since,
      this.username,
      this.userURL});

  factory VideosModel.json(Map json) {
    return VideosModel(
      title: json['title'],
      url: json['url'],
      imgJPG: json['imgJPG'],
      imgWEBP: json['imgWEBP'],
      date: json['date'],
      Sdate: json['Sdate'],
      timestamp: json['timestamp'],
      since: json['since'],
      username: json['username'],
      userURL: json['userURL'],
    );
  }
  static List<VideosModel> listFromJson(List jsonData) {
    return jsonData
            .map<VideosModel>((obj) => VideosModel.json(obj))
            ?.toList() ??
        [];
  }
}
