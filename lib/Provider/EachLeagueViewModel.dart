
import 'package:arseli/Data/MainResponse.dart';
import 'package:arseli/Data/RequestHandler.dart';
import 'package:arseli/Models/EachTeam/DropTableRows.dart';
import 'package:arseli/Models/Leagues/Transfers/TransferBoxesModel.dart';
import 'package:arseli/Models/OneLeague/Cups/ResponseModelCups.dart';
import 'package:arseli/Models/OneLeague/Cups/TrophiesBoxesModel.dart';
import 'package:arseli/Models/OneLeague/FooterModel.dart';
import 'package:arseli/Models/OneLeague/HeaderProfileModel.dart';
import 'package:arseli/Models/OneLeague/NewsModel.dart';
import 'package:arseli/Models/OneLeague/RecentMatchesBox.dart';
import 'package:arseli/Models/OneLeague/ResponseModelOneLeague.dart';
import 'package:arseli/Models/OneLeague/Stats/Players/Players.dart';
import 'package:arseli/Models/OneLeague/Stats/Stats.dart';
import 'package:arseli/Models/OneLeague/Stats/Teams/Teams.dart';
import 'package:arseli/Models/OneLeague/TablesModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Oops.dart';


class EachLeagueViewModel with ChangeNotifier {
  bool loadingHeader = true;
  bool loadingPositions = true;
  bool loadingMatches = true;
  bool loadingNews = true;
  bool loadingPlayerStats = true;
  bool loadingTeamStats = true;
  bool loadingTransfers = true;
  bool loadingCups = true;

  bool _loading = true;
  bool get getLoading => _loading;

  bool get = false;

  RequestHandler requestHandler = RequestHandler();
  List<ResponseModelOneLeague> oneLeagueList;
  List<MainTables> tablesModelList;
  List<DropTableRowsModel> dropTableRowsList;
  List<String> dropsTableRows;
  List<FooterModel> footerModelList;
  HeaderProfileModel headerProfileModel;
  List<NewsModel> newsModelList;
  List<NewsModel> newsListAdd=[];
  StatsModel statsModel;
  List<PlayersModel> playersModel;
  List<TeamsModel> teamsModel;
  List<TrophiesBoxes> trophiesBoxesModelList;
  List<TeamsModel> teamsModelList;
  List<RecentMatchesBox> recentMatcheBox;
  List<TransferBoxesModel> transferBoxesModelList;
  String msg;
  String calName;
  int index = 0;
  bool add = false;
  bool init = true;

  void toggleLoading(bool loading){
    _loading = loading;
    notifyListeners();
  }

  Future<void> all(url) async {
    MainResponse responseModel = await requestHandler.getDataOneLeagues(
      endPoint: url,
    );

    msg = responseModel.msg;
    headerProfileModel = HeaderProfileModel.json(responseModel.data.headerProfile);
    try {
      tablesModelList = MainTables.listfromJson(responseModel.data.tables);
    } catch (e) {}
    try{
      newsModelList = NewsModel.listFromJson(responseModel.data.newsBoxes);
    }catch(e){}
    try{
      statsModel = StatsModel.json(responseModel.data.stats);
      playersModel = statsModel.playersModel;
      teamsModel = statsModel.teamsModel;
    }catch(e){}

    try {
      Map data = responseModel.data.recentMatchesBoxes as Map;

      List<Map> modifidedResponse = [];
      data.forEach((key, value) {
        modifidedResponse.add({
          "date": key,
          "matches": value
        });
      });

      // print("Modifidmap : $modifidedResponse");

      recentMatcheBox = RecentMatchesBox.toList(modifidedResponse);
    }catch(e){}

    loadingMatches = false;
    //toggleLoading(false);
    notifyListeners();
  }


  Future<void> headerProfile(url, params,context) async {
    MainResponse responseModel = await requestHandler.getDataOneLeagues(
        endPoint: url,
        parma: ""
    );
    try {
      msg = responseModel.msg;
      if(msg=='failed'){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Oops()));
      }
      headerProfileModel = HeaderProfileModel.json(responseModel.data.headerProfile);

    } catch (e) {}
    //print(responseModel.newsBoxes);
    loadingHeader = false;
    toggleLoading(false);
    notifyListeners();
  }

  Future<void> getTables(url, params) async {
    MainResponse responseModel = await requestHandler.getDataOneLeagues(
        endPoint: url,
        parma: "/$params",
    );
    try {
      msg = responseModel.msg;
      tablesModelList = MainTables.listfromJson(responseModel.data.tables);
      calName = responseModel.data.calName;
      dropTableRowsList = DropTableRowsModel.listFromJson(responseModel.data.dropTableRows);
      List<String> drops = [];
      dropTableRowsList.forEach((element) {
        drops.add(element.text);
      });
      dropsTableRows = drops;
      this.msg = responseModel.msg;
    } catch (e) {}

    loadingPositions = false;
    toggleLoading(false);
    notifyListeners();
  }


  Future<void> getMatches(url, params) async {
    MainResponse responseModel = await requestHandler.getDataOneLeagues(
        endPoint: url,
        parma: params
    );

    try {
      msg = responseModel.msg;
      Map data = responseModel.data.recentMatchesBoxes as Map;
      if(data == null){
        data = responseModel.data.matchs as Map;
      }
      List<Map> modifidedResponse = [];
      data.forEach((key, value) {
        modifidedResponse.add({
          "date": key,
          "matches": value
        });
      });

      // print("Modifidmap : $modifidedResponse");

      recentMatcheBox = RecentMatchesBox.toList(modifidedResponse);
    } catch (e) {

    }
    loadingMatches = false;
    toggleLoading(false);
    notifyListeners();
  }

  Future<void> getNews(url, params,int page) async {
    MainResponse responseModel = await requestHandler.getDataOneLeagues(
        endPoint: url,
        parma: "/$params?page=$page"
    );
    try {
      msg = responseModel.msg;

      if(page <=1 ){
        add = false;
        newsModelList = NewsModel.listFromJson(responseModel.data.newsBoxes);
      }
      else if(page > 1){
        add = true;
        newsListAdd =NewsModel.listFromJson(responseModel.data.newsBoxes);
        newsModelList.addAll(newsListAdd);

        newsListAdd.clear();
      }
    } catch (e) {}
    //print(responseModel.newsBoxes);
    loadingNews = false;
    toggleLoading(false);
    notifyListeners();
  }

  Future<void> getPlayersStats(url) async {
    MainResponse responseModel = await requestHandler.getDataOneLeagues(
        endPoint: url,
    );
      msg = responseModel.msg;
      statsModel = StatsModel.json(responseModel.data.stats);
      playersModel = statsModel.playersModel;
    loadingPlayerStats = false;
    toggleLoading(false);
    notifyListeners();
  }

  Future<void> getTeamsStats(url) async {
    MainResponse responseModel = await requestHandler.getDataOneLeagues(
        endPoint: url,
    );
      msg = responseModel.msg;
      statsModel = StatsModel.json(responseModel.data.stats);
      teamsModel = statsModel.teamsModel;

    loadingTeamStats = false;
    toggleLoading(false);
    notifyListeners();
  }

  Future<void> getTransfers(url, params) async {
    MainResponse responseModel = await requestHandler.getTransfers(
        endPoint: url,
        parma: "/$params",
    );

    try {
      msg = responseModel.msg;

      transferBoxesModelList =
          TransferBoxesModel.listFromJson(responseModel.data.transferBoxes);
    } catch (e) {
      print(e);
    }
    loadingTransfers = false;
    toggleLoading(false);
    notifyListeners();
  }

  Future<void> getCups(url) async {
    ResponseModelLeagueCups responseModel = await requestHandler.getLeaguesCups(
      endPoint: url,
    );
    try {
      trophiesBoxesModelList =
          TrophiesBoxes.listFromJson(responseModel.trophiesBoxes);
    } catch (e) {}

    loadingCups = false;
    toggleLoading(false);
    notifyListeners();
  }

   Future<void>restore(){
    tablesModelList.clear();
    notifyListeners();
  }

}


