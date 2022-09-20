import 'dart:convert';

import 'package:arseli/Data/MainResponse.dart';
import 'package:arseli/Models/EachPlayer/ResponsemodelEachPlayer.dart';
import 'package:arseli/Models/EachTeam/Cups/ResponseModelCups.dart';
import 'package:arseli/Models/EachTeam/ResponseModelEachTeam.dart';
import 'package:arseli/Models/EachTeam/Squad/ResponseModelSquadTeam.dart';
import 'package:arseli/Models/Leagues/ResponseModelLeagues.dart';
import 'package:arseli/Models/Leagues/Transfers/ResponseModelTransfers.dart';
import 'package:arseli/Models/News/ResponseModelNews.dart';
import 'package:arseli/Models/OneLeague/Cups/ResponseModelCups.dart';
import 'package:arseli/Models/OneLeague/ResponseModelOneLeague.dart';
import 'package:arseli/Models/SearchModel.dart';
import 'package:arseli/Models/Videos/ResponseModelVideos.dart';
import 'package:arseli/Models/matches/EachMatch/Events/ResponseModelEvents.dart';
import 'package:arseli/Models/matches/EachMatch/HeadToHead/ResponseModelHeadToHead.dart';
import 'package:arseli/Models/matches/EachMatch/ResponseModelEachMatch.dart';
import 'package:arseli/Models/matches/PlayerInf.dart';
import 'package:arseli/Models/matches/ResponseModel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'AppException.dart';

class RequestHandler {
  static const mainUrl = "https://www.eplworld.com/api";
  static String error;
  MainResponse mainResponse = MainResponse();

  //Search
  Future<MainResponse> search({
    endPoint,
    String parma = '',
  }) async {
    Response response = await http.get(Uri.parse(mainUrl + endPoint + parma),
        headers: {"Content-Type": "application/json; charset=UTF-8"});

    switch (response.statusCode) {
      case 200:
        mainResponse.data = SearchResponseModel.ListFromJson(
            json.decode(response.body.toString()));
        mainResponse.msg = 'Success';
        return mainResponse;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        mainResponse.msg = 'failed';
        return mainResponse;
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  //Matches
  Future<ResponseModel> getDataMatches({
    endPoint,
    String parma = '',
  }) async {
    Response response = await http.get(Uri.parse(mainUrl + endPoint + parma),
        headers: {"Content-Type": "application/json; charset=UTF-8"});

    switch (response.statusCode) {
      case 200:
        var responseJson =
            ResponseModel.Json(json.decode(response.body.toString()));
        // print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
    //print('data from RequestHandler${response.body}');
  }

  //Matches
  Future<PlayerInf> getPlayerInfo({
    endPoint,
    String parma = '',
  }) async {
    Response response = await http.get(Uri.parse(mainUrl + endPoint + parma),
        headers: {"Content-Type": "application/json; charset=UTF-8"});

    switch (response.statusCode) {
      case 200:
        var responseJson =
            PlayerInf.fromJson(json.decode(response.body.toString()));
        // print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
    //print('data from RequestHandler${response.body}');
  }

  Future<ResponseModelEachMatch> getEachMatch(
      {endPoint, String parma = ''}) async {
    Response response = await http.get(Uri.parse(mainUrl + endPoint + parma),
        headers: {"Content-Type": "application/json; charset=UTF-8"});
    try {
      switch (response.statusCode) {
        case 200:
          var responseJson = ResponseModelEachMatch.json(
              json.decode(response.body.toString()));
          //print(responseJson);
          return responseJson;
        case 400:
          throw BadRequestException(response.body.toString());
        case 401:
        case 403:
          throw UnauthorisedException(response.body.toString());
        case 500:
        default:
          throw FetchDataException(
              'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
      }
    } catch (e) {}
  }

  //Leagues
  Future<List<ResponseModelLeagues>> getDataLeagues({
    endPoint,
    String parma = '',
  }) async {
    Response response = await http.get(Uri.parse(mainUrl + endPoint + parma),
        headers: {"Content-Type": "application/json; charset=UTF-8"});
    if (response.statusCode != 200) {
      return null;
    }
    //print('data from RequestHandler${response.body}');
    return ResponseModelLeagues.listFromJson(json.decode(response.body));
  }

//oneLeague
  Future<MainResponse> getDataOneLeagues(
      {endPoint, String parma = '', context}) async {
    Response response = await http.get(Uri.parse(mainUrl + endPoint + parma),
        headers: {"Content-Type": "application/json; charset=UTF-8"});
    switch (response.statusCode) {
      case 200:
        mainResponse.data =
            ResponseModelOneLeague.json(json.decode(response.body.toString()));
        mainResponse.msg = 'Success';
        //print(mainResponse);
        return mainResponse;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        // mainResponse.data =null;
        mainResponse.msg = 'failed';
        //print(mainResponse.msg);
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Oops()));
        return mainResponse;
      default:
        mainResponse.msg = 'failed';
        return mainResponse;
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<MainResponse> getEachTeam({
    endPoint,
    String parma = '',
  }) async {
    Response response = await http.get(Uri.parse(mainUrl + endPoint + parma),
        headers: {"Content-Type": "application/json; charset=UTF-8"});
    switch (response.statusCode) {
      case 200:
        mainResponse.data =
            ResponseModelEachTeam.json(json.decode(response.body.toString()));
        mainResponse.msg = 'Success';
        //print(mainResponse);
        return mainResponse;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        // mainResponse.data =null;
        mainResponse.msg = 'failed';
        //print(mainResponse.msg);
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Oops()));
        return mainResponse;
      default:
        mainResponse.msg = 'failed';
        return mainResponse;
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<ResponseModelSquadTeam> getSquadTeam({
    endPoint,
    String parma = '',
  }) async {
    Response response = await http.get(Uri.parse(mainUrl + endPoint + parma),
        headers: {"Content-Type": "application/json; charset=UTF-8"});
    if (response.statusCode != 200) {
      return null;
    }
    //print('data from RequestHandler${response.body}');
    return ResponseModelSquadTeam.json(json.decode(response.body));
  }

  Future<ResponseModelCups> getCups({
    endPoint,
    String parma = '',
  }) async {
    Response response = await http.get(Uri.parse(mainUrl + endPoint + parma),
        headers: {"Content-Type": "application/json; charset=UTF-8"});
    if (response.statusCode != 200) {
      return null;
    }
    //print('data from RequestHandler${response.body}');
    return ResponseModelCups.json(json.decode(response.body));
  }

  Future<ResponseModelLeagueCups> getLeaguesCups({
    endPoint,
    String parma = '',
  }) async {
    Response response = await http.get(Uri.parse(mainUrl + endPoint + parma),
        headers: {"Content-Type": "application/json; charset=UTF-8"});
    if (response.statusCode != 200) {
      return null;
    }
    //print('data from RequestHandler${response.body}');
    return ResponseModelLeagueCups.json(json.decode(response.body));
  }

  Future<MainResponse> getTransfers(
      {endPoint, String parma = '', context}) async {
    String msg;
    Response response = await http.get(Uri.parse(mainUrl + endPoint + parma),
        headers: {"Content-Type": "application/json; charset=UTF-8"});
    switch (response.statusCode) {
      case 200:
        mainResponse.data =
            ResponseModelTransfers.json(json.decode(response.body.toString()));
        mainResponse.msg = 'Success';
        print(mainResponse);
        return mainResponse;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        // mainResponse.data =null;
        mainResponse.msg = 'failed';
        //print(mainResponse.msg);
        return mainResponse;
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<MainResponse> getHTHMatchData({
    endPoint,
    String parma = '',
  }) async {
    Response response = await http.get(Uri.parse(mainUrl + endPoint + parma),
        headers: {"Content-Type": "application/json; charset=UTF-8"});
    switch (response.statusCode) {
      case 200:
        mainResponse.data =
            ResponseModelHeadToHead.json(json.decode(response.body.toString()));
        mainResponse.msg = 'Success';
        //print(mainResponse);
        return mainResponse;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        // mainResponse.data =null;
        mainResponse.msg = 'failed';
        //print(mainResponse.msg);
        return mainResponse;
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
    //print('data from RequestHandler${response.body}');
  }

  Future<ResponseModelEvents> getMatchEndEvent({
    endPoint,
    String parma = '',
  }) async {
    Response response = await http.get(Uri.parse(mainUrl + endPoint + parma),
        headers: {"Content-Type": "application/json; charset=UTF-8"});

    if (response.statusCode != 200) {
      return null;
    }
    //print('data from RequestHandler${response.body}');
    return ResponseModelEvents.json(json.decode(response.body));
  }

  Future<ResponseModelNews> getNews({
    endPoint,
    String parma = '',
  }) async {
    Response response = await http.get(Uri.parse(mainUrl + endPoint + parma),
        headers: {"Content-Type": "application/json; charset=UTF-8"});
    if (response.statusCode != 200) {
      return null;
    }
    //print('data from RequestHandler${response.body}');
    return ResponseModelNews.json(json.decode(response.body));
  }

  Future<ResponseModelVideos> getVideos({
    endPoint,
    String parma = '',
  }) async {
    Response response = await http.get(Uri.parse(mainUrl + endPoint + parma),
        headers: {"Content-Type": "application/json; charset=UTF-8"});
    if (response.statusCode != 200) {
      return null;
    }
    //print('data from RequestHandler${response.body}');
    return ResponseModelVideos.json(json.decode(response.body));
  }

  Future<ResponseModelEachPlayer> getEachPlayer({
    endPoint,
    String parma = '',
  }) async {
    Response response = await http.get(Uri.parse(mainUrl + endPoint + parma),
        headers: {"Content-Type": "application/json; charset=UTF-8"});
    if (response.statusCode == 500) {
      return null;
    }
    //print('data from RequestHandler${response.body}');
    return ResponseModelEachPlayer.json(json.decode(response.body));
  }
}
