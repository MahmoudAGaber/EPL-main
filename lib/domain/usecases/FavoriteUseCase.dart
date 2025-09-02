
import '../models/Favorite.dart';
import '../repository/FavoriteRepository.dart';
import '../repository/FavoriteRepositoryInterface.dart';

class GetAllFavoritesUseCase {
  final FavoriteRepository repository;

  GetAllFavoritesUseCase(this.repository);

  List<FavoriteModel> execute() {
    return repository.getAllFavorites();
  }
}

class addFavoritesUseCase {
  final FavoriteRepository repository;

  addFavoritesUseCase(this.repository);

  Future<void> execute(String id, FavoriteModel fav) {
    return repository.addToFavorites(fav);
  }
}


class removeFavoritesUseCase {
  final FavoriteRepository repository;

  removeFavoritesUseCase(this.repository);

  Future<void> execute(String id) {
    return repository.removeFromFavorites(id);
  }
}

class checkIfFavoritesUseCase {
  final FavoriteRepository repository;

  checkIfFavoritesUseCase(this.repository);

  bool execute(String id) {
    return repository.isFavorite(id);
  }
}