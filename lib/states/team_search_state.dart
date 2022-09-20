import 'package:arseli/Data/remote_data_sources/teams/models/TeamSearchModel.dart';
import 'package:arseli/Data/repos/team_repo.dart';
import 'package:arseli/controllers/ControllerFavorites.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class SearchState extends Equatable {
  const SearchState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchStateEmpty extends SearchState {
  List<Object> get props => [];
}

class SearchStateLoading extends SearchState {
  List<Object> get props => [];
}

class SearchStateSuccess extends SearchState {
  const SearchStateSuccess(
    this.data,
    this._timeStamp,
  );

  final int _timeStamp;
  final List<Team> data;

  @override
  List<Object> get props => [
        data,
        _timeStamp,
      ];

  SearchStateSuccess copyWith({
    List<Team> teams,
  }) {
    return SearchStateSuccess(
        teams ?? this.data, DateTime.now().millisecondsSinceEpoch);
  }
}

class SearchStateError extends SearchState {
  const SearchStateError();

  @override
  List<Object> get props => [];
}
