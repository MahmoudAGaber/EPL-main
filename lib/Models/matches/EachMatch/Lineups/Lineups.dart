import 'package:arseli/Models/matches/EachMatch/Lineups/HomeAndAwayModel.dart';

class LineupsModel{
  HomeAndAwayModel home;
  HomeAndAwayModel away;

  LineupsModel({this.home, this.away});

  factory LineupsModel.json(Map json){
    return LineupsModel(
      home: HomeAndAwayModel.json(json['home']),
      away: HomeAndAwayModel.json(json['away'])
    );
  }
}