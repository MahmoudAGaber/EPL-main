
import 'dart:io';
import 'package:arseli/Provider/SearchViewModel.dart';
import 'package:arseli/favourite/favouriteTeam.dart';
import 'package:hive/hive.dart';
import 'package:arseli/Models/SearchModel.dart';
import 'package:flutter/cupertino.dart';

import '../localSorageRepo.dart';

class FavouriteViewModel extends ChangeNotifier{
  List<SearchResponseModel> favouriteModelList;
  List<SearchResponseModel> playerModelList;
  List<SearchResponseModel> leaguesiteModelList;
  List<SearchResponseModel> teamsModelList;
  bool _favouriteLoading = false;
  bool isFavourite = false;
  bool get getFavouriteLoading => _favouriteLoading;
  LocalStorageRepo localStorageRepo = LocalStorageRepo();


Future<void> getAllFavouriteItems(String boxName)async{
  Box box = await localStorageRepo.openBox(boxName);
  favouriteModelList = localStorageRepo.getFavouriteList(box);
  notifyListeners();
}

  Future<void> getTeamsItems(String boxName)async{
    Box box = await localStorageRepo.openBox(boxName);
    teamsModelList = localStorageRepo.getFavouriteList(box);
    notifyListeners();
  }


  Future<void> getAllLeaguesItems(String boxName)async{
    Box box = await localStorageRepo.openBox(boxName);
    leaguesiteModelList = localStorageRepo.getFavouriteList(box);
    notifyListeners();
  }


  Future<void> getAllPlayersItems(String boxName)async{
    Box box = await localStorageRepo.openBox(boxName);
    playerModelList = localStorageRepo.getFavouriteList(box);
    notifyListeners();
  }




  Future<void> addFavouriteItem(SearchResponseModel favouriteItem,String boxName)async{
   Box box = await localStorageRepo.openBox(boxName);
    localStorageRepo.addFavouriteItemToList(box,favouriteItem);
    if(boxName == "favouritesList"){
      favouriteModelList = box.values.toList();
    }else if(boxName == "teamsList"){
      teamsModelList = box.values.toList();
    }else if(boxName == "leaguesList"){
      leaguesiteModelList = box.values.toList();
    }else if(boxName == "playersList"){
      playerModelList = box.values.toList();
    }

  notifyListeners();
  }



Future<void> removeFavouriteItem(SearchResponseModel favouriteItem,String boxName)async{
  Box box = await localStorageRepo.openBox(boxName);
  favouriteModelList.remove(localStorageRepo.removeFavouriteItemToList(box,favouriteItem));
  if(boxName == "favouritesList"){
    favouriteModelList = box.values.toList();
  }else if(boxName == "teamsList"){
    teamsModelList = box.values.toList();
  }else if(boxName == "leaguesList"){
    leaguesiteModelList = box.values.toList();
  }else if(boxName == "playersList"){
    playerModelList = box.values.toList();
  }
  notifyListeners();
}

void isFavouriteItem(){

}

void toggleLoading(bool loading){
  _favouriteLoading = loading;
  notifyListeners();
}

}