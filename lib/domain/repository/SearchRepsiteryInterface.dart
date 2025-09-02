
import '../models/Search.dart';

abstract class SearchRepositoryInterface{

  Future<SearchModel> getSearch(String searchKey);

}