
import 'package:epl/domain/models/Teams/teamOverview.dart';
import 'package:epl/domain/models/Teams/transfers.dart';
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

final StandingTypeProvider = StateProvider<StandingType>((ref) => StandingType.All);



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

class TeamTransferNotifier extends StateNotifier<StateModel<List<PlayerTransfer>>> {
  final GetTeamTransferUseCase useCase;

  TeamTransferNotifier(this.useCase) : super(StateModel.loading());

  Future<void> fetchTeamTransfer(String teamId) async {
    try {
      state = StateModel.loading();
      final transfers = await useCase.execute(teamId);
      state = transfers.isNotEmpty
          ? StateModel.success(transfers)
          : StateModel.empty();
    } catch (e) {
      state = StateModel.fail("Failed to fetch overview: $e");
    }
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

final teamTransferProvider = StateNotifierProvider<TeamTransferNotifier, StateModel<List<PlayerTransfer>>>((ref) {
  final getTransfersUseCase = ref.read(getTransferUseCaseProvider);
  return TeamTransferNotifier(getTransfersUseCase);
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


final getTransferUseCaseProvider = Provider<GetTeamTransferUseCase>((ref) {
  final repository = ref.read(teamRepositoryProvider);
  return GetTeamTransferUseCase(repository);
});

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



