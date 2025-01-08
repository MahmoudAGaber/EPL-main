
import '../../domain/Models/Event.dart';
import '../../domain/Models/Formation.dart';
import '../../domain/Models/H2H.dart';
import '../../domain/Models/MatchStatistics.dart';
import '../../domain/Models/Standing.dart';


abstract class MatchRepositoryInterface {
  Future<List<EventModel>> getMatchEvents(String fixtureId);
  Future<FormationsModel> getLineUps(String fixtureId);
  Future<List<MatchStatisticsModel>> getStatistics(String fixtureId);
  Future<TableModel> getTable(String seasonId,String type);
  Future<H2HModel> getH2H(String fixtureId);
}
