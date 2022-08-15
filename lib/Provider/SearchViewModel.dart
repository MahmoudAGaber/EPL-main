


import 'package:arseli/Data/MainResponse.dart';
import 'package:arseli/Data/RequestHandler.dart';
import 'package:arseli/Models/SearchModel.dart';
import 'package:flutter/material.dart';

class SearchViewModel with ChangeNotifier{

  RequestHandler requestHandler = RequestHandler();
  List<SearchResponseModel> searchItems ;

  Future<void> getDataSearch(searchText)async{
    MainResponse response = await requestHandler.search(
      endPoint: '/fetch',
      parma: '?term=$searchText'
    );
    searchItems = response.data;
    notifyListeners();
  }
}