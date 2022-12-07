

import 'package:hive/hive.dart';

import 'Models/SearchModel.dart';

class LocalStorageRepo{

  @override
  Future<Box> openBox(String boxName)async{
    Box box = await Hive.openBox<SearchResponseModel>(boxName);
    return box;
  }

  @override
  List<SearchResponseModel> getFavouriteList(Box box){
    return box.values.toList() as List<SearchResponseModel>;
  }

  @override
  Future<SearchResponseModel> addFavouriteItemToList(Box box,SearchResponseModel responseModel)async{
    await box.put(responseModel.url,responseModel);
    return responseModel;
  }

  @override
  Future<SearchResponseModel> removeFavouriteItemToList(Box box,SearchResponseModel responseModel)async{
    await box.delete(responseModel.url);
    return responseModel;
  }

}