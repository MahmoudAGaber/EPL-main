
import 'package:arseli/Models/matches/EachMatch/Stats/SortedInStatsModel.dart';

class SortedStatsModelMatch{
  List<SortedInStatsModelMatch> general;
  List<SortedInStatsModelMatch> passing;
  List<SortedInStatsModelMatch> attack;
  List<SortedInStatsModelMatch> defend;
  List<SortedInStatsModelMatch> precision;

  SortedStatsModelMatch({this.general, this.passing,this.attack,this.defend,this.precision});

  factory SortedStatsModelMatch.json(Map json){
    return SortedStatsModelMatch(
      general:SortedInStatsModelMatch.listJson(json['عام']??[]),
      passing: SortedInStatsModelMatch.listJson(json['توزيع']??[]),
      attack: SortedInStatsModelMatch.listJson(json['هجوم']??[]),
      defend: SortedInStatsModelMatch.listJson(json['دفاع']??[]),
      precision: SortedInStatsModelMatch.listJson(json['إنضباط']??[]),
    );
  }
}