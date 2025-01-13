
import '../Models/Event.dart';
import '../Models/Formation.dart';
import '../Models/H2H.dart';
import '../Models/MatchStatistics.dart';
import '../Models/Standing.dart';


abstract class MatchRepositoryInterface {
  Future<List<EventModel>> getMatchEvents(String fixtureId);
  Future<FormationsModel> getLineUps(String fixtureId);
  Future<List<MatchStatisticsModel>> getStatistics(String fixtureId);
  Future<dynamic> getTable(String seasonId,String type);
  Future<H2HModel> getH2H(String fixtureId);
}
