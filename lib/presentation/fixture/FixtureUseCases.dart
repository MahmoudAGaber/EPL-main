
import '../../domain/Models/Event.dart';
import '../../domain/Models/Formation.dart';
import '../../domain/Models/H2H.dart';
import '../../domain/Models/MatchStatistics.dart';
import '../../domain/Models/Standing.dart';
import '../../domain/Models/TeamForm.dart';
import 'MatchRepositry.dart';

class GetMatchEventsUseCase {
  final MatchRepositoryImpl repository;

  GetMatchEventsUseCase(this.repository);

  Future<List<EventModel>> execute(String fixtureId) {
    return repository.getMatchEvents(fixtureId);
  }
}

class GetMatchTeamFormUseCase {
  final MatchRepositoryImpl repository;

  GetMatchTeamFormUseCase(this.repository);

  Future<TeamFormModel> execute(String fixtureId) async {
    return repository.getMatchTeamForm(fixtureId);
  }
}

class GetLineUpsUseCase {
  final MatchRepositoryImpl repository;

  GetLineUpsUseCase(this.repository);

  Future<FormationsModel> execute(String fixtureId) {
    return repository.getLineUps(fixtureId);
  }
}

class GetTableUseCase {
  final MatchRepositoryImpl repository;

  GetTableUseCase(this.repository);

  Future<TableModel> execute(String seasonId,String type) {
    return repository.getTable(seasonId,type);
  }
}

class GetStatisticsUseCase {
  final MatchRepositoryImpl repository;

  GetStatisticsUseCase(this.repository);

  Future<List<MatchStatisticsModel>> execute(String fixtureId) {
    return repository.getStatistics(fixtureId);
  }
}

class GetH2HUseCase {
  final MatchRepositoryImpl repository;

  GetH2HUseCase(this.repository);

  Future<H2HModel> execute(String fixtureId) {
    return repository.getH2H(fixtureId);
  }
}