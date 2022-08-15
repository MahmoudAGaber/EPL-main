import 'package:arseli/Models/matches/EachMatch/Events/EventModel.dart';
import 'package:arseli/Models/matches/EachMatch/HeadToHead/HeadTOHeadModel.dart';
import 'package:arseli/Models/matches/EachMatch/Lineups/Lineups.dart';
import 'package:arseli/Models/matches/EachMatch/MatchDetails/MatchDetailsModel.dart';

import 'Stats/SortedStatsModel.dart';

class ResponseModelEachMatch{
  String UIID;
  String UIID2;
  dynamic tables;
  dynamic subNav;
  dynamic MSN;
  dynamic matchDetails;
  dynamic headtohead;
  dynamic events;
  dynamic stats;
  dynamic lineups;
  dynamic SortedStats;

  ResponseModelEachMatch({this.UIID, this.UIID2, this.tables, this.subNav, this.MSN,
      this.matchDetails,this.headtohead,this.events,this.stats,this.lineups,this.SortedStats});

  factory ResponseModelEachMatch.json(Map json){
    return ResponseModelEachMatch(
      UIID:json['UIID'],
      UIID2:json['UIID2'],
      tables:json['tables'],
      subNav:json['subNav'],
      MSN:json['MSN'],
      matchDetails:json['matchDetails']??MatchDetailsModel(),
      headtohead:json['headtohead']??HeadToHeadModel(),
      events:json['events']??EventsModel(),
      stats:json['stats']??SortedStatsModelMatch(),
      lineups:json['lineups']??LineupsModel(),
      SortedStats:json['SortedStats']??SortedStatsModelMatch(),
    );
  }
}