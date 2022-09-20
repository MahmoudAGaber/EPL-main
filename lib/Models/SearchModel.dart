class SearchResponseModel {
  String text;
  String url;
  String image;
  String category;
//
  SearchResponseModel({this.text, this.url, this.image, this.category});

  factory SearchResponseModel.json(Map json) {
    return SearchResponseModel(
      text: json['text'],
      url: json['url'],
      image: json['image'],
      category: json['category'],
    );
  }

  static List<SearchResponseModel> ListFromJson(List listFromJson) {
    return listFromJson.map((e) => SearchResponseModel.json(e)).toList();
  }
}
