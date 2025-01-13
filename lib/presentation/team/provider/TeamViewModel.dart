
import 'package:epl/domain/models/Teams/teamOverview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Data/RequestHandler.dart';
import '../../../Data/StateModel.dart';
import '../../../domain/Models/Standing.dart';
import '../../../domain/Models/TeamForm.dart';
import '../../../domain/Models/Teams/Squad.dart';
import '../../../domain/Models/Teams/TeamSeasons.dart';
import '../../../domain/Models/Teams/TeamTrophy.dart';
import '../../../domain/models/News.dart';
import '../../../domain/repository/TeamRepositry.dart';
import '../../../domain/usecases/TeamUseCases.dart';


enum StandingType {All, Home, Away }
//
// final TeamOverviewProvider = StateNotifierProvider<TeamOverviewNotifier,StateModel<TeamOverviewModel>>((ref) => TeamOverviewNotifier(ref));
//
// final TeamNewsProvider = StateNotifierProvider<TeamNewsNotifier,StateModel<List<NewsModel>>>((ref) => TeamNewsNotifier(ref));
//
// final TeamVideosProvider = StateNotifierProvider<TeamVideosNotifier,StateModel<List<NewsModel>>>((ref) => TeamVideosNotifier(ref));
//
// final TeamMatchesProvider = StateNotifierProvider<TeamMatchesNotifier,StateModel<List<FixtureOverview>>>((ref) => TeamMatchesNotifier(ref));
//
// final TeamSeasonsProvider = StateNotifierProvider<TeamSeasonsNotifier,StateModel<List<SeasonModel>>>((ref) => TeamSeasonsNotifier(ref));
//
// final TeamTableProvider = StateNotifierProvider<TeamTableNotifier,StateModel<TableModel>>((ref) => TeamTableNotifier(ref));

final StandingTypeProvider = StateProvider<StandingType>((ref) => StandingType.All);

// final SquadProvider = StateNotifierProvider<SquadNotifier,StateModel<SquadModel>>((ref) => SquadNotifier(ref));
//
// final TrophyProvider = StateNotifierProvider<TrophyNotifier,StateModel<List<TrophyModel>>>((ref) => TrophyNotifier(ref));
//
//
//
// class TeamOverviewNotifier extends StateNotifier<StateModel<TeamOverviewModel>>{
//   Ref ref;
//   TeamOverviewNotifier(this.ref):super(StateModel.loading());
//
//   Future<void> getTeamOverview(String teamId, String seasonId) async{
//     RequestHandler requestHandler = RequestHandler();
//     TeamOverviewModel teamOverviewModel ;
//     Map<String, dynamic> body;
//     try {
//       body = {
//         "team_id": teamId,
//         "season_id": seasonId
//       };
//
//       state = StateModel.loading();
//
//       teamOverviewModel = await requestHandler.postData(
//         endPoint: "soccer/team/overview",
//         auth: true,
//         requestBody: body,
//         fromJson: (json)=> TeamOverviewModel.fromJson(json),
//       );
//
//       print("HELLOGUYS${teamOverviewModel}");
//
//     List<FixtureOverview> finishedFixtures = teamOverviewModel.fixtures
//         .where((fixture) => fixture.fixture.status.short == 'FT')
//         .toList();
//
//       teamOverviewModel.fixtures = finishedFixtures;
//     teamOverviewModel.fixtures.sort((a, b) => b.fixture.timestamp.compareTo(a.fixture.timestamp));
//
//       state = StateModel.success(teamOverviewModel);
//
//     }catch(e){
//       state = StateModel.fail("Faild to get data $e");
//     }
//   }
//
// }
//
// class TeamNewsNotifier extends StateNotifier<StateModel<List<NewsModel>>>{
//   Ref ref;
//   TeamNewsNotifier(this.ref):super(StateModel.loading());
//
//   Future<void> getNews(String teamName) async{
//     RequestHandler requestHandler = RequestHandler();
//     NewsResponse newsResponse;
//     List<NewsModel> news = [];
//     Map<String, dynamic> body;
//     try {
//       body = {
//         "search_string": teamName,
//       };
//
//       state = StateModel.loading();
//
//       newsResponse = await requestHandler.postData(
//         endPoint: "soccer/team/news",
//         auth: true,
//         requestBody: body,
//         fromJson: (json)=> NewsResponse.fromJson(json),
//       );
//
//       news = newsResponse.news;
//
//        List<NewsModel> filteredNews = news.where((element) => element.type == "article" || element.type == "tweet").toList();
//
//       state = StateModel.success(filteredNews);
//
//     }catch(e){
//       state = StateModel.fail("Faild to get data $e");
//     }
//   }
//
// }
//
// class TeamVideosNotifier extends StateNotifier<StateModel<List<NewsModel>>>{
//   Ref ref;
//   TeamVideosNotifier(this.ref):super(StateModel.loading());
//
//
//   Future<void> getVideos(String teamName) async{
//     RequestHandler requestHandler = RequestHandler();
//     NewsResponse newsResponse;
//     List<NewsModel> news = [];
//     Map<String, dynamic> body;
//     try {
//       body = {
//         "search_string": teamName,
//       };
//
//       state = StateModel.loading();
//
//       newsResponse = await requestHandler.postData(
//         endPoint: "soccer/team/news",
//         auth: true,
//         requestBody: body,
//         fromJson: (json)=> NewsResponse.fromJson(json),
//       );
//
//
//       news = newsResponse.news;
//
//       List<NewsModel> filteredNews = news.where((element) => element.type == "youtube-video").toList();
//
//       state = StateModel.success(filteredNews);
//
//     }catch(e){
//       state = StateModel.fail("Faild to get data $e");
//     }
//   }
// }
//
// class TeamSeasonsNotifier extends StateNotifier<StateModel<List<SeasonModel>>>{
//   Ref ref;
//   TeamSeasonsNotifier(this.ref):super(StateModel.loading());
//
//
//   Future<String?> getTeamSeasons(String teamId) async{
//     RequestHandler requestHandler = RequestHandler();
//     List<SeasonModel> teamSeasons = [];
//     Map<String, dynamic> body;
//     try {
//       body = {
//         "lang": "en",
//         "team_id": teamId
//       };
//
//       state = StateModel.loading();
//
//       teamSeasons = await requestHandler.postData(
//         endPoint: "soccer/team/seasons",
//         auth: true,
//         requestBody: body,
//         fromJson: (json)=> SeasonModel.listFromJson(json),
//       );
//
//       teamSeasons =  teamSeasons.where((element) => element.name.contains("/")).toList();
//       teamSeasons.sort((a, b) => b.startDate.split("/").first.compareTo(a.startDate.split("/").first));
//
//       state = StateModel.success(teamSeasons);
//
//       return teamSeasons.first.seasonId;
//     }catch(e){
//       state = StateModel.fail("Faild to get data $e");
//       return null;
//     }
//   }
// }
//
// class TeamMatchesNotifier extends StateNotifier<StateModel<List<FixtureOverview>>>{
//   Ref ref;
//   TeamMatchesNotifier(this.ref):super(StateModel.loading());
//
//
//   Future<void> getMatches(String teamId, String seasonId) async{
//     RequestHandler requestHandler = RequestHandler();
//     List<FixtureOverview> matches = [];
//     Map<String, dynamic> body;
//     try {
//       body = {
//         "lang": "en",
//         "season_id": seasonId,
//         "team_id": teamId
//       };
//
//       state = StateModel.loading();
//
//       matches = await requestHandler.postData(
//         endPoint: "soccer/team/matches",
//         auth: true,
//         requestBody: body,
//         fromJson: (json)=> FixtureOverview.listFromJson(json),
//       );
//
//
//       state = StateModel.success(matches);
//
//     }catch(e){
//       state = StateModel.fail("Faild to get data $e");
//     }
//   }
// }
//
// class TeamTableNotifier extends StateNotifier<StateModel<TableModel>>{
//   Ref ref;
//   TeamTableNotifier(this.ref):super(StateModel.loading());
//
//   Future<void> getTable(String season_id,String type) async{
//     RequestHandler requestHandler = RequestHandler();
//     TableModel tableModel;
//     Map<String, dynamic> body;
//
//     body = {
//       "season_id": season_id,
//       "lang": "ar",
//       "type": type
//     };
//
//     try{
//       state = StateModel.loading();
//       tableModel = await requestHandler.postData(
//         endPoint: "soccer/team/table",
//         auth: true,
//         requestBody: body,
//         fromJson: (json) => TableModel.fromJson(json),
//       );
//       if(tableModel.standings![0].isNotEmpty){
//         state = StateModel.success(tableModel);
//
//       }else{
//         state = StateModel.empty();
//       }
//
//     }catch(e){
//       state = StateModel.fail("Faild to get data $e");
//     }
//   }
//
// }
//
// class SquadNotifier extends StateNotifier<StateModel<SquadModel>> {
//   Ref ref;
//   SquadNotifier(this.ref) : super(StateModel.loading());
//
//   List<Person> players = [];
//
//   Future<void> getSquad(String teamId) async {
//     RequestHandler requestHandler = RequestHandler();
//     SquadModel squadModel;
//     Map<String, dynamic> body;
//
//     body = {
//       "team_id": teamId,
//       "lang": "en",
//     };
//
//     try {
//       state = StateModel.loading();
//       squadModel = await requestHandler.postData(
//         endPoint: "soccer/team/squads",
//         auth: true,
//         requestBody: body,
//         fromJson: (json) => SquadModel.fromJson(json),
//       );
//
//       players = squadModel.person;
//
//
//       state = StateModel.success(squadModel);
//     } catch (e) {
//       state = StateModel.fail("Failed to get data $e");
//     }
//   }
//
//   String normalizePosition(String? position) {
//     if (position == null) return "unknown";
//
//     switch (position.toLowerCase()) {
//       case "goalkeeper":
//       case "gk":
//         return "goalkeeper";
//       case "defender":
//       case "df":
//         return "defender";
//       case "midfielder":
//       case "mf":
//         return "midfielder";
//       case "attacker":
//       case "forward":
//       case "fw":
//         return "attacker";
//       default:
//         return "unknown";
//     }
//   }
//
//   // Getters for different roles
//   List<Person> getCoach() {
//     return players.where((person) {
//       return person.type == "assistant coach" || person.type == "coach";
//     }).toList();
//   }
//
//   List<Person> getGoalKeepers() {
//     return players.where((person) {
//       return normalizePosition(person.position) == "goalkeeper";
//     }).toList();
//   }
//
//   List<Person> getDefenders() {
//     return players.where((person) {
//       return normalizePosition(person.position) == "defender";
//     }).toList();
//   }
//
//   List<Person> getMidfielders() {
//     return players.where((person) {
//       return normalizePosition(person.position) == "midfielder";
//     }).toList();
//   }
//
//   List<Person> getAttackers() {
//     return players.where((person) {
//       return normalizePosition(person.position) == "attacker";
//     }).toList();
//   }
//
// }
//
// class TrophyNotifier extends StateNotifier<StateModel<List<TrophyModel>>>{
//   Ref ref;
//   TrophyNotifier(this.ref):super(StateModel.loading());
//
//   Future<void> getTrophy(String teamId) async{
//     RequestHandler requestHandler = RequestHandler();
//     List<TrophyModel> trophyModel = [];
//     Map<String, dynamic> body;
//
//     body = {
//       "team_id": teamId,
//       "lang": "ar",
//
//     };
//
//
//       state = StateModel.loading();
//       trophyModel = await requestHandler.postData(
//         endPoint: "soccer/team/trophy",
//         auth: true,
//         requestBody: body,
//         fromJson: (json) => TrophyModel.listFromJson(json),
//       );
//         state = StateModel.success(trophyModel);
//
//
//   }
//
// }


class TeamOverview1Notifier extends StateNotifier<StateModel<TeamOverviewModel>> {
  final GetTeamOverviewUseCase useCase;

  TeamOverview1Notifier(this.useCase) : super(StateModel.loading());

  Future<void> fetchTeamOverview(String teamId, String seasonId) async {
    try {
      state = StateModel.loading();
      final overview = await useCase.execute(teamId, seasonId);
      state = overview.teamId.isNotEmpty
          ? StateModel.success(overview)
          : StateModel.empty();
    } catch (e) {
      state = StateModel.fail("Failed to fetch overview: $e");
    }
  }
}

class TeamNews1Notifier extends StateNotifier<StateModel<List<NewsModel>>> {
  final GetTeamNewsUseCase useCase;

  TeamNews1Notifier(this.useCase) : super(StateModel.loading());

  Future<void> fetchTeamNews(String teamName) async {
    try {
      state = StateModel.loading();
      final news = await useCase.execute(teamName);
      state = news.isNotEmpty
          ? StateModel.success(news)
          : StateModel.empty();
    } catch (e) {
      state = StateModel.fail("Failed to fetch overview: $e");
    }
  }
}

class TeamVideos1Notifier extends StateNotifier<StateModel<List<NewsModel>>> {
  final GetTeamVideosUseCase useCase;

  TeamVideos1Notifier(this.useCase) : super(StateModel.loading());

  Future<void> fetchTeamVideos(String teamName) async {
    try {
      state = StateModel.loading();
      final videos = await useCase.execute(teamName);
      state = videos.isNotEmpty
          ? StateModel.success(videos)
          : StateModel.empty();
    } catch (e) {
      state = StateModel.fail("Failed to fetch overview: $e");
    }
  }
}

class TeamMatches1Notifier extends StateNotifier<StateModel<List<FixtureOverview>>> {
  final GetTeamMatchesUseCase useCase;

  TeamMatches1Notifier(this.useCase) : super(StateModel.loading());

  Future<void> fetchTeamMatches(String teamId, String seasonId) async {
    try {
      state = StateModel.loading();
      final matches = await useCase.execute(teamId, seasonId);
      state = matches.isNotEmpty
          ? StateModel.success(matches)
          : StateModel.empty();
    } catch (e) {
      state = StateModel.fail("Failed to fetch overview: $e");
    }
  }
}

class TeamSeasons1Notifier extends StateNotifier<StateModel<List<SeasonModel>>> {
  final GetTeamSeasonsUseCase useCase;

  TeamSeasons1Notifier(this.useCase) : super(StateModel.loading());

  Future<String?> fetchTeamSeasons(String teamId) async {
    try {
      state = StateModel.loading();
      final seasons = await useCase.execute(teamId);
      state = seasons.isNotEmpty
          ? StateModel.success(seasons)
          : StateModel.empty();

      return seasons[0].seasonId;
    } catch (e) {
      state = StateModel.fail("Failed to fetch overview: $e");
      return null;
    }
  }
}

class TeamStanding1Notifier extends StateNotifier<StateModel<TableModel>> {
  final GetTeamStandingUseCase useCase;

  TeamStanding1Notifier(this.useCase) : super(StateModel.loading());

  Future<void> fetchTeamStanding(String seasonId, String type) async {
    try {
      state = StateModel.loading();
      final standing = await useCase.execute(seasonId, type);
      state = standing.standings[0].isNotEmpty
          ? StateModel.success(standing)
          : StateModel.empty();
    } catch (e) {
      state = StateModel.fail("Failed to fetch overview: $e");
    }
  }
}

class TeamSquad1Notifier extends StateNotifier<StateModel<SquadModel>> {
  final GetTeamSquadUseCase useCase;
  final FilterPlayersByRoleUseCase filterPlayersByRoleUseCase;
  final NormalizePositionUseCase normalizePositionUseCase;
  List<Person> players = [];
  TeamSquad1Notifier(
      this.useCase,
      this.filterPlayersByRoleUseCase,
      this.normalizePositionUseCase) : super(StateModel.loading());

  Future<void> fetchTeamSquad(String teamId) async {
    try {
      state = StateModel.loading();
      final squad = await useCase.execute(teamId);
      print("ProviderTestSquad${squad.person}");
      players = squad.person;
      state = squad.person.isNotEmpty
          ? StateModel.success(squad)
          : StateModel.empty();
    } catch (e) {
      state = StateModel.fail("Failed to fetch overview: $e");
    }
  }
  List<Person> getCoach() {
    return players.where((person) {
      return person.type == "assistant coach" || person.type == "coach";
    }).toList();
  }

  List<Person> getGoalKeepers() {
    return filterPlayersByRoleUseCase.execute(players, "goalkeeper");
  }

  List<Person> getDefenders() {
    return filterPlayersByRoleUseCase.execute(players, "defender");
  }

  List<Person> getMidfielders() {
    return filterPlayersByRoleUseCase.execute(players, "midfielder");
  }

  List<Person> getAttackers() {
    return filterPlayersByRoleUseCase.execute(players, "attacker");
  }
}

class TeamTrophy1Notifier extends StateNotifier<StateModel<List<TrophyModel>>> {
  final GetTeamTrophyUseCase useCase;

  TeamTrophy1Notifier(this.useCase) : super(StateModel.loading());

  Future<void> fetchTeamTrophy(String teamId) async {
    try {
      state = StateModel.loading();
      final trophy = await useCase.execute(teamId);
      state = trophy.isNotEmpty
          ? StateModel.success(trophy)
          : StateModel.empty();
    } catch (e) {
      state = StateModel.fail("Failed to fetch overview: $e");
    }
  }
}

final teamOverviewProvider = StateNotifierProvider<TeamOverview1Notifier, StateModel<TeamOverviewModel>>((ref) {
  final getOverviewUseCase = ref.read(getOverViewUseCaseProvider);
  return TeamOverview1Notifier(getOverviewUseCase);
},
);

final teamNewsProvider = StateNotifierProvider<TeamNews1Notifier, StateModel<List<NewsModel>>>((ref) {
  final getNewsUseCase = ref.read(getNewsUseCaseProvider);
  return TeamNews1Notifier(getNewsUseCase);
},
);

final teamVideosProvider = StateNotifierProvider<TeamVideos1Notifier, StateModel<List<NewsModel>>>((ref) {
  final getVideosUseCase = ref.read(getVideosUseCaseProvider);
  return TeamVideos1Notifier(getVideosUseCase);
},
);

final teamSeasonsProvider = StateNotifierProvider<TeamSeasons1Notifier, StateModel<List<SeasonModel>>>((ref) {
  final getSeasonsUseCase = ref.read(getSeasonsUseCaseProvider);
  return TeamSeasons1Notifier(getSeasonsUseCase);
},
);

final teamMatchesProvider = StateNotifierProvider<TeamMatches1Notifier, StateModel<List<FixtureOverview>>>((ref) {
  final getMatchesUseCase = ref.read(getMatchesUseCaseProvider);
  return TeamMatches1Notifier(getMatchesUseCase);
},
);

final teamStandingProvider = StateNotifierProvider<TeamStanding1Notifier, StateModel<TableModel>>((ref) {
  final getStandingUseCase = ref.read(getStandingUseCaseProvider);
  return TeamStanding1Notifier(getStandingUseCase);
},
);

final teamSquadProvider = StateNotifierProvider<TeamSquad1Notifier, StateModel<SquadModel>>((ref) {
  final getSquadUseCase = ref.read(getSquadUseCaseProvider);
  final getFilterPlayersByRoleUseCase = ref.read(filterPlayersByRoleUseCaseProvider);
  final getNormalizePositionUseCase = ref.read(normalizePositionUseCaseProvider);
  return TeamSquad1Notifier(getSquadUseCase,getFilterPlayersByRoleUseCase,getNormalizePositionUseCase,);
},
);

final teamTrophyProvider = StateNotifierProvider<TeamTrophy1Notifier, StateModel<List<TrophyModel>>>((ref) {
  final getTrophyUseCase = ref.read(getTrophyUseCaseProvider);
  return TeamTrophy1Notifier(getTrophyUseCase);
},
);


final getOverViewUseCaseProvider = Provider<GetTeamOverviewUseCase>((ref) {
  final repository = ref.read(teamRepositoryProvider);
  return GetTeamOverviewUseCase(repository);
});

final getNewsUseCaseProvider = Provider<GetTeamNewsUseCase>((ref) {
  final repository = ref.read(teamRepositoryProvider);
  return GetTeamNewsUseCase(repository);
});

final getVideosUseCaseProvider = Provider<GetTeamVideosUseCase>((ref) {
  final repository = ref.read(teamRepositoryProvider);
  return GetTeamVideosUseCase(repository);
});

final getSeasonsUseCaseProvider = Provider<GetTeamSeasonsUseCase>((ref) {
  final repository = ref.read(teamRepositoryProvider);
  return GetTeamSeasonsUseCase(repository);
});

final getMatchesUseCaseProvider = Provider<GetTeamMatchesUseCase>((ref) {
  final repository = ref.read(teamRepositoryProvider);
  return GetTeamMatchesUseCase(repository);
});

final getStandingUseCaseProvider = Provider<GetTeamStandingUseCase>((ref) {
  final repository = ref.read(teamRepositoryProvider);
  return GetTeamStandingUseCase   (repository);
});

final getSquadUseCaseProvider = Provider<GetTeamSquadUseCase>((ref) {
  final repository = ref.read(teamRepositoryProvider);
  return GetTeamSquadUseCase(repository);
});

final normalizePositionUseCaseProvider = Provider((ref) => NormalizePositionUseCase());

final filterPlayersByRoleUseCaseProvider = Provider(
      (ref) => FilterPlayersByRoleUseCase(ref.read(normalizePositionUseCaseProvider)),
);


final getTrophyUseCaseProvider = Provider<GetTeamTrophyUseCase>((ref) {
  final repository = ref.read(teamRepositoryProvider);
  return GetTeamTrophyUseCase(repository);
});



final teamRepositoryProvider = Provider<TeamRepositoryImpl>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return TeamRepositoryImpl(apiService);
});

final apiServiceProvider = Provider<RequestHandler>((ref) {
  return RequestHandler();
});



