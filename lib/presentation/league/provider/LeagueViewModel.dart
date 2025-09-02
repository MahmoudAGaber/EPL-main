
import 'package:epl/Data/RequestHandler.dart';
import 'package:epl/domain/Models/GroupStandings.dart';
import 'package:epl/domain/Models/Leagues/PlayerStats.dart';
import 'package:epl/domain/Models/Standing.dart';
import 'package:epl/domain/Models/Teams/TeamTrophy.dart';
import 'package:epl/domain/models/Leagues/teamStats.dart';
import 'package:epl/domain/repository/LeagueRepositry.dart';
import 'package:epl/domain/usecases/LeagueUseCases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../Data/StateModel.dart';
import '../../../domain/Models/Leagues/Seasons.dart';
import '../../../domain/Models/TeamForm.dart';
import '../../../domain/models/Leagues/trophies.dart';
import '../../../domain/models/News.dart';
import '../../../domain/models/Teams/teamOverview.dart';


enum LeagueStandingType {All, Home, Away }


final LeagueStandingTypeProvider = StateProvider<LeagueStandingType>((ref) => LeagueStandingType.All);

final requestHandlerProvider = Provider<RequestHandler>((ref) {
  return RequestHandler();
});

final leagueRepositoryProvider = Provider<LeagueRepositoryImpl>((ref) {
  final RequestHandler = ref.read(requestHandlerProvider);
  return LeagueRepositoryImpl(RequestHandler);
});


final getNewsUseCaseProvider = Provider<LeagueNewsUseCase>((ref) {
  final repository = ref.read(leagueRepositoryProvider);
  return LeagueNewsUseCase(repository);
});

// League Seasons UseCase Provider
final getLeagueSeasonsUseCaseProvider = Provider<LeagueSeasonsUseCase>((ref) {
  final repository = ref.read(leagueRepositoryProvider);
  return LeagueSeasonsUseCase(repository);
});

// Team Matches UseCase Provider
final getLeagueMatchesUseCaseProvider = Provider<LeagueMatchesUseCase>((ref) {
  final repository = ref.read(leagueRepositoryProvider);
  return LeagueMatchesUseCase(repository);
});

// League Standings UseCase Provider
final getLeagueStandingsUseCaseProvider = Provider<LeagueStandingsUseCase>((ref) {
  final repository = ref.read(leagueRepositoryProvider);
  return LeagueStandingsUseCase(repository);
});

// League Group Standings UseCase Provider
final getLeagueGroupStandingsUseCaseProvider = Provider<LeagueGroupStandingsUseCase>((ref) {
  final repository = ref.read(leagueRepositoryProvider);
  return LeagueGroupStandingsUseCase(repository);
});

// Player Stats UseCase Provider
final getPlayerStatsUseCaseProvider = Provider<LeaguePlayerStatsUseCase>((ref) {
  final repository = ref.read(leagueRepositoryProvider);
  return LeaguePlayerStatsUseCase(repository);
});

// Team Stats UseCase Provider
final getTeamStatsUseCaseProvider = Provider<LeagueTeamStatsUseCase>((ref) {
  final repository = ref.read(leagueRepositoryProvider);
  return LeagueTeamStatsUseCase(repository);
});

// Trophy UseCase Provider
final getTrophyUseCaseProvider = Provider<LeagueTrophiesUseCase>((ref) {
  final repository = ref.read(leagueRepositoryProvider);
  return LeagueTrophiesUseCase(repository);
});


final leagueNewsProvider = StateNotifierProvider<LeagueNewsNotifier, StateModel<List<NewsModel>>>((ref) {
  final leagueNewsUseCase = ref.watch(getNewsUseCaseProvider);
  return LeagueNewsNotifier(ref, leagueNewsUseCase);
});

// League Seasons Notifier Provider
final leagueSeasonsProvider = StateNotifierProvider<LeagueSeasonsNotifier, StateModel<LeagueSeasonsModel>>((ref) {
  final leagueSeasonsUseCase = ref.watch(getLeagueSeasonsUseCaseProvider);
  return LeagueSeasonsNotifier(ref, leagueSeasonsUseCase);
});

// Team Matches Notifier Provider
final leagueMatchesProvider = StateNotifierProvider<LeagueMatchesNotifier, StateModel<List<FixtureOverview>>>((ref) {
  final leagueMatchesUseCase = ref.watch(getLeagueMatchesUseCaseProvider);
  return LeagueMatchesNotifier(ref, leagueMatchesUseCase);
});

// League Standing Notifier Provider
final leagueStandingProvider = StateNotifierProvider<LeagueStandingNotifier, StateModel<TableModel>>((ref) {
  final leagueStandingsUseCase = ref.watch(getLeagueStandingsUseCaseProvider);
  return LeagueStandingNotifier(ref, leagueStandingsUseCase);
});

// League Group Standing Notifier Provider
final leagueGroupStandingProvider = StateNotifierProvider<LeagueGroupStandingNotifier, StateModel<GroupTableModel>>((ref) {
  final leagueGroupStandingsUseCase = ref.watch(getLeagueGroupStandingsUseCaseProvider);
  return LeagueGroupStandingNotifier(ref, leagueGroupStandingsUseCase);
});

// Player Stats Notifier Provider
final leaguePlayerStatsProvider = StateNotifierProvider<PlayerStatsNotifier, StateModel<List<PlayerStatsModel>>>((ref) {
  final leaguePlayerStatsUseCase = ref.watch(getPlayerStatsUseCaseProvider);
  return PlayerStatsNotifier(ref, leaguePlayerStatsUseCase);
});

// Team Stats Notifier Provider
final leagueTeamStatsProvider = StateNotifierProvider<TeamStatsNotifier, StateModel<List<TeamStatsModel>>>((ref) {
  final leagueTeamStatsUseCase = ref.watch(getTeamStatsUseCaseProvider);
  return TeamStatsNotifier(ref, leagueTeamStatsUseCase);
});

// Trophy Notifier Provider
final leagueTrophyProvider = StateNotifierProvider<TrophyNotifier, StateModel<LeagueTrophies>>((ref) {
  final leagueTrophyUseCase = ref.watch(getTrophyUseCaseProvider);
  return TrophyNotifier(ref, leagueTrophyUseCase);
});



class LeagueStandingNotifier extends StateNotifier<StateModel<TableModel>> {
  Ref ref;
  final LeagueStandingsUseCase useCase;

  LeagueStandingNotifier(this.ref, this.useCase) : super(StateModel.loading());

  Future<void> getTable(String seasonId, String type) async {
    try {
      state = StateModel.loading();
      final tableModel = await useCase.execute(seasonId, type);
      if (tableModel.standings.isNotEmpty) {
        state = StateModel.success(tableModel);
      } else {
        state = StateModel.empty();
      }
    } catch (e) {
      state = StateModel.fail("Failed to get data: $e");
    }
  }
}

class LeagueGroupStandingNotifier extends StateNotifier<StateModel<GroupTableModel>> {
  Ref ref;
  final LeagueGroupStandingsUseCase useCase;

  LeagueGroupStandingNotifier(this.ref, this.useCase) : super(StateModel.loading());

  Future<void> getTable(String seasonId, String type) async {
    try {
      state = StateModel.loading();
      final tableModel = await useCase.execute(seasonId, type);
      if (tableModel.standings.isNotEmpty) {
        state = StateModel.success(tableModel);
      } else {
        state = StateModel.empty();
      }
    } catch (e) {
      state = StateModel.fail("Failed to get data: $e");
    }
  }
}

class LeagueNewsNotifier extends StateNotifier<StateModel<List<NewsModel>>> {
  Ref ref;
  final LeagueNewsUseCase useCase;

  LeagueNewsNotifier(this.ref, this.useCase) : super(StateModel.loading());

  Future<void> getNews(String teamName) async {
    try {
      state = StateModel.loading();
      final news = await useCase.execute(teamName);
      final filteredNews = news.where((element) => element.type == "article" || element.type == "tweet").toList();
      state = StateModel.success(filteredNews);
    } catch (e) {
      state = StateModel.fail("Failed to get data: $e");
    }
  }
}

class LeagueSeasonsNotifier extends StateNotifier<StateModel<LeagueSeasonsModel>> {
  Ref ref;
  final LeagueSeasonsUseCase useCase;

  LeagueSeasonsNotifier(this.ref, this.useCase) : super(StateModel.loading());

  Future<String?> getLeagueSeasons(String leagueId) async {
    try {
      state = StateModel.loading();
      final leagueSeasonsModel = await useCase.execute(leagueId);
      leagueSeasonsModel.competition.season.sort((a, b) => b.startDate.compareTo(a.startDate));
      state = StateModel.success(leagueSeasonsModel);
      print(leagueSeasonsModel);
      return leagueSeasonsModel.competition.season.first.seasonId;
    } catch (e) {
      state = StateModel.fail("Failed to get data: $e");
      return null;
    }
  }
}

class LeagueMatchesNotifier extends StateNotifier<StateModel<List<FixtureOverview>>> {
  Ref ref;
  final LeagueMatchesUseCase useCase;

  LeagueMatchesNotifier(this.ref, this.useCase) : super(StateModel.loading());

  Future<void> getMatches(String seasonId) async {
    try {
      state = StateModel.loading();
      final matches = await useCase.execute(seasonId);
      state = StateModel.success(matches);
    } catch (e) {
      state = StateModel.fail("Failed to get data: $e");
    }
  }
}

class PlayerStatsNotifier extends StateNotifier<StateModel<List<PlayerStatsModel>>> {
  Ref ref;
  final LeaguePlayerStatsUseCase useCase;

  PlayerStatsNotifier(this.ref, this.useCase) : super(StateModel.loading());

  Future<void> getPlayerStats(String seasonId) async {
    try {
      state = StateModel.loading();
      final playerStats = await useCase.execute(seasonId);
      state = StateModel.success(playerStats);
    } catch (e) {
      state = StateModel.fail("Failed to get data: $e");
    }
  }
}

class TeamStatsNotifier extends StateNotifier<StateModel<List<TeamStatsModel>>> {
  Ref ref;
  final LeagueTeamStatsUseCase useCase;

  TeamStatsNotifier(this.ref, this.useCase) : super(StateModel.loading());

  Future<void> getTeamStats(String seasonId) async {
    try {
      state = StateModel.loading();
      final teamStats = await useCase.execute(seasonId);
      state = StateModel.success(teamStats);
    } catch (e) {
      state = StateModel.fail("Failed to get data: $e");
    }
  }
}

class TrophyNotifier extends StateNotifier<StateModel<LeagueTrophies>> {
  Ref ref;
  final LeagueTrophiesUseCase useCase;

  TrophyNotifier(this.ref, this.useCase) : super(StateModel.loading());

  Future<void> getTrophy(String competitionId) async {
    try {
      state = StateModel.loading();
      final trophyModel = await useCase.execute(competitionId);

      trophyModel.seasons.sort((a, b)=> b.startDate.compareTo(a.startDate));
      state = StateModel.success(trophyModel);
    } catch (e) {
      state = StateModel.fail("Failed to get data: $e");
    }
  }
}







