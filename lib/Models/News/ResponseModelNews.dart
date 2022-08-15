class ResponseModelNews{
  dynamic news;
  dynamic categories;
  String filter;

  ResponseModelNews({this.news, this.categories, this.filter});

  factory ResponseModelNews.json(Map json){
    return ResponseModelNews(
      news: json['news'],
      categories: json['categories'],
      filter: json['filter'],
    );
  }
}