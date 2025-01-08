
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Data/RequestHandler.dart';

import '../../../Data/StateModel.dart';
import '../../../domain/Models/GroupStandings.dart';
import '../../../domain/Models/Leagues/PlayerStats.dart';
import '../../../domain/Models/Leagues/Seasons.dart';
import '../../../domain/Models/Standing.dart';
import '../../../domain/Models/TeamForm.dart';
import '../../../domain/Models/Teams/TeamTrophy.dart';
import '../../../domain/models/Leagues/teamStats.dart';
import '../../../domain/models/News.dart';


enum LeagueStandingType {All, Home, Away }

final LeagueNewsProvider = StateNotifierProvider<LeagueNewsNotifier,StateModel<List<NewsModel>>>((ref) => LeagueNewsNotifier(ref));

final TeamMatchesProvider = StateNotifierProvider<TeamMatchesNotifier,StateModel<List<FixtureDetail>>>((ref) => TeamMatchesNotifier(ref));

final LeagueSeasonsProvider = StateNotifierProvider<LeagueSeasonsNotifier,StateModel<LeagueSeasonsModel>>((ref) => LeagueSeasonsNotifier(ref));

final LeagueStandingProvider = StateNotifierProvider<LeagueStandingNotifier,StateModel<TableModel>>((ref) => LeagueStandingNotifier(ref));

final LeagueGroupStandingProvider = StateNotifierProvider<LeagueGroupStandingNotifier,StateModel<GroupTableModel>>((ref) => LeagueGroupStandingNotifier(ref));

final LeagueStandingTypeProvider = StateProvider<LeagueStandingType>((ref) => LeagueStandingType.All);

final PlayerStatsProvider = StateNotifierProvider<PlayerStatsNotifier,StateModel<List<PlayerStatsModel>>>((ref) => PlayerStatsNotifier(ref));

final TeamStatsProvider = StateNotifierProvider<TeamStatsNotifier,StateModel<TeamsStatisticsModel>>((ref) => TeamStatsNotifier(ref));

final TrophyProvider = StateNotifierProvider<TrophyNotifier,StateModel<List<TrophyModel>>>((ref) => TrophyNotifier(ref));



class LeagueNewsNotifier extends StateNotifier<StateModel<List<NewsModel>>>{
  Ref ref;
  LeagueNewsNotifier(this.ref):super(StateModel.loading());

  Future<void> getNews(String teamName) async{
    RequestHandler requestHandler = RequestHandler();
    NewsResponse newsResponse;
    List<NewsModel> news = [];
    Map<String, dynamic> body;
    try {
      body = {
        "search_string": teamName,
      };

      state = StateModel.loading();

      newsResponse = await requestHandler.postData(
        endPoint: "soccer/competition/news",
        auth: true,
        requestBody: body,
        fromJson: (json)=> NewsResponse.fromJson(json),
      );

      news = newsResponse.news;

      List<NewsModel> filteredNews = news.where((element) => element.type == "article" || element.type == "tweet").toList();

      state = StateModel.success(filteredNews);

    }catch(e){
      state = StateModel.fail("Faild to get data $e");
    }
  }

}

class LeagueSeasonsNotifier extends StateNotifier<StateModel<LeagueSeasonsModel>>{
  Ref ref;
  LeagueSeasonsNotifier(this.ref):super(StateModel.loading());


  Future<String?> getLeagueSeasons(String leagueId) async{
    RequestHandler requestHandler = RequestHandler();
    LeagueSeasonsModel leagueSeasonsModel ;
    Map<String, dynamic> body;
    try {
      body = {
        "lang": "en",
        "league_id": leagueId
      };

      state = StateModel.loading();

      leagueSeasonsModel = await requestHandler.postData(
        endPoint: "soccer/competition/all-seasons",
        auth: true,
        requestBody: body,
        fromJson: (json)=> LeagueSeasonsModel.fromJson(json),
      );

      leagueSeasonsModel.competition.season.sort((a, b) => b.startDate.compareTo(a.startDate));

      state = StateModel.success(leagueSeasonsModel);

      return leagueSeasonsModel.competition.season.first.seasonId;
    }catch(e){
      state = StateModel.fail("Faild to get data $e");
      return null;
    }
  }
}

class TeamMatchesNotifier extends StateNotifier<StateModel<List<FixtureDetail>>>{
  Ref ref;
  TeamMatchesNotifier(this.ref):super(StateModel.loading());


  Future<void> getMatches() async{
    RequestHandler requestHandler = RequestHandler();
    List<FixtureDetail> matches = [];
    Map<String, dynamic> body;
    try {
      body = {
        "lang": "en",
        "season_id": "23593",
        "team_id": "2020"
      };

      state = StateModel.loading();

      matches = await requestHandler.postData(
        endPoint: "soccer/team/fixture",
        auth: true,
        requestBody: body,
        fromJson: (json)=> FixtureDetail.listFromJson(json),
      );


      state = StateModel.success(matches);

    }catch(e){
      state = StateModel.fail("Faild to get data $e");
    }
  }
}

class LeagueStandingNotifier extends StateNotifier<StateModel<TableModel>>{
  Ref ref;
  LeagueStandingNotifier(this.ref):super(StateModel.loading());

  Future<void> getTable(String season_id,String type) async{
    RequestHandler requestHandler = RequestHandler();
    TableModel tableModel;
    Map<String, dynamic> body;

    body = {
      "season_id": season_id,
      "lang": "ar",
      "type": type
    };

    try {

      state = StateModel.loading();

      tableModel = await requestHandler.postData(
        endPoint: "soccer/competition/season-standings",
        auth: true,
        requestBody: body,
        fromJson: (json) => TableModel.fromJson(json),
      );

      if (tableModel.standings[0].isNotEmpty) {
        state = StateModel.success(tableModel);
      } else {
        state = StateModel.empty();
      }
    }catch(e){
      state = StateModel.fail(e.toString());
    }

  }

}

class LeagueGroupStandingNotifier extends StateNotifier<StateModel<GroupTableModel>>{
  Ref ref;
  LeagueGroupStandingNotifier(this.ref):super(StateModel.loading());

  Future<void> getTable(String season_id,String type) async{
    RequestHandler requestHandler = RequestHandler();
    GroupTableModel tableModel;
    Map<String, dynamic> body;

    body = {
      "season_id": season_id,
      "lang": "ar",
      "type": type
    };


    state = StateModel.loading();



    tableModel = await requestHandler.postData(
      endPoint: "soccer/competition/season-standings",
      auth: true,
      requestBody: body,
      fromJson: (json) => GroupTableModel.fromJson(json),
    );

    if(tableModel.standings[0].isNotEmpty){
      state = StateModel.success(tableModel);

    }else{
      state = StateModel.empty();
    }


  }

}


class PlayerStatsNotifier extends StateNotifier<StateModel<List<PlayerStatsModel>>> {
  Ref ref;
  PlayerStatsNotifier(this.ref) : super(StateModel.loading());


  Future<void> getPlayerStats(String seasonId) async {
    RequestHandler requestHandler = RequestHandler();
    List<PlayerStatsModel> playerStats = [];
    Map<String, dynamic> body;

    body = {
      "season_id": seasonId,
      "lang": "en",
    };

    try {
      state = StateModel.loading();
      playerStats = await requestHandler.postData(
        endPoint: "soccer/competition/players-stats",
        auth: true,
        requestBody: body,
        fromJson: (json) => PlayerStatsModel.fromJson(json),
      );


      state = StateModel.success(playerStats);
    } catch (e) {
      state = StateModel.fail("Failed to get data $e");
    }
  }


}

class TeamStatsNotifier extends StateNotifier<StateModel<TeamsStatisticsModel>> {
  Ref ref;
  TeamStatsNotifier(this.ref) : super(StateModel.loading());


  Future<void> getTeamStats(String seasonId) async {
    RequestHandler requestHandler = RequestHandler();
    TeamsStatisticsModel teamStats;
    Map<String, dynamic> body;

    body = {
      "season_id": seasonId,
      "lang": "en",
    };

    try {
      state = StateModel.loading();
      teamStats = await requestHandler.postData(
        endPoint: "soccer/competition/team-statistics",
        auth: true,
        requestBody: body,
        fromJson: (json) => TeamsStatisticsModel.fromJson(json),
      );


      state = StateModel.success(teamStats);
    } catch (e) {
      state = StateModel.fail("Failed to get data $e");
    }
  }


}

class TrophyNotifier extends StateNotifier<StateModel<List<TrophyModel>>>{
  Ref ref;
  TrophyNotifier(this.ref):super(StateModel.loading());

  Future<void> getTrophy(String teamId) async{
    RequestHandler requestHandler = RequestHandler();
    List<TrophyModel> trophyModel = [];
    Map<String, dynamic> body;

    body = {
      "team_id": teamId,
      "lang": "ar",

    };


    state = StateModel.loading();
    trophyModel = await requestHandler.postData(
      endPoint: "soccer/team/trophy",
      auth: true,
      requestBody: body,
      fromJson: (json) => TrophyModel.listFromJson(json),
    );
    state = StateModel.success(trophyModel);



  }

}


