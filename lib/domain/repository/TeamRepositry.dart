import 'dart:async';

import 'package:epl/domain/Models/H2H.dart';
import 'package:epl/domain/Models/Standing.dart';
import 'package:epl/domain/Models/Teams/Squad.dart';
import 'package:epl/domain/Models/Teams/TeamSeasons.dart';
import 'package:epl/domain/Models/Teams/TeamTrophy.dart';
import 'package:epl/domain/models/News.dart';
import 'package:epl/domain/models/Teams/teamOverview.dart';
import '../../Data/RequestHandler.dart';
import 'TeamRepositeryInterface.dart';


class TeamRepositoryImpl implements TeamRepositoryInterface {

  RequestHandler requestHandler;

  TeamRepositoryImpl(this.requestHandler);


  @override
  Future<TeamOverviewModel> getOverview(String teamId, String seasonId) async{
    TeamOverviewModel teamOverviewModel ;
    Map<String, dynamic> body;

    body = {
      "team_id": teamId,
      "season_id": seasonId
    };


    teamOverviewModel = await requestHandler.postData(
      endPoint: "soccer/team/overview",
      auth: true,
      requestBody: body,
      fromJson: (json)=> TeamOverviewModel.fromJson(json),
    );


    List<FixtureOverview> finishedFixtures = teamOverviewModel.fixtures
        .where((fixture) => fixture.fixture.status.short == 'FT')
        .toList();

    teamOverviewModel.fixtures = finishedFixtures;
    teamOverviewModel.fixtures.sort((a, b) => b.fixture.timestamp.compareTo(a.fixture.timestamp));

    return teamOverviewModel;
  }


  @override
  Future<List<NewsModel>> getNews(String teamName) async{
    NewsResponse newsResponse;
    List<NewsModel> news = [];
    Map<String, dynamic> body;

      body = {
        "search_string": teamName,
      };


      newsResponse = await requestHandler.postData(
        endPoint: "soccer/team/news",
        auth: true,
        requestBody: body,
        fromJson: (json)=> NewsResponse.fromJson(json),
      );

      news = newsResponse.news;

      List<NewsModel> filteredNews = news.where((element) => element.type == "article" || element.type == "tweet").toList();

      return filteredNews;
  }


  @override
  Future<List<NewsModel>> getVideos(String teamName) async {
    NewsResponse newsResponse;
    List<NewsModel> news = [];
    Map<String, dynamic> body;
      body = {
        "search_string": teamName,
      };


      newsResponse = await requestHandler.postData(
        endPoint: "soccer/team/news",
        auth: true,
        requestBody: body,
        fromJson: (json)=> NewsResponse.fromJson(json),
      );


      news = newsResponse.news;

      List<NewsModel> filteredNews = news.where((element) => element.type == "youtube-video").toList();

      return filteredNews;
  }


  @override
  Future<List<SeasonModel>> getSeasons(String teamId) async {
    List<SeasonModel> teamSeasons = [];
    Map<String, dynamic> body;
      body = {
        "lang": "en",
        "team_id": teamId
      };


      teamSeasons = await requestHandler.postData(
        endPoint: "soccer/team/seasons",
        auth: true,
        requestBody: body,
        fromJson: (json)=> SeasonModel.listFromJson(json),
      );

      teamSeasons =  teamSeasons.where((element) => element.name.contains("/")).toList();
      teamSeasons.sort((a, b) => b.startDate.split("/").first.compareTo(a.startDate.split("/").first));

      return teamSeasons;

  }


  @override
  Future<List<FixtureOverview>> getMatches(String teamId, String seasonId) async{
    List<FixtureOverview> matches = [];
    Map<String, dynamic> body;
      body = {
        "lang": "en",
        "season_id": seasonId,
        "team_id": teamId
      };


      matches = await requestHandler.postData(
        endPoint: "soccer/team/matches",
        auth: true,
        requestBody: body,
        fromJson: (json)=> FixtureOverview.listFromJson(json),
      );


     return matches;
  }


  @override
  Future<SquadModel> getSquad(String teamId) async{
    SquadModel squadModel;
    Map<String, dynamic> body;

    print("TeamId${teamId}");
    body = {
      "team_id": teamId,
      "lang": "en",
    };

      squadModel = await requestHandler.postData(
        endPoint: "soccer/team/squads",
        auth: true,
        requestBody: body,
        fromJson: (json) => SquadModel.fromJson(json),
      );
      print("Helloooooo${squadModel}");

      return squadModel;
  }


  @override
  Future<TableModel> getStanding(String seasonId, String type) async{
    TableModel tableModel;
    Map<String, dynamic> body;

    body = {
      "season_id": seasonId,
      "lang": "ar",
      "type": type
    };

      tableModel = await requestHandler.postData(
        endPoint: "soccer/team/table",
        auth: true,
        requestBody: body,
        fromJson: (json) => TableModel.fromJson(json),
      );
        return tableModel;
  }


  @override
  Future<H2HModel> getTransfers(String fixtureId) {
    // TODO: implement getTrasnfers
    throw UnimplementedError();
  }


  @override
  Future<List<TrophyModel>> getTrophy(String teamId) async{
    List<TrophyModel> trophyModel = [];
    Map<String, dynamic> body;

    body = {
      "team_id": teamId,
      "lang": "ar",

    };


    trophyModel = await requestHandler.postData(
      endPoint: "soccer/team/trophy",
      auth: true,
      requestBody: body,
      fromJson: (json) => TrophyModel.listFromJson(json),
    );
    return trophyModel;
  }





}
