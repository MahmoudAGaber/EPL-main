import 'package:arseli/Data/local_data_sources/favourite/models/FavouriteTeamLocalModel.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

class FavouriteTeamLocalDataSource {
  final GetStorage getStorage;
  final String key;

  FavouriteTeamLocalDataSource(this.getStorage, this.key);

  List<FavouriteTeamLocalModel> getAll() {
    final favouriteTeams = getStorage.read(key) ?? [];
    print(favouriteTeams);
    return (favouriteTeams as List)
        .map((e) => FavouriteTeamLocalModel.json(e))
        .toList();
  }

  // add
  Future<void> add(FavouriteTeamLocalModel favouriteTeamLocalModel) {
    final favouriteTeams = getAll();
    favouriteTeams.add(favouriteTeamLocalModel);
    final json = favouriteTeams.map((e) => e.toJson()).toList();
    return getStorage.write(key, json);
  }

  void listen(ValueSetter<List<FavouriteTeamLocalModel>> callback) {
    getStorage.listenKey(
        key,
        (_) => callback(
            (_ as List).map((e) => FavouriteTeamLocalModel.json(e)).toList()));
  }

  void delete(String id) async {
    final favouriteTeams = getAll();
    favouriteTeams.removeWhere((element) => element.url == id);
    await getStorage.write(key, favouriteTeams.map((e) => e.toJson()).toList());
  }

// is Exist
  bool isExist(String id) {
    final favouriteTeams = getAll();
    return favouriteTeams.any((element) => element.url == id);
  }
}
