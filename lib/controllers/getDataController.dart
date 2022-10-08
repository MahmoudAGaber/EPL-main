import 'dart:async';

import 'package:arseli/Data/remote_data_sources/teams/models/TeamSearchModel.dart';
import 'package:arseli/Data/repos/team_repo.dart';
import 'package:arseli/states/team_search_state.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  SearchController(this.teamRepo);

  CancelableOperation cancelableOperation;
  Timer _debounce;

  final TeamRepo teamRepo;
  final searchTextEditingController = TextEditingController();
  final teamSearchState = SearchState().obs;

  // suceess

  List<Team> get searchState => (teamSearchState.value as SearchStateSuccess).data;

  Future<void> search() async {
    final searchKey = searchTextEditingController.text;
    if (searchKey.isEmpty) {
      return;
    }
    try {
      cancelableOperation?.cancel();
      print('---------after cancel----------');
      print('---------$cancelableOperation----------');
      print('---------$searchKey----------');
      cancelableOperation = CancelableOperation.fromFuture(
        teamRepo.search(searchKey),
        onCancel: () {
          teamRepo.teamsRemoteDataSource.cancelToken.cancel();
        },
      );
      teamSearchState.value = SearchStateLoading();

      final result = await cancelableOperation.value;
      print('searchkey: $searchKey');
      print('result: $result');

      teamSearchState.value = SearchStateSuccess(result, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      teamSearchState.value = SearchStateError();
    }
  }

  void _debouncer(Function callback) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), callback);
  }

  void onChanged() async {
    _debouncer(search);
  }

  String lastInputValue;

  // init
  void listener() {
    final text = searchTextEditingController.text;
    if (lastInputValue == text) {
      return;
    }
    lastInputValue = text;

    print('listener');
    if (text.isEmpty) {
      cancelableOperation?.cancel();
      teamSearchState.value = SearchInitial();
    } else {
      onChanged();
    }
  }

  @override
  void onInit() {
    super.onInit();
    searchTextEditingController.addListener(listener);
  }
}
