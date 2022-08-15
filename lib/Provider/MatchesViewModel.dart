import 'package:arseli/Data/RequestHandler.dart';
import 'package:arseli/Models/matches/Matches.dart';
import 'package:arseli/Models/matches/PlayerInf.dart';
import 'package:arseli/Models/matches/ResponseModel.dart';
import 'package:flutter/cupertino.dart';

class MatchesViewModel with ChangeNotifier {
  RequestHandler requestHandler = RequestHandler();
  List<MatchesModel> matchesList;
  List<MatchesModel> matchesList2 = [];
  bool loadingMatches = true;
  bool liveMatches = false;

  Future<void> getMatches(date) async {
    ResponseModel responseModel = await requestHandler.getDataMatches(
        endPoint: '/match', parma: '?date=$date');

    if (liveMatches == false) {
      matchesList = MatchesModel.listFromJson(responseModel.matches);
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
    }

    loadingMatches = false;
    notifyListeners();
  }

  Future<void> getLiveMatches(date) async {
    ResponseModel responseModel = await requestHandler.getDataMatches(
        endPoint: '/match', parma: '?date=$date');
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
    print("hiiiiiii$matchesList");

    loadingMatches = false;
    notifyListeners();
  }


}
