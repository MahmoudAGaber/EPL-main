import '../models/Favorite.dart';

abstract class FavoriteRepositoryInterface {
  Future<void> addToFavorites(FavoriteModel fav);
  Future<void> removeFromFavorites(String id);
  bool isFavorite(String id);
  List<FavoriteModel> getAllFavorites();
}
