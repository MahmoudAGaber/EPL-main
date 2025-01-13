import 'dart:async';

import '../../Data/RequestHandler.dart';
import '../Models/Event.dart';
import '../Models/Formation.dart';
import '../Models/GroupStandings.dart';
import '../Models/H2H.dart';
import '../Models/MatchStatistics.dart';
import '../Models/Standing.dart';
import '../Models/TeamForm.dart';
import 'MatchRepositeryInterface.dart';


class MatchRepositoryImpl implements MatchRepositoryInterface {

  RequestHandler requestHandler;

  MatchRepositoryImpl(this.requestHandler);

  @override
  Future<List<EventModel>> getMatchEvents(String fixtureId) async{
    List<EventModel> eventModel;
    Map<String, dynamic> body;


      body = {
        "fixture_id": fixtureId,
        "lang": "ar"
      };

      eventModel = await requestHandler.postData(
        endPoint: "soccer/fixture/info/events",
        auth: true,
        requestBody: body,
        fromJson: (json)=> EventModel.listFromJson(json),
      );

      return eventModel;
  }


  @override
  Future<TeamFormModel> getMatchTeamForm(String fixtureId) async{
    TeamFormModel teamFormModel;
    Map<String, dynamic> body;


      body = {
        "fixture_id": fixtureId,
        "lang": "ar"
      };

      teamFormModel = await requestHandler.postData(
        endPoint: "soccer/fixture/info/team-form",
        auth: true,
        requestBody: body,
        fromJson: (json)=> TeamFormModel.fromJson(json),
      );

      return teamFormModel;
  }

  @override
  Future<FormationsModel> getLineUps(String fixtureId) async{
    FormationsModel formationsModel;
    Map<String, dynamic> body;

    body = {
      "fixture_id": fixtureId,
      "lang": "ar"
    };

      formationsModel = await requestHandler.postData(
        endPoint: "soccer/fixture/info/formations",
        auth: true,
        requestBody: body,
        fromJson: (json) => FormationsModel.fromJson(json),
      );



        return formationsModel;
  }

  @override
  Future<dynamic> getTable(String seasonId,String type) async{
    dynamic tableModel;
    Map<String, dynamic> body;


      body = {
        "season_id": seasonId,
        "lang": "ar",
        "type": type
      };

      final jsonResponse = await requestHandler.postData(
        endPoint: "soccer/team/table",
        auth: true,
        requestBody: body,
        fromJson: (json) => json,
      );

      if(jsonResponse['format'] == 'default'){
        print("defualt from repo");

        tableModel = TableModel.fromJson(jsonResponse);
      }
      else if(jsonResponse['format'] == 'groups'){
        print("Groups from repo");
        tableModel = GroupTableModel.fromJson(jsonResponse);

      }

        return tableModel;
  }

  @override
  Future<List<MatchStatisticsModel>> getStatistics(String fixtureId) async{
    List<MatchStatisticsModel> matchStatisticsModel;
    Map<String, dynamic> body;


      body = {
        "fixture_id": fixtureId,
        "lang": "ar"
      };

      matchStatisticsModel = await requestHandler.postData(
        endPoint: "soccer/fixture/info/statistics",
        auth: true,
        requestBody: body,
        fromJson: (json)=> MatchStatisticsModel.listFromJson(json),
      );

      return matchStatisticsModel;
  }

  @override
  Future<H2HModel> getH2H(String fixtureId) async{
    H2HModel h2hModel;
    Map<String, dynamic> body;

    body = {
      "fixture_id": fixtureId,
      "lang": "ar"
    };


      h2hModel = await requestHandler.postData(
        endPoint: "soccer/fixture/info/head2head",
        auth: true,
        requestBody: body,
        fromJson: (json) => H2HModel.fromJson(json),
      );

      return h2hModel;
  }


}
