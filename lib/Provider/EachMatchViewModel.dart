import 'package:arseli/Data/MainResponse.dart';
import 'package:arseli/Data/RequestHandler.dart';
import 'package:arseli/Models/EachTeam/TablesModel.dart';
import 'package:arseli/Models/matches/EachMatch/Events/EventModel.dart';
import 'package:arseli/Models/matches/EachMatch/HeadToHead/HeadTOHeadModel.dart';
import 'package:arseli/Models/matches/EachMatch/HeadToHead/HeaderModel.dart';
import 'package:arseli/Models/matches/EachMatch/Lineups/Lineups.dart';
import 'package:arseli/Models/matches/EachMatch/MSNModel.dart';
import 'package:arseli/Models/matches/EachMatch/MatchDetails/MatchDetailsModel.dart';
import 'package:arseli/Models/matches/EachMatch/ResponseModelEachMatch.dart';
import 'package:arseli/Models/matches/EachMatch/Stats/HeaderModel.dart';
import 'package:arseli/Models/matches/EachMatch/Stats/SortedStatsModel.dart';
import 'package:arseli/Models/matches/EachMatch/Stats/StatsEachMatchModel.dart';
import 'package:arseli/Models/matches/Matches.dart';
import 'package:arseli/Models/matches/PlayerInf.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Oops.dart';

class EachMatchViewModel with ChangeNotifier {
  RequestHandler requestHandler = RequestHandler();

  bool loadingMsn = true;
  bool loadingEvents = true;
  bool loadingEventsEnd = true;
  bool loadingPositions = true;
  bool loadingLineUps = true;
  bool loadingStats = true;
  bool loadingMatchesHTH = true;

  PlayerInf playerInf;
  MSNModel msnModel;
  MatchDetailsModel matchDetailsModel;
  MatchDetailsModel teamFormModel;
  List<MainTables> tablesModelList;
  HeadToHeadModel headToHeadModel;
  List<EventsModel> eventsModel;
  StatsEachMatchModel statsEachMatchModel;
  Header header;
  SortedStatsModelMatch sortedStatsModelMatch;

  LineupsModel lineupsModel;

  Future<void> getMSN(url, context) async {
    ResponseModelEachMatch responseModel = await requestHandler.getEachMatch(
      endPoint: url,
    );
    if (responseModel == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Oops()));
    }
    msnModel = MSNModel.json(responseModel.MSN);

    // print("FromViewModel${msnModel.homeTeamName}");
    loadingMsn = false;
    notifyListeners();
  }

  Future<void> getMatchEvent(url) async {
    ResponseModelEachMatch responseModel =
        await requestHandler.getEachMatch(endPoint: url, parma: '/');

    try {
      //msnModel = MSNModel.json(responseModel.MSN);
      matchDetailsModel = MatchDetailsModel.json(responseModel.matchDetails);
      teamFormModel = MatchDetailsModel.json(responseModel.matchDetails);
    } catch (e) {
      print(e);
    }
    loadingEvents = false;
    notifyListeners();
  }

  Future<void> getMatchEndEvent(url) async {
    ResponseModelEachMatch responseModel =
        await requestHandler.getEachMatch(endPoint: url, parma: "/");
    try {
      eventsModel = EventsModel.listFromJson(responseModel.events);
      matchDetailsModel = MatchDetailsModel.json(responseModel.matchDetails);
      teamFormModel = MatchDetailsModel.json(responseModel.matchDetails);
    } catch (e) {}

    loadingEventsEnd = false;
    notifyListeners();
  }

  Future<void> getTables(url) async {
    ResponseModelEachMatch responseModel =
        await requestHandler.getEachMatch(endPoint: url, parma: "/tables");
    try {
      tablesModelList = MainTables.listfromJson(responseModel.tables);
    } catch (e) {}
    loadingPositions = false;
    notifyListeners();
  }

  Future<void> getHTHMatch(url) async {
    MainResponse responseModel = await requestHandler.getHTHMatchData(
        endPoint: url, parma: "/headtohead");
    try {
      headToHeadModel = HeadToHeadModel.json(responseModel.data.headtohead);
    } catch (e) {
      print(e);
    }

    loadingMatchesHTH = false;
    notifyListeners();
  }

  Future<void> getMatchStats(url) async {
    ResponseModelEachMatch responseModel =
        await requestHandler.getEachMatch(endPoint: url, parma: "/stats");

    try {
      sortedStatsModelMatch =
          SortedStatsModelMatch.json(responseModel.SortedStats);
      statsEachMatchModel = StatsEachMatchModel.json(responseModel.stats);
    } catch (e) {}

    loadingStats = false;
    notifyListeners();
  }

  Future<void> getMatchLineups(url) async {
    ResponseModelEachMatch responseModel =
        await requestHandler.getEachMatch(endPoint: url, parma: "/lineup");
    try {
      lineupsModel = LineupsModel.json(responseModel.lineups);
    } catch (e) {}

    loadingLineUps = false;
    notifyListeners();
  }

  Future<void> restoreData() {
    msnModel = null;
    //eventsModel.clear();
    matchDetailsModel = null;
    teamFormModel = null;
    tablesModelList.clear();
    headToHeadModel = null;

    loadingMsn = true;
    loadingEvents = true;
    notifyListeners();
  }

  Future<PlayerInf> getPlayerInfo(String match, String playerID) async {
    PlayerInf responseModel = await requestHandler.getPlayerInfo(
        endPoint: '/matchPlyerStats',
        parma: '?match=$match' + '&player=$playerID');
    playerInf = responseModel;
    return playerInf;
    //notifyListeners();
  }
}
