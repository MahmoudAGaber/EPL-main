

import 'package:arseli/Models/EachTeam/FooterModel.dart';
import 'package:arseli/Models/EachTeam/TableModel.dart';

class MainTables {
  List<TablesModel> list;

  MainTables({this.list});

  factory MainTables.json(Map json){
    return MainTables(
      list: TablesModel.listFromJson(json['tables']??[])
    );
  }

  static List<MainTables> listfromJson(List jsonData){
    return jsonData.map((obj) => MainTables.json(obj)).toList();
  }
}


class TablesModel{
String title;
List<TableModel> tableModel;
List<FooterModel> footermodel;

TablesModel({this.title, this.tableModel, this.footermodel});

factory TablesModel.json(Map json){
  return TablesModel(
    title: json['title'],
    tableModel: TableModel.listFromJson(json['table']),
    footermodel: FooterModel.listFromJson(json['footer']??[])
  );

}
static List<TablesModel>listFromJson(List jsonData){
  return jsonData.map((obj) => TablesModel.json(obj)).toList();
}
}

class TablesGModel{
  String title;
  List<TableModel> tableModel;
  List<FooterModel> footermodel;

  TablesGModel({this.title, this.tableModel, this.footermodel});

  factory TablesGModel.json(Map json){
    return TablesGModel(
        title: json['title'],
        tableModel: TableModel.listFromJson(json['table']),
        footermodel: FooterModel.listFromJson(json['footer']??[])
    );

  }
  static List<TablesGModel>listFromJson(List jsonData){
    return jsonData.map((obj) => TablesGModel.json(obj)).toList();
  }
}