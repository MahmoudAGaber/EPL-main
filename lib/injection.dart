import 'package:arseli/Data/local_data_sources/favourite/favourite_team_local_data_source.dart';
import 'package:arseli/Data/remote_data_sources/teams/teams_remote_data_source.dart';
import 'package:arseli/Data/repos/team_repo.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

class Injection {
  static final getIt = GetIt.instance;

  static setup() async {
    await GetStorage.init();
    getIt.registerSingleton<GetStorage>(
      GetStorage(),
    );

/*
    getIt.registerSingleton<TeamRepo>();
*/
/*
    getIt.registerFactory<MyFavouriteTeamsBloc>(() => MyFavouriteTeamsBloc(
          TeamRepo(TeamsRemoteDataSource(Get.find()),
              FavouriteTeamLocalDataSource(getIt.get<GetStorage>())),
        ));
    getIt.registerFactory<TeamSearchBloc>(() => TeamSearchBloc(
        getIt.get<TeamRepo>(), getIt.get<MyFavouriteTeamsBloc>()));
*/

    // TeamSearchBloc(TeamsRemoteDataSource());
/*    getIt.registerSingleton<Dio>(
      ConfiguredDio().dio,
    );
    final dio = getIt.get<Dio>();
    getIt.registerSingleton<MoviesRepoImpl>(
      MoviesRepoImpl(MoviesRemoteDataSource(dio), GenreMoviesGenerator()),
    );

    getIt.registerFactory<MoviesBloc>(() => MoviesBloc(
          GetMoviesUseCase(getIt.get<MoviesRepoImpl>()),
        ));
    getIt.registerFactory<MoviesSearchBloc>(() => MoviesSearchBloc(
          SearchMoviesUseCase(getIt.get<MoviesRepoImpl>()),
        ));*/
  }
}
