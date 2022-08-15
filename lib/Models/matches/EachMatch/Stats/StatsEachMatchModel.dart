
import 'package:arseli/Models/matches/EachMatch/Stats/HeaderModel.dart';

class StatsEachMatchModel{
  Header rows;
  Header header;

  StatsEachMatchModel({this.rows, this.header});

  factory StatsEachMatchModel.json(Map json){
    return StatsEachMatchModel(
      rows: Header.json(json['rows']??null),
      header: Header.json(json['header']??null),
    );
  }
}