

class NewsResponse {
  List<NewsModel> news;
  String type;
  
  NewsResponse({required this.news, required this.type});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      news: NewsModel.listFromJson(json['allNews']),
      type: json['type']
    );
  }

}


class NewsModel {
  String id;
  String author;
  String title;
  String link;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String lang;
  String type;
  String videoId;
  String kind;
  String channelTitle;
  List<dynamic> keywords;
  int version;

  NewsModel({
    required this.id,
    required this.author,
    required this.title,
    required this.link,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.lang,
    required this.type,
    required this.videoId,
    required this.kind,
    required this.channelTitle,
    required this.keywords,
    required this.version,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['_id'] ?? '',
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      link: json['link'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: DateTime.parse(json['publishedAt']),
      lang: json['lang'] ?? '',
      type: json['type'] ?? '',
      videoId: json['videoId'] ?? '',
      kind: json['kind'] ?? '',
      channelTitle: json['channelTitle'] ?? '',
      keywords: json['keywords'] ?? [],
      version: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'link': link,
      'description': description,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt.toIso8601String(),
      'lang': lang,
      'type': type,
      'videoId': videoId,
      'kind': kind,
      'channelTitle': channelTitle,
      'keywords': keywords,
      '__v': version,
    };
  }

  static List<NewsModel> listFromJson(List jsonData){
    return jsonData.map((e) => NewsModel.fromJson(e)).toList();
  }
}
