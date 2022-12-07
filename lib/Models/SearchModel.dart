
import 'package:hive/hive.dart';


@HiveType(typeId: 1)
class SearchResponseModel extends HiveObject {
  @HiveField(0)
  String text;

  @HiveField(1)
  String url;

  @HiveField(2)
  String image;

  @HiveField(3)
  String category;

  @HiveField(4)
  bool isFavourite;


//
  SearchResponseModel({this.text, this.url, this.image, this.category,this.isFavourite});

  factory SearchResponseModel.json(Map json,List<SearchResponseModel> localList){
    return SearchResponseModel(
      text: json['text'],
      url: json['url'],
      image: json['image'],
      category: json['category'],
      isFavourite:localList.firstWhere((element) => element.url == json['url'],orElse:()=> SearchResponseModel(isFavourite: false)).isFavourite
    );

  }

  static List<SearchResponseModel> ListFromJson(List listFromJson,List<SearchResponseModel> listFromLocal) {
    return listFromJson.map((e) => SearchResponseModel.json(e,listFromLocal)).toList();
  }




}

class SearchModelEdited{
  List<SearchResponseModel> searchResponseModel;
  bool isFavourite;

  SearchModelEdited(this.searchResponseModel, this.isFavourite);

  SearchModelEdited copyWith({
  SearchResponseModel searchResponseModel,
    bool isFavourite
}){
    return SearchModelEdited(
      searchResponseModel ?? this.searchResponseModel,
      isFavourite ?? this.isFavourite,
    );
  }
}
