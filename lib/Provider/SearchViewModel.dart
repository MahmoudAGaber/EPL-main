


import 'package:arseli/Data/MainResponse.dart';
import 'package:arseli/Data/RequestHandler.dart';
import 'package:arseli/Data/repos/team_repo.dart';
import 'package:arseli/Models/SearchModel.dart';
import 'package:arseli/Provider/favouriteViewModel.dart';
import 'package:flutter/material.dart';

import '../Data/remote_data_sources/teams/models/TeamSearchModel.dart';

class SearchViewModel with ChangeNotifier{

  RequestHandler requestHandler = RequestHandler();
  FavouriteViewModel favouriteViewModel;
  List<SearchResponseModel> searchItems =[];
  List<SearchResponseModel> searchItemsHome =[];
  List<SearchResponseModel> filterSearchItems =[];
  bool _searchLoading = false;
  bool get getSearchLoading => _searchLoading;




  Future<void> getHomeDataSearch(searchText)async{
    MainResponse response = await requestHandler.homeSearch(
        endPoint: '/fetch',
        parma: '?term=$searchText',

    );
    searchItemsHome =  response.data;
    //print("Helllllo${searchItemsHome[1].category}");

    notifyListeners();
  }

  Future<void> getDataSearch(searchText,boxName)async{
     MainResponse response = await requestHandler.search(
      endPoint: '/fetch',
      parma: '?term=$searchText',
         boxName: boxName

    );
     searchItems =  response.data;

    notifyListeners();
  }





  Future <void> filterSearch(searchText,filter,boxName)async{
    MainResponse response = await requestHandler.search(
        endPoint: '/fetch',
        parma: '?term=$searchText',
      boxName: boxName
    );

    filterSearchItems =  response.data;
    searchItems = filterSearchItems.toList().where((element) => element.category.toString() == filter).toList();

    notifyListeners();
  }

  Future <void> filterNewsSearch(searchText,boxName)async{
    MainResponse response = await requestHandler.search(
        endPoint: '/fetch',
        parma: '?term=$searchText',
        boxName: boxName
    );

    filterSearchItems =  response.data;
    searchItems = filterSearchItems.toList().where((element) => element.category.toString() != "الأخبار").toList();

    notifyListeners();
  }

  Future<void> clearLists()async{
     //searchItems=[];
    // filterSearchItems=[];

     notifyListeners();
  }

}