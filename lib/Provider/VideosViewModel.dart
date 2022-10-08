import 'package:arseli/Data/RequestHandler.dart';
import 'package:arseli/Models/EachTeam/VideoModel.dart';
import 'package:arseli/Models/News/CategoriesModel.dart';
import 'package:arseli/Models/News/NewsModel.dart';
import 'package:arseli/Models/News/ResponseModelNews.dart';
import 'package:arseli/Models/Videos/ResponseModelVideos.dart';
import 'package:arseli/news.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VideosViewModel with ChangeNotifier{
  bool add = false;
  bool init = true;
  bool endOfList = false;
  bool loadingVideos = true;

  RequestHandler requestHandler = RequestHandler();
  List<VideoModel> videosList;
  List<VideoModel> videosListAdd=[];
  List<CategoriesModel> categoriesList;

  Future<void> getVideos(String firstItem,int page,String filter)async{

    ResponseModelVideos responseModel = await requestHandler.getVideos(
        endPoint: '/videos',
        parma: '?page=$page&filter=$filter'
    );


   // videosList =VideoModel.listFromJson(responseModel.videos);
    categoriesList=List();
    categoriesList.add(CategoriesModel(name: firstItem,accounts: List(),ocId: ""));
    categoriesList.addAll(CategoriesModel.listFromJson(responseModel.categories));

    if(page <=1 ){
      add = false;
      videosList =VideoModel.listFromJson(responseModel.videos);
      notifyListeners();
    }
    else if(page > 1){
      add = true;
      videosListAdd =VideoModel.listFromJson(responseModel.videos);
      videosList.addAll(videosListAdd);
      videosListAdd.clear();
      add = false;
      notifyListeners();
    }
    //videosList.addAll(videosListAdd);
    loadingVideos = false;
    notifyListeners();
  }

}