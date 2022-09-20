import 'package:arseli/Data/remote_data_sources/teams/models/TeamSearchModel.dart';
import 'package:arseli/Data/repos/team_repo.dart';
import 'package:arseli/controllers/search_controller.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  final TeamRepo teamRepo;
  final favouriteTeams = <Team>[].obs;
  final String tag;

  FavoritesController(this.teamRepo, this.tag);

  SearchController get searchController => Get.find<SearchController>(tag: tag);

  Future<void> addFavorite(int index) async {
    final team = searchController.searchState[index];
    await teamRepo.addToFavourite(team);
    favouriteTeams.add(team);
    searchController.searchState[index] = team.copyWith(isFavourite: true);
    searchController.teamSearchState.refresh();
  }

  Future<void> toggleFavourite(int index) async {
    final team = searchController.searchState[index];
    if (team.isFavourite) {
      removeFavorite(index);
    } else {
      await addFavorite(index);
    }
  }

  Future<void> removeFavorite(int index) async {
    final team = searchController.searchState[index];

    teamRepo.removeFavouriteTeam(team);
    favouriteTeams.removeWhere((element) =>
        element.teamBasicDataModel.url == team.teamBasicDataModel.url);
    searchController.searchState[index] = team.copyWith(isFavourite: false);
    searchController.teamSearchState.refresh();
  }

  @override
  void onInit() {
    super.onInit();
    this.favouriteTeams.addAll(teamRepo.getAllFavorite());
  }
}
