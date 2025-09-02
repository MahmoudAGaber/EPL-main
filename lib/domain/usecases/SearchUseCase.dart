

import 'package:epl/domain/models/Search.dart';
import 'package:epl/domain/repository/SeachRepositery.dart';

class GetSearchUseCase {
  final SearchRepository repository;

  GetSearchUseCase(this.repository);

  Future<SearchModel> execute(String searchKey) {
    return repository.getSearch(searchKey);
  }
}