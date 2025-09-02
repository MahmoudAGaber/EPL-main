import 'package:epl/Data/RequestHandler.dart';
import 'package:epl/domain/repository/LeagueRepositeryInterface.dart';
import 'package:epl/domain/repository/LeagueRepositry.dart';

import '../../../domain/Models/GroupStandings.dart';
import '../../../domain/Models/Leagues/Seasons.dart';
import '../../../domain/Models/Standing.dart';
import '../../../domain/Models/TeamForm.dart';
import '../../../domain/Models/Teams/TeamTrophy.dart';
import '../../../domain/models/Leagues/teamStats.dart';
import '../../../domain/models/News.dart';
import '../../../domain/Models/Leagues/PlayerStats.dart';
import '../models/Leagues/trophies.dart';
import '../models/Teams/teamOverview.dart';


class LeagueNewsUseCase {
  final LeagueRepositoryImpl repository;
  LeagueNewsUseCase(this.repository);

  Future<List<NewsModel>> execute(String teamName) {
    return repository.fetchNews(teamName);
  }
}

class LeagueSeasonsUseCase {
  final LeagueRepositoryImpl repository;
  LeagueSeasonsUseCase(this.repository);

  Future<LeagueSeasonsModel> execute(String leagueId) {
    return repository.fetchLeagueSeasons(leagueId);
  }
}

class LeagueMatchesUseCase {
  final LeagueRepositoryImpl repository;
  LeagueMatchesUseCase(this.repository);

  Future<List<FixtureOverview>> execute(String seasonId) {
    return repository.fetchLeagueMatches(seasonId);
  }
}

class LeagueStandingsUseCase {
  final LeagueRepositoryImpl repository;
  LeagueStandingsUseCase(this.repository);

  Future<TableModel> execute(String seasonId, String type) {
    return repository.fetchLeagueStandings(seasonId, type);
  }
}

class LeagueGroupStandingsUseCase {
  final LeagueRepositoryImpl repository;
  LeagueGroupStandingsUseCase(this.repository);

  Future<GroupTableModel> execute(String seasonId, String type) {
    return repository.fetchGroupStandings(seasonId, type);
  }
}

class LeaguePlayerStatsUseCase {
  final LeagueRepositoryImpl repository;
  LeaguePlayerStatsUseCase(this.repository);

  Future<List<PlayerStatsModel>> execute(String seasonId) {
    return repository.fetchPlayerStats(seasonId);
  }
}

class LeagueTeamStatsUseCase {
  final LeagueRepositoryImpl repository;
  LeagueTeamStatsUseCase(this.repository);

  Future<List<TeamStatsModel>> execute(String seasonId) {
    return repository.fetchTeamStats(seasonId);
  }
}

class LeagueTrophiesUseCase {
  final LeagueRepositoryImpl repository;
  LeagueTrophiesUseCase(this.repository);

  Future<LeagueTrophies> execute(String competitionId) {
    return repository.fetchTrophies(competitionId);
  }
}
