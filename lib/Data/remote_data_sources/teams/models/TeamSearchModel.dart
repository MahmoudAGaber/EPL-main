import 'package:arseli/Data/local_data_sources/favourite/models/FavouriteTeamLocalModel.dart';
import 'package:arseli/Models/hosted_file.dart';
import 'package:equatable/equatable.dart';

class TeamBasicDataModel extends Equatable {
  String text;
  String url;
  HostedFile image;
  String category;

  TeamBasicDataModel({this.text, this.url, this.image, this.category});

  factory TeamBasicDataModel.json(Map json) {
    return TeamBasicDataModel(
      text: json['text'],
      url: json['url'],
      image: HostedFile(json['image']),
      category: json['category'],
    );
  }

  static List<TeamBasicDataModel> ListFromJson(List listFromJson) {
    return listFromJson.map((e) => TeamBasicDataModel.json(e)).toList();
  }

  @override
  // TODO: implement props
  List<Object> get props => [text, url, image, category];
}

class Team extends Equatable {
  final TeamBasicDataModel teamBasicDataModel;
  final bool isFavourite;

  Team(this.teamBasicDataModel, this.isFavourite);
  // to favourite
  FavouriteTeamLocalModel get favouriteTeamLocalModel =>
      FavouriteTeamLocalModel(
        text: teamBasicDataModel.text,
        url: teamBasicDataModel.url,
        image: teamBasicDataModel.image,
        category: teamBasicDataModel.category,
      );
  // copy with
  Team copyWith({
    TeamBasicDataModel teamBasicDataModel,
    bool isFavourite,
  }) {
    return Team(
      teamBasicDataModel ?? this.teamBasicDataModel,
      isFavourite ?? this.isFavourite,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [teamBasicDataModel, isFavourite];

// ==

}
