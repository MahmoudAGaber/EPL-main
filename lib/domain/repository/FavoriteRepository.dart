import 'package:hive/hive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/Favorite.dart';
import 'FavoriteRepositoryInterface.dart';

class FavoriteRepository implements FavoriteRepositoryInterface {
  static const String _boxName = "favorites";
  late Box<FavoriteModel> _favoritesBox;

  FavoriteRepository(this._favoritesBox) {
    _init();
  }

  Future<void> _init() async {
    _favoritesBox = await Hive.openBox<FavoriteModel>(_boxName);
  }

  @override
  Future<void> addToFavorites(FavoriteModel fav) async {
    await _favoritesBox.put(fav.id, fav);
  }

  @override
  Future<void> removeFromFavorites(String id) async {
    await _favoritesBox.delete(id);
  }

  @override
  bool isFavorite(String id) {
    return _favoritesBox.containsKey(id);
  }

  @override
  List<FavoriteModel> getAllFavorites() {
    return _favoritesBox.values.cast<FavoriteModel>().toList().reversed.toList();

  }
}
