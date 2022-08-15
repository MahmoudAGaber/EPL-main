
import 'package:arseli/Models/OneLeague/FooterModel.dart';

import 'TableModel.dart';

class MainTables{
  List<TablesModel> list;
  MainTables({this.list});

  factory MainTables.json(Map json){
    return MainTables(
      list: TablesModel.listFromJson(json['tables']??TablesModel())
    );
  }

  static List<MainTables> listfromJson(List jsonData){
    return jsonData.map((obj) => MainTables.json(obj??[])).toList();
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
    tableModel: TableModel.listFromJson(json['table']??TablesModel()),
    footermodel: FooterModel.listFromJson(json['footer']??[])
  );

}
static List<TablesModel>listFromJson(List jsonData){
  return jsonData.map((obj) => TablesModel.json(obj)).toList();
}
}