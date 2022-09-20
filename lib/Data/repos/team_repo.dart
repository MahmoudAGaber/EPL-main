import 'package:arseli/Data/local_data_sources/favourite/favourite_team_local_data_source.dart';
import 'package:arseli/Data/remote_data_sources/teams/models/TeamSearchModel.dart';
import 'package:arseli/Data/remote_data_sources/teams/teams_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class TeamRepo {
  final TeamsRemoteDataSource teamsRemoteDataSource;
  final FavouriteTeamLocalDataSource favouriteTeamLocalDataSource;

  TeamRepo(this.teamsRemoteDataSource, this.favouriteTeamLocalDataSource);

  Future<List<Team>> search(String search) async {
    final result = await teamsRemoteDataSource.search(search, CancelToken());
    final teams = result
        .map((e) => Team(e, favouriteTeamLocalDataSource.isExist(e.url)))
        .toList()
        .where((element) =>
            element.teamBasicDataModel.category ==
            favouriteTeamLocalDataSource.key)
        .toList();
    print('search repo: ${teams}');
    return teams;
  }

  List<Team> getAllFavorite() {
    final result = favouriteTeamLocalDataSource.getAll();
    final teams = result
        .map((e) => Team(e.toTeamBasicDataModel(),
            favouriteTeamLocalDataSource.isExist(e.url)))
        .toList();
    return teams;
  }

  void removeFavouriteTeam(Team teamSearchModel) async {
    return favouriteTeamLocalDataSource
        .delete(teamSearchModel.teamBasicDataModel.url);
  }

  void listFavouriteTeams(ValueSetter<List<Team>> callback) async {
    return favouriteTeamLocalDataSource.listen((_) =>
        callback(_.map((e) => Team(e.toTeamBasicDataModel(), true)).toList()));
  }

  // add to favourite
  Future<void> addToFavourite(Team teamSearchModel) async {
    return favouriteTeamLocalDataSource
        .add(teamSearchModel.favouriteTeamLocalModel);
  }
}
