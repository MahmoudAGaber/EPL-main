
class VideoModel{
  String url;
  String title;
  String imgJPG;
  String imgWEBP;
  String username;
  String userURL;
  String date;
  String timestamp;
  String since;
  String Sdate;


  VideoModel({this.title, this.url, this.imgJPG, this.imgWEBP, this.date,
    this.timestamp, this.since, this.username, this.userURL,this.Sdate});

  factory VideoModel.json(Map json){
    return VideoModel(
        url: json['url'],
        title: json['title'],
        imgJPG: json['imgJPG'],
        imgWEBP: json['imgWEBP'],
        username: json['username'],
        userURL: json['userURL'],
        date: json['date'],
        timestamp: json['timestamp'],
        since: json['since'],
        Sdate: json['Sdate']
    );
  }
  static List<VideoModel> listFromJson(List jsonData){
    return jsonData.map<VideoModel>((obj) => VideoModel.json(obj))?.toList()??[];
  }
}