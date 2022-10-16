import 'package:arseli/Data/RequestHandler.dart';
import 'package:arseli/Models/matches/Matches.dart';
import 'package:arseli/Models/matches/PlayerInf.dart';
import 'package:arseli/Models/matches/ResponseModel.dart';
import 'package:arseli/Models/matches/SubOfMatches.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class MatchesViewModel with ChangeNotifier {
  RequestHandler requestHandler = RequestHandler();
  List<MatchesModel> matchesList;
  List<MatchesModel> matchesList2 = [];
  List<SubOfMathes> subOfMatches = [];
  List<SubOfMathes> subOfMatches2 = [];
  bool loadingMatches = true;
  bool liveMatches = false;

  Future<void> getMatches(date) async {
    ResponseModel responseModel = await requestHandler.getDataMatches(
        endPoint: '/match', parma: '?date=$date');

    if (liveMatches == false) {
      matchesList = MatchesModel.listFromJson(responseModel.matches);
      notifyListeners();
    }

    if (liveMatches == true) {
      matchesList = MatchesModel.listFromJson(responseModel.matches);
      for (int i = 0; i < matchesList.length; i++) {
        for (int j = 0; j < matchesList[i].subOfMathes.length; j++) {
          if (matchesList[i].subOfMathes[j].status == "Playing") {
            matchesList2.add(matchesList[i]);

          }
        }
      }
      matchesList.clear();
      matchesList = matchesList2;
      notifyListeners();
    }

    loadingMatches = false;
    notifyListeners();
  }

  Future<void> getLiveMatches(date) async {
    ResponseModel responseModel = await requestHandler.getDataMatches(
        endPoint: '/match', parma: '?date=$date');
    matchesList = MatchesModel.listFromJson(responseModel.matches);
    matchesList2.clear();

    for (int i = 0; i < matchesList.length; i++) {
      for (int j = 0; j < matchesList[i].subOfMathes.length; j++) {
        if (matchesList[i].subOfMathes[j].status == "Playing") {

          matchesList2.add(matchesList[i]);
          subOfMatches2.add(matchesList[i].subOfMathes[j]);
        }
      }
    }
    matchesList.clear();

    var seen = Set<MatchesModel>();
    matchesList = matchesList2.where((element) => seen.add(element)).toList();


    print("hiiiiiii$subOfMatches");

    loadingMatches = false;
    notifyListeners();
  }


  Future<void> getMatchesByTime(date) async {
    ResponseModel responseModel = await requestHandler.getDataMatches(
        endPoint: '/match', parma: '?date=$date');
    matchesList = MatchesModel.listFromJson(responseModel.matches);
    matchesList2.clear();
    subOfMatches2.clear();

    for (int i = 0; i < matchesList.length; i++) {
      for (int j = 0; j < matchesList[i].subOfMathes.length; j++) {
        if (matchesList[i].subOfMathes[j].status == "Played") {
          matchesList2.add(matchesList[i]);
          subOfMatches2.add(matchesList[i].subOfMathes[j]);
        }
        else if((matchesList[i].subOfMathes[j].status == "Playing")){
          matchesList2.add(matchesList[i]);
          subOfMatches2.add(matchesList[i].subOfMathes[j]);
        }
        else if((matchesList[i].subOfMathes[j].status == "Fixture")){
          print("Now Here");
          matchesList2.add(matchesList[i]);
          subOfMatches2.add(matchesList[i].subOfMathes[j]);
          subOfMatches2.sort((first,next) => DateFormat("hh:mm").parse(first.time).compareTo( DateFormat("hh:mm").parse(next.time)));

        }
      }
    }
    /*
    for (int i = 0; i < matchesList.length; i++) {
      for (int j = 0; j < matchesList[i].subOfMathes.length; j++) {
        if (matchesList[i].subOfMathes[j].status == "Playing") {
          matchesList2.add(matchesList[i]);
          subOfMatches2.add(matchesList[i].subOfMathes[j]);
        }
      }
    }
    for (int i = 0; i < matchesList.length; i++) {
      for (int j = 0; j < matchesList[i].subOfMathes.length; j++) {
        if (matchesList[i].subOfMathes[j].status == "Fixture") {
          matchesList2.add(matchesList[i]);
          subOfMatches2.add(matchesList[i].subOfMathes[j]);
        }
      }
    }

     */
    matchesList.clear();
    var seen = Set<MatchesModel>();
    var seen2 = Set<SubOfMathes>();
    matchesList = matchesList2.where((element) => seen.add(element)).toList();
    subOfMatches = subOfMatches2.where((element) => seen2.add(element)).toList();
    print(subOfMatches[2].homeName);

    loadingMatches = false;
    notifyListeners();
  }


}
