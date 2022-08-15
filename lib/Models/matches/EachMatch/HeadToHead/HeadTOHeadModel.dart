import 'package:arseli/Models/matches/EachMatch/HeadToHead/HeaderModel.dart';
import 'package:arseli/Models/matches/EachMatch/HeadToHead/RowModel.dart';

class HeadToHeadModel{
  HeaderModel header;
  List<RowModel> rows;

  HeadToHeadModel({this.header, this.rows});

  factory HeadToHeadModel.json(Map json){
    return HeadToHeadModel(
      header: HeaderModel.json(json['header']),
      rows: RowModel.listFromJson(json['rows']) ,
    );
  }
}