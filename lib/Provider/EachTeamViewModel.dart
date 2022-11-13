import 'package:arseli/Data/MainResponse.dart';
import 'package:arseli/Data/RequestHandler.dart';
import 'package:arseli/Models/EachTeam/Cups/ResponseModelCups.dart';
import 'package:arseli/Models/EachTeam/Cups/TrophiesBoxesModel.dart';
import 'package:arseli/Models/EachTeam/DropTableRows.dart';
import 'package:arseli/Models/EachTeam/FooterModel.dart';
import 'package:arseli/Models/EachTeam/HeaderProfileModel.dart';
import 'package:arseli/Models/EachTeam/MatchInBoxModel.dart';
import 'package:arseli/Models/EachTeam/NewsModel.dart';
import 'package:arseli/Models/EachTeam/RecentMatches.dart';
import 'package:arseli/Models/EachTeam/RecentMatchesBox.dart';
import 'package:arseli/Models/EachTeam/ResponseModelEachTeam.dart';
import 'package:arseli/Models/EachTeam/Squad/CoachModel.dart';
import 'package:arseli/Models/EachTeam/Squad/ResponseModelSquadTeam.dart';
import 'package:arseli/Models/EachTeam/Squad/SquadsModel.dart';
import 'package:arseli/Models/EachTeam/Stats/Players/Players.dart';
import 'package:arseli/Models/EachTeam/Stats/Stats.dart';
import 'package:arseli/Models/EachTeam/Stats/Teams/Teams.dart';
import 'package:arseli/Models/EachTeam/TablesModel.dart';
import 'package:arseli/Models/EachTeam/VideoModel.dart';
import 'package:arseli/Models/Leagues/Transfers/ResponseModelTransfers.dart';
import 'package:arseli/Models/Leagues/Transfers/TransferBoxesModel.dart';
import 'package:flutter/cupertino.dart';

class EachTeamViewModel with ChangeNotifier{
  bool loadingOneLeague = true;
  bool loadingOverView = true;
  bool loadingNews = true;
  bool loadingVideos = true;
  bool loadingMatches = true;
  bool loadingPositions = true;
  bool loadingSquad = true;
  bool loadingTrophies = true;

  RequestHandler requestHandler = RequestHandler();
  List<ResponseModelEachTeam> oneLeagueList;
  List<MainTables> tablesModelList;
  List<FooterModel> footerModelList;
  HeaderProfileModel headerProfileModel;
  List<NewsModel> newsModelList;
  List<NewsModel>addNewsModelList;
  List<VideoModel> videoModelList;
  List<VideoModel> addvideoModelList;
  StatsModel statsModel;
  List<TeamsModel> teamsModelList;
  List<PlayersModel> playersModelList;
  List<RecentMatchesBox> recentMatcheBox;
  List<RecentMatches> recentMatche;
  List<MatchInBoxModel> lastMatch;
  SquadsModel squadsModel;
  List<TrophiesBoxes> trophiesBoxesModelList;
  MatchInBoxModel newtGame;
  List<TransferBoxesModel> transferBoxesModelList;
  List<DropTableRowsModel> dropTableRowsList;
  List<String> dropsTableRows;
  List<DropTableRowsModel> dropTableRows2List;
  List<String> dropsTableRows2;
  String url;
  String teamImage;
  String msg;
  String calName;
  String calName2;


  Future<void> getOverView(url)async{
    MainResponse responseModel = await requestHandler.getEachTeam(
      endPoint: url,
    );

    try {
      Map data = responseModel.data.recentMatchesBoxes as Map;

      List<Map> modifidedResponse = [];
      data.forEach((key, value) {
        modifidedResponse.add({
          "date": key,
          "matches": value
        });
      });
      msg = responseModel.msg;
      statsModel = StatsModel.json(responseModel.data.stats);
      recentMatcheBox = RecentMatchesBox.toList(modifidedResponse);
      getLastMatch();
      newsModelList = NewsModel.listFromJson(responseModel.data.newsBoxes);
      tablesModelList = MainTables.listfromJson(responseModel.data.tables);
      headerProfileModel = HeaderProfileModel.json(responseModel.data.headerProfile);







    }catch(e){}
    //print("fsdfsdfsdf${playersModelList[0]}");
    loadingOverView = false;
    notifyListeners();
  }


//Get News
  Future<void> getNews(url,page)async{
    MainResponse responseModel = await requestHandler.getEachTeam(
      endPoint: url,
      parma:'?page=$page'
    );
    try {
      if(page <=1 ){
        newsModelList = NewsModel.listFromJson(responseModel.data.newsBoxes);
      }
      else if(page>1){
        addNewsModelList =NewsModel.listFromJson(responseModel.data.newsBoxes);
        newsModelList.addAll(addNewsModelList);
        addNewsModelList.clear();
      }
    }catch(e){}
    //print(responseModel.newsBoxes);
    loadingNews = false;
    notifyListeners();
  }

  //Get Videos
  Future<void> getVideos(url,page)async{
    MainResponse responseModel = await requestHandler.getEachTeam(
      endPoint: url,
        parma:'?page=$page'
    );
    try {
      if(page <=1 ){
        videoModelList = VideoModel.listFromJson(responseModel.data.videoBoxes);
      }
      else if(page > 1){
        addvideoModelList =VideoModel.listFromJson(responseModel.data.videoBoxes);
        videoModelList.addAll(addvideoModelList);

        addvideoModelList.clear();
      }
    }catch(e){}
    //print(responseModel.newsBoxes);
    loadingVideos = false;
    notifyListeners();
  }

  //Get Matches
  /*
  Future<void> getMatches(url,params)async{
    MainResponse responseModel = await requestHandler.getEachTeam(
        endPoint: url,
        parma: params
    );

    Map data = responseModel.data.recentMatchesBoxes as Map;

    List<Map> modifidedResponse = [];


    data.forEach((key, value) {
      modifidedResponse.add({
        "date":key,
        "matches":value
      });
    });


    print("Modifidmap : $modifidedResponse");

    recentMatcheBox= RecentMatchesBox.toList(modifidedResponse);
    loadingMatches = false;
    notifyListeners();
  }

   */

  Future<void> getAllMatches(url,params)async{
    MainResponse responseModel = await requestHandler.getEachTeam(
        endPoint: url,
        parma: "/$params"
    );

    try {
      Map data2 = responseModel.data.matches as Map;

      List<Map> modifidedResponse2 = [];


      data2.forEach((key, value) {
        modifidedResponse2.add({
          "date": key,
          "matches": value
        });
      });

      recentMatcheBox = RecentMatchesBox.toList(modifidedResponse2);

     // calName = responseModel.data.calName;
      dropTableRowsList = DropTableRowsModel.listFromJson(responseModel.data.dropTableRows);
      //url = responseModel.data.pPath;

      List<String> drops = [];
      dropTableRowsList.forEach((element) {
        drops.add(element.text);
      });
      dropsTableRows = drops;
      //print(dropTableRowsList[3].value);
    }catch(e){
      print(e);
    }
    //print(dropsTableRows);
    loadingMatches = false;
    notifyListeners();
  }

  //Get Tables
  Future<void> getTables(url,param)async{
    MainResponse responseModel = await requestHandler.getEachTeam(
        endPoint: url,
        parma:'/$param'
    );
    headerProfileModel = HeaderProfileModel.json(responseModel.data.headerProfile);
    tablesModelList = MainTables.listfromJson(responseModel.data.tables);
    calName2 = responseModel.data.calName;
    dropTableRows2List = DropTableRowsModel.listFromJson(responseModel.data.dropTableRows);
    url = responseModel.data.pPath;

    List<String> drops = [];
    dropTableRows2List.forEach((element) {
      drops.add(element.text);
    });
    dropsTableRows2 = drops;
    //print(responseModel.newsBoxes);


    loadingPositions = false;
    notifyListeners();
  }

  //Get Squads
  Future<void> getSquads(url)async{
    ResponseModelSquadTeam responseModel = await requestHandler.getSquadTeam(
      endPoint: url,
    );
    squadsModel = SquadsModel.json(responseModel.squads);
    headerProfileModel = HeaderProfileModel.json(responseModel.headerProfile);

    loadingSquad = false;
    notifyListeners();
  }

  Future<void> getCups(url)async{
    ResponseModelCups responseModel = await requestHandler.getCups(
      endPoint: url,
    );
    trophiesBoxesModelList = TrophiesBoxes.listFromJson(responseModel.trophiesBoxes);


    loadingTrophies = false;
    notifyListeners();
  }


/*
  Future<void> getPlayers(url)async{
    MainResponse responseModel = await requestHandler.getEachTeam(
        endPoint: url,
    );
    statsModel = StatsModel.json(responseModel.data.stats);

    loadingOneLeague = false;
    notifyListeners();
  }

  Future<void> getTeams(url)async{
    MainResponse responseModel = await requestHandler.getEachTeam(
        endPoint: url,
    );
    statsModel = StatsModel.json(responseModel.data.stats);
    teamsModelList = statsModel.teamsModel;

    loadingOneLeague = false;
    notifyListeners();
  }


 */
  Future<void> getTransfers(url,params,context)async{
    MainResponse responseModel = await requestHandler.getTransfers(
        endPoint:url,
        parma: "/$params",
        context: context
    );

    try {
      transferBoxesModelList =
          TransferBoxesModel.listFromJson(responseModel.data.transferBoxes);
    }catch(e){}
    loadingOneLeague = false;
    notifyListeners();
  }

  void getLastMatch(){
    List<MatchInBoxModel> matchInBox=[];
      for(int i=0; i<recentMatcheBox.length; i++){
        for(int j=0; j<recentMatcheBox[i].matchInBoxModel.length; j++){
          if(recentMatcheBox[i].matchInBoxModel[j].status=='Played') {
            matchInBox.add(recentMatcheBox[i].matchInBoxModel[j]);
          }
        }
      }
      lastMatch = matchInBox;

    }
}