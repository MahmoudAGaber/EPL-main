import 'package:arseli/Data/remote_data_sources/teams/models/TeamSearchModel.dart';
import 'package:arseli/Models/hosted_file.dart';

class FavouriteTeamLocalModel {
  String text;
  String url;
  HostedFile image;
  String category;

  FavouriteTeamLocalModel({this.text, this.url, this.image, this.category});

  factory FavouriteTeamLocalModel.json(Map json) {
    return FavouriteTeamLocalModel(
      text: json['text'],
      url: json['url'],
      image: HostedFile(json['image']),
      category: json['category'],
    );
  }

// to json
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'url': url,
      'image': image.file,
      'category': category,
    };
  }

// to team basic
  TeamBasicDataModel toTeamBasicDataModel() => TeamBasicDataModel(
        text: text,
        url: url,
        image: image,
        category: category,
      );

  static List<FavouriteTeamLocalModel> ListFromJson(List listFromJson) {
    return listFromJson.map((e) => FavouriteTeamLocalModel.json(e)).toList();
  }
}
