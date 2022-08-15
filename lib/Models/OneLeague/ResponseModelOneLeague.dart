
class ResponseModelOneLeague{
  dynamic subNav;
  dynamic dropTableRows;
  dynamic headerProfile;
  String pPath;
  String UIID;
  String calName;
  dynamic recentMatchesBoxes;
  dynamic matchs;
  dynamic newsBoxes;
  dynamic videoBoxes;
  dynamic tables;
  dynamic stats;
  dynamic breadcrumb;
  dynamic trophiesBoxes;
  dynamic transferBoxes;

  ResponseModelOneLeague(
      {this.subNav,
        this.dropTableRows,
      this.headerProfile,
      this.pPath,
      this.UIID,
      this.calName,
      this.recentMatchesBoxes,
        this.matchs,
      this.newsBoxes,
      this.videoBoxes,
      this.tables,
      this.stats,
      this.breadcrumb,
      this.trophiesBoxes,
      this.transferBoxes});

  factory ResponseModelOneLeague.json(Map json){
    return ResponseModelOneLeague(
      subNav:json['subNav'],
      dropTableRows:json['dropTableRows'],
      headerProfile:json['headerProfile'],
      pPath:json['pPath'],
      UIID:json['UIID'],
      calName:json['calName'],
      matchs:json['matchs'],
      recentMatchesBoxes:json['recentMatchesBoxes'],
      newsBoxes:json['newsBoxes'],
      videoBoxes:json['videoBoxes'],
      tables:json['tables']?? '',
      stats:json['stats'],
      trophiesBoxes:json['trophiesBoxes'],
      transferBoxes:json['transferBoxes'],
      breadcrumb:json['breadcrumb'],
    );
  }

}