import 'package:arseli/Data/RequestHandler.dart';
import 'package:arseli/Models/News/CategoriesModel.dart';
import 'package:arseli/Models/News/NewsModel.dart';
import 'package:arseli/Models/News/ResponseModelNews.dart';
import 'package:arseli/news.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsViewModel with ChangeNotifier{
  bool loadingNews = true;
  bool add = false;
  bool init = true;
  RequestHandler requestHandler = RequestHandler();
  List<NewsModel> newsList;
  List<NewsModel> newsListAdd=[];
  List<CategoriesModel> categoriesList;

  Future<void> getNews(int page,String filter)async{
    ResponseModelNews responseModel = await requestHandler.getNews(
        endPoint: '/news',
        parma: '?page=$page&filter=$filter'
    );


    categoriesList =CategoriesModel.listFromJson(responseModel.categories);

    if(page <=1 ){
      add = false;
      newsList =NewsModel.listFromJson(responseModel.news);
    }
    else if(page > 1){
      add = true;
      newsListAdd =NewsModel.listFromJson(responseModel.news);
      newsList.addAll(newsListAdd);

      newsListAdd.clear();
    }

    loadingNews = false;
    notifyListeners();
  }

}