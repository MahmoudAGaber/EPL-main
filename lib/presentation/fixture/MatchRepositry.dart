import 'dart:async';

import '../../Data/RequestHandler.dart';
import '../../domain/Models/Event.dart';
import '../../domain/Models/Formation.dart';
import '../../domain/Models/H2H.dart';
import '../../domain/Models/MatchStatistics.dart';
import '../../domain/Models/Standing.dart';
import '../../domain/Models/TeamForm.dart';
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
  Future<TableModel> getTable(String seasonId,String type) async{
    TableModel tableModel;
    Map<String, dynamic> body;

    body = {
      "type": type,
      "season_id": seasonId,
      "lang": "ar"
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
