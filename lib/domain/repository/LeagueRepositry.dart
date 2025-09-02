
import 'package:epl/Data/RequestHandler.dart';
import 'package:epl/domain/repository/LeagueRepositeryInterface.dart';

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



class LeagueRepositoryImpl implements LeagueRepositoryInterface {

  RequestHandler requestHandler;

  LeagueRepositoryImpl(this.requestHandler);


  @override
  Future<List<NewsModel>> fetchNews(String teamName) async {
    final body = {"search_string": teamName};
    final response = await requestHandler.postData(
      endPoint: "soccer/competition/news",
      auth: true,
      requestBody: body,
      fromJson: (json) => NewsResponse.fromJson(json),
    );
    return response.news.where((news) => news.type == "article" || news.type == "tweet").toList();
  }

  @override
  Future<LeagueSeasonsModel> fetchLeagueSeasons(String leagueId) async {
    final body = {"lang": "en", "league_id": leagueId};
    return await requestHandler.postData(
      endPoint: "soccer/competition/all-seasons",
      auth: true,
      requestBody: body,
      fromJson: (json) => LeagueSeasonsModel.fromJson(json),
    );
  }

  @override
  Future<List<FixtureOverview>> fetchLeagueMatches(String seasonId) async {
    final body = {"lang": "en", "season_id": seasonId};
    List<FixtureOverview> tets= [];
    tets =  await requestHandler.postData(
      endPoint: "soccer/fixture/season/all",
      auth: true,
      requestBody: body,
      fromJson: (json) => FixtureOverview.listFromJson(json),
    );
   // print("Helloooo${tets.first.fixture}");
    return tets;
  }

  @override
  Future<TableModel> fetchLeagueStandings(String seasonId, String type, {String lang = "ar"}) async {
    final body = {"season_id": seasonId, "lang": lang, "type": type};
    return await requestHandler.postData(
      endPoint: "soccer/competition/season-standings",
      auth: true,
      requestBody: body,
      fromJson: (json) => TableModel.fromJson(json),
    );
  }

  @override
  Future<GroupTableModel> fetchGroupStandings(String seasonId, String type, {String lang = "ar"}) async {
    final body = {"season_id": seasonId, "lang": lang, "type": type};
    return await requestHandler.postData(
      endPoint: "soccer/competition/season-standings",
      auth: true,
      requestBody: body,
      fromJson: (json) => GroupTableModel.fromJson(json),
    );
  }

  @override
  Future<List<PlayerStatsModel>> fetchPlayerStats(String seasonId) async {
    final body = {"season_id": seasonId, "lang": "en"};
    return await requestHandler.postData(
      endPoint: "soccer/competition/players-stats",
      auth: true,
      requestBody: body,
      fromJson: (json) => PlayerStatsModel.fromJson(json),
    );
  }

  @override
  Future<List<TeamStatsModel>> fetchTeamStats(String seasonId) async {
    final body = {"season_id": seasonId, "lang": "en"};
    return await requestHandler.postData(
      endPoint: "soccer/competition/team-statistics",
      auth: true,
      requestBody: body,
      fromJson: (json) => TeamStatsModel.fromJson(json),
    );
  }

  @override
  Future<LeagueTrophies> fetchTrophies(String competitionId) async {
    final body = {"competition_id": competitionId, "lang": "ar"};
    return await requestHandler.postData(
      endPoint: "footballV2/league/trophies",
      auth: true,
      requestBody: body,
      fromJson: (json) => LeagueTrophies.fromJson(json),
    );
  }
}