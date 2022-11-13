import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapProvider with ChangeNotifier{


  Map<String,dynamic> dataa;
  MapProvider(){
    dataMap();
  }

  void dataMap() async{
    var prefs = await SharedPreferences.getInstance();
    String json =prefs.getString('token');
    Map<String,dynamic> map =jsonDecode(json);
    dataa = {
      'id':map['id'],
      'deviceInfo':map,
    };
  }

}