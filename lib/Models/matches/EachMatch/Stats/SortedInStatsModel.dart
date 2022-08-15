class SortedInStatsModelMatch{
  var name;
  var home;
  var away;

  SortedInStatsModelMatch({this.name, this.home,this.away});

  factory SortedInStatsModelMatch.json(Map json){
    return SortedInStatsModelMatch(
      name: json['name'],
      home: json['home'],
      away: json['away'],
    );
  }

  static List<SortedInStatsModelMatch> listJson(List data){
    return data.map((e) => SortedInStatsModelMatch.json(e)).toList();
  }
}