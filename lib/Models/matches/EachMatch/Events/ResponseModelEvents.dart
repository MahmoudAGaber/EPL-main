import 'package:arseli/Models/matches/EachMatch/Events/EventModel.dart';

class ResponseModelEvents{
  String UIID;
  String UIID2;
  dynamic tables;
  dynamic subNav;
  dynamic MSN;
  dynamic matchDetails;
  dynamic events;
  dynamic lineups;

  ResponseModelEvents({this.UIID, this.UIID2, this.tables, this.subNav, this.MSN,
      this.matchDetails,this.events,this.lineups});

  factory ResponseModelEvents.json(Map json){
    return ResponseModelEvents(
      UIID:json['UIID'],
      UIID2:json['UIID2'],
      tables:json['tables'],
      subNav:json['subNav'],
      MSN:json['MSN'],
      matchDetails:json['matchDetails'],
      events:json['events'],
      lineups:json['lineups'],
    );
  }
}