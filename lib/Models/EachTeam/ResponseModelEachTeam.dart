class ResponseModelEachTeam{
  dynamic subNav;
  dynamic headerProfile;
  dynamic dropTableRows;
  String pPath;
  String UIID;
  String calName;
  dynamic recentMatchesBoxes;
  dynamic matches;
  dynamic newsBoxes;
  dynamic videoBoxes;
  dynamic tables;
  dynamic stats;
  dynamic breadcrumb;

  ResponseModelEachTeam(
      {this.subNav,
        this.dropTableRows,
      this.headerProfile,
      this.pPath,
      this.UIID,
      this.calName,
      this.recentMatchesBoxes,
        this.matches,
      this.newsBoxes,
      this.videoBoxes,
      this.tables,
      this.stats,
      this.breadcrumb});

  factory ResponseModelEachTeam.json(Map json){
    return ResponseModelEachTeam(
      subNav:json['subNav'],
      headerProfile:json['headerProfile'],
      dropTableRows: json["dropTableRows"],
      pPath:json['pPath'],
      UIID:json['UIID'],
      calName:json['calName'],
      recentMatchesBoxes:json['recentMatchesBoxes'],
      matches:json['matches'],
      newsBoxes:json['newsBoxes'],
      videoBoxes:json['videoBoxes'],
      tables:json['tables'],
      stats:json['stats'],
      breadcrumb:json['breadcrumb'],
    );
  }

}