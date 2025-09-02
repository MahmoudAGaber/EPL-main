
import 'package:epl/domain/Models/Standing.dart';
import 'package:epl/domain/Models/Teams/Squad.dart';
import 'package:epl/domain/Models/Teams/TeamTrophy.dart';
import 'package:epl/domain/models/News.dart';
import 'package:epl/domain/models/Teams/teamOverview.dart';

import '../Models/Teams/TeamSeasons.dart';
import '../models/Teams/transfers.dart';
import '../repository/TeamRepositry.dart';

class GetTeamOverviewUseCase {
  final TeamRepositoryImpl repository;

  GetTeamOverviewUseCase(this.repository);

  Future<TeamOverviewModel> execute(String teamId, String seasonId) {
    return repository.getOverview(teamId, seasonId);
  }
}

class GetTeamNewsUseCase {
  final TeamRepositoryImpl repository;

  GetTeamNewsUseCase(this.repository);

  Future<List<NewsModel>> execute(String teamName) {
    return repository.getNews(teamName);
  }
}

class GetTeamVideosUseCase {
  final TeamRepositoryImpl repository;

  GetTeamVideosUseCase(this.repository);

  Future<List<NewsModel>> execute(String teamName) {
    return repository.getVideos(teamName);
  }
}

class GetTeamSeasonsUseCase {
  final TeamRepositoryImpl repository;

  GetTeamSeasonsUseCase(this.repository);

  Future<List<SeasonModel>> execute(String teamId) {
    return repository.getSeasons(teamId);
  }
}

class GetTeamMatchesUseCase {
  final TeamRepositoryImpl repository;

  GetTeamMatchesUseCase(this.repository);

  Future<List<FixtureOverview>> execute(String teamId, String seasonId) {
    return repository.getMatches(teamId, seasonId);
  }
}

class GetTeamStandingUseCase {
  final TeamRepositoryImpl repository;

  GetTeamStandingUseCase(this.repository);

  Future<TableModel> execute(String seasonId, String type) {
    return repository.getStanding(seasonId, type);
  }
}

class GetTeamSquadUseCase {
  final TeamRepositoryImpl repository;

  GetTeamSquadUseCase(this.repository);

  Future<SquadModel> execute(String teamId) {
    return repository.getSquad(teamId);
  }
}

class NormalizePositionUseCase {
  String execute(String? position) {
    if (position == null) return "unknown";

    switch (position.toLowerCase()) {
      case "goalkeeper":
      case "gk":
        return "goalkeeper";
      case "defender":
      case "df":
        return "defender";
      case "midfielder":
      case "mf":
        return "midfielder";
      case "attacker":
      case "forward":
      case "fw":
        return "attacker";
      default:
        return "unknown";
    }
  }

  String shortPosition(String? position) {
    if (position == null) return "unknown";

    switch (position.toLowerCase()) {
      case "goalkeeper":
      case "حارس مرمى":
        return "GK";
      case "defender":
      case "مدافع":
        return "DF";
      case "midfielder":
      case "لاعب وسط":
        return "MF";
      case "attacker":
      case "forward":
      case "مهاجم":
        return "FW";
      default:
        return "unknown";
    }
  }
}

class FilterPlayersByRoleUseCase {
  final NormalizePositionUseCase normalizePositionUseCase;

  FilterPlayersByRoleUseCase(this.normalizePositionUseCase);

  List<Person> execute(List<Person> players, String role) {
    return players.where((person) {
      final normalizedPosition = normalizePositionUseCase.execute(person.position);
      return normalizedPosition == role;
    }).toList();
  }
}


class GetTeamTransferUseCase {
  final TeamRepositoryImpl repository;

  GetTeamTransferUseCase(this.repository);

  Future<List<PlayerTransfer>> execute(String teamId) {
    return repository.getTransfers(teamId);
  }
}

class GetTeamTrophyUseCase {
  final TeamRepositoryImpl repository;

  GetTeamTrophyUseCase(this.repository);

  Future<List<TrophyModel>> execute(String teamId) {
    return repository.getTrophy(teamId);
  }
}

