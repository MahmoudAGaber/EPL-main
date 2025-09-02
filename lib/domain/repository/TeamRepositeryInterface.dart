
import 'package:epl/domain/Models/Teams/Squad.dart';
import 'package:epl/domain/Models/Teams/TeamSeasons.dart';
import 'package:epl/domain/Models/Teams/TeamTrophy.dart';
import 'package:epl/domain/models/News.dart';
import 'package:epl/domain/models/Teams/teamOverview.dart';
import '../Models/H2H.dart';
import '../Models/Standing.dart';
import '../models/Teams/transfers.dart';


abstract class TeamRepositoryInterface {
  Future<TeamOverviewModel> getOverview(String teamId, String seasonId);
  Future<List<NewsModel>> getNews(String teamName);
  Future<List<NewsModel>> getVideos(String teamName);
  Future<List<SeasonModel>> getSeasons(String teamId);
  Future<List<FixtureOverview>> getMatches(String teamId, String seasonId);
  Future<TableModel> getStanding(String seasonId,String type);
  Future<SquadModel> getSquad(String teamId);
  Future<List<PlayerTransfer>> getTransfers(String team_id);
  Future<List<TrophyModel>> getTrophy(String teamId);

}
