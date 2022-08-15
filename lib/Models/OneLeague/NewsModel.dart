class NewsModel{
  String title;
  String url;
  String imageJPG;
  String imageWEBP;
  String date;
  String timestamp;
  String time;
  String username;
  String userURL;

  NewsModel({this.title, this.url, this.imageJPG, this.imageWEBP, this.date,
      this.timestamp, this.time, this.username, this.userURL});

  factory NewsModel.json(Map json){
    return NewsModel(
      title: json['title'],
      url: json['url'],
      imageJPG: json['imageJPG'],
      imageWEBP: json['imageWEBP'],
      date: json['date'],
      timestamp: json['timestamp'],
      time: json['time'],
      username: json['username'],
      userURL: json['userURL'],
    );
  }
  static List<NewsModel> listFromJson(List jsonData){
    return jsonData.map<NewsModel>((obj) => NewsModel.json(obj))?.toList()??[];
  }
}