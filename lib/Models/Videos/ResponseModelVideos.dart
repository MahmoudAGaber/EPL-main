class ResponseModelVideos{
  dynamic videos;
  dynamic categories;
  String filter;

  ResponseModelVideos({this.videos, this.categories, this.filter});

  factory ResponseModelVideos.json(Map json){
    return ResponseModelVideos(
      videos: json['videoBoxes'],
      categories: json['categories'],
      filter: json['filter'],
    );
  }
}