import 'package:arseli/Data/RequestHandler.dart';
import 'package:arseli/Models/EachPlayer/HeaderProfileModel.dart';
import 'package:arseli/Models/EachPlayer/ResponsemodelEachPlayer.dart';
import 'package:arseli/Models/EachPlayer/StatsModel.dart';
import 'package:arseli/Models/EachPlayer/piModel.dart';
import 'package:arseli/Oops.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EachplayerViewModel with ChangeNotifier{

  bool loadingPlayer= true;
  bool loadingHeader= true;
  RequestHandler requestHandler = RequestHandler();
  PiModel piModel;
  HeaderProfileModel headerProfileModel;
  StatsModel statsModel;
  String noData;

  Future<void>getHeaderProfile(url,context) async {
    ResponseModelEachPlayer responseModel= await requestHandler.getEachPlayer(
      endPoint: url,
    );

    if(responseModel == null){
     await Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context)=>Oops()));
    }
   try {
     headerProfileModel = HeaderProfileModel.json(responseModel.headerProfile);
    }catch(e){}

    loadingHeader =false;
    notifyListeners();
  }


  Future<void>getProfile(url) async {
    ResponseModelEachPlayer responseModel= await requestHandler.getEachPlayer(
      endPoint: url,
    );
    try {
      piModel = PiModel.json(responseModel.pI);
    }catch(e){}
    loadingPlayer =false;
    notifyListeners();
  }
}