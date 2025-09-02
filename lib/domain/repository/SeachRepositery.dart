
import 'package:epl/Data/RequestHandler.dart';
import 'package:epl/domain/models/Search.dart';
import 'package:epl/domain/repository/SearchRepsiteryInterface.dart';

class SearchRepository extends SearchRepositoryInterface{
  RequestHandler requestHandler;

  SearchRepository(this.requestHandler);

  @override
  Future<SearchModel> getSearch(String searchKey) async{
    SearchModel searchModel;

    searchModel = await requestHandler.getData(
      endPoint: "soccer/search?q=$searchKey&lang=en",
      auth: true,
      fromJson: (json)=> SearchModel.fromJson(json),
    );

   searchModel.teams =  searchModel.teams.where((e)=> e.teamType == 'default').toList();
    return searchModel;
  }

}