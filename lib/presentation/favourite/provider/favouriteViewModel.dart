


import 'package:epl/domain/repository/FavoriteRepository.dart';
import 'package:epl/domain/repository/SeachRepositery.dart';
import 'package:epl/domain/usecases/SearchUseCase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Data/RequestHandler.dart';
import '../../../Data/StateModel.dart';
import '../../../domain/models/Favorite.dart';
import '../../../domain/models/Search.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../domain/repository/FavoriteRepositoryInterface.dart';
import '../../../domain/usecases/FavoriteUseCase.dart';



final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return SearchRepository(apiService);
});

final apiServiceProvider = Provider<RequestHandler>((ref) {
  return RequestHandler();
});

final searchProvider = StateNotifierProvider<SearchNotifier, StateModel<SearchModel>>((ref){
  final dataSearchUserCase = ref.read(getDataSearchUseCaseProvider);
  return SearchNotifier(dataSearchUserCase);
});

final getDataSearchUseCaseProvider = Provider<GetSearchUseCase>((ref) {
  final repository = ref.read(searchRepositoryProvider);
  return GetSearchUseCase(repository);
});


class SearchNotifier extends StateNotifier<StateModel<SearchModel>> {
  final GetSearchUseCase useCase;

  SearchNotifier(this.useCase) : super(StateModel.loading());

  Future<void> fetchDataSearch(String searchKey) async {
    try {
      state = StateModel.loading();
      final dataSearch = await useCase.execute(searchKey);
      state = dataSearch.competitions.isNotEmpty || dataSearch.teams.isNotEmpty
          ? StateModel.success(dataSearch)
          : StateModel.empty();
    } catch (e) {
      state = StateModel.fail("Failed to fetch overview: $e");
    }
  }
}



class FavoriteNotifier extends StateNotifier<StateModel<List<FavoriteModel>>> {
  final addFavoritesUseCase addUseCase;
  final removeFavoritesUseCase removeUseCase;
  final checkIfFavoritesUseCase checkUseCase;
  final GetAllFavoritesUseCase getAllFavoritesUseCase;

  FavoriteNotifier(
      this.addUseCase,
      this.removeUseCase,
      this.checkUseCase,
      this.getAllFavoritesUseCase,
      ) : super(StateModel.loading()) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      state = StateModel.loading();
      final favorites = await getAllFavoritesUseCase.execute();
      state = favorites.isNotEmpty
          ? StateModel.success(favorites)
          : StateModel.empty();
      state = StateModel.success(favorites);
    }catch(e){
      state = StateModel.fail("Failed to fetch overview: $e");

    }
  }

  Future<void> addFavorite(FavoriteModel favorite) async {
    try {
       await addUseCase.execute(favorite.id, favorite);

       state = StateModel.success([...state.data!, favorite]);

    } catch (e) {
      state = StateModel.fail("Failed to add favorite: $e");
    }
  }

  Future<void> removeFavorite(String id) async {
    try {
      await removeUseCase.execute(id);

      state = StateModel.success(state.data!.where((fav) => fav.id != id).toList());

    } catch (e) {
      state = StateModel.fail("Failed to remove favorite: $e");
    }
  }


  Future<void> toggleFavorite(FavoriteModel favorite) async {
    final isFav = await checkUseCase.execute(favorite.id);

    if (isFav) {
      await removeFavorite(favorite.id);
    } else {
      await addFavorite(favorite);
    }
  }

   Future<bool> isFavorite(String id) async {
    final isFav = await checkUseCase.execute(id);
    return isFav;
  }
}




final favoriteBoxProvider = Provider<Box<FavoriteModel>>((ref) {
  return Hive.box<FavoriteModel>('favorites');
});


final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  final box = ref.read(favoriteBoxProvider);
  return FavoriteRepository(box);
});

final favoriteProvider = StateNotifierProvider<FavoriteNotifier, StateModel<List<FavoriteModel>>>((ref) {
  final addFavoriteRepository = ref.read(addFavoriteUseCaseProvider);
  final removeFavoriteRepository = ref.read(removeFavoriteRepositoryProvider);
  final checkFavoriteRepository = ref.read(checkFavoriteRepositoryProvider);
  final getFavoritesRepository = ref.read(getFavoritesRepositoryProvider);

  return FavoriteNotifier(
      addFavoriteRepository,
      removeFavoriteRepository,
      checkFavoriteRepository,
      getFavoritesRepository
  );
});


final addFavoriteUseCaseProvider = Provider<addFavoritesUseCase>((ref) {
  final favoriteRepository = ref.read(favoriteRepositoryProvider);
  return addFavoritesUseCase(favoriteRepository);
});

final removeFavoriteRepositoryProvider = Provider<removeFavoritesUseCase>((ref) {
  final favoriteRepository = ref.read(favoriteRepositoryProvider);
  return removeFavoritesUseCase(favoriteRepository);
});

final getFavoritesRepositoryProvider = Provider<GetAllFavoritesUseCase>((ref) {
  final favoriteRepository = ref.read(favoriteRepositoryProvider);
  return GetAllFavoritesUseCase(favoriteRepository);
});

final checkFavoriteRepositoryProvider = Provider<checkIfFavoritesUseCase>((ref) {
  final favoriteRepository = ref.read(favoriteRepositoryProvider);
  return checkIfFavoritesUseCase(favoriteRepository);
});







