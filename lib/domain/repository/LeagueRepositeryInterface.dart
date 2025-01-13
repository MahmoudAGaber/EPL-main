
import 'package:epl/domain/Models/Teams/TeamTrophy.dart';
import '../../../domain/Models/GroupStandings.dart';
import '../../../domain/Models/Leagues/PlayerStats.dart';
import '../../../domain/Models/Leagues/Seasons.dart';
import '../../../domain/Models/Standing.dart';
import '../../../domain/models/Leagues/teamStats.dart';
import '../../../domain/models/News.dart';
import '../models/Teams/teamOverview.dart';


abstract class LeagueRepositoryInterface {

  Future<List<NewsModel>> fetchNews(String teamName);
  Future<LeagueSeasonsModel> fetchLeagueSeasons(String leagueId);
  Future<List<FixtureOverview>> fetchLeagueMatches(String seasonId);
  Future<TableModel> fetchLeagueStandings(String seasonId, String type, {String lang});
  Future<GroupTableModel> fetchGroupStandings(String seasonId, String type, {String lang});
  Future<List<PlayerStatsModel>> fetchPlayerStats(String seasonId);
  Future<TeamsStatisticsModel> fetchTeamStats(String seasonId);
  Future<List<TrophyModel>> fetchTrophies(String teamId);

}
