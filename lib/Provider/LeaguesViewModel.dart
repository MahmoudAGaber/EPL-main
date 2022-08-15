
import 'package:arseli/Data/RequestHandler.dart';
import 'package:arseli/Models/Leagues/ResponseModelLeagues.dart';
import 'package:arseli/Models/Leagues/Tournaments.dart';
import 'package:arseli/Models/matches/Matches.dart';
import 'package:arseli/Models/matches/ResponseModel.dart';
import 'package:flutter/cupertino.dart';

class LeaguesViewModel with ChangeNotifier{
  bool loadingLeagues = true;
  List<ResponseModelLeagues> responseModelLeagues;
  List<TournamentsModel> tournamentsModel;
  RequestHandler requestHandler = RequestHandler();

  Future<void> getDataLeagues()async{
    List<ResponseModelLeagues> responseModel = await requestHandler.getDataLeagues(
        endPoint: '/tournaments'
    );

    responseModelLeagues = responseModel;

    loadingLeagues = false;
    notifyListeners();
  }
}