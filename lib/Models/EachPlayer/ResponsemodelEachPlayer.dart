class ResponseModelEachPlayer{
  dynamic subNav;
  dynamic headerProfile;
  String pPath;
  String UIID;
  dynamic pI;
  String calName;
  dynamic recentNewsLoop;
  dynamic recentVideos;
  dynamic breadcrumb;

  ResponseModelEachPlayer(
      {this.subNav,
      this.headerProfile,
      this.pPath,
      this.UIID,
      this.pI,
      this.calName,
      this.recentNewsLoop,
      this.recentVideos,
      this.breadcrumb});

  factory ResponseModelEachPlayer.json(Map json){
    return ResponseModelEachPlayer(
      subNav: json['subNav'],
      headerProfile: json['headerProfile'],
      pPath: json['pPath'],
      UIID: json['UIID'],
      pI: json['pI'],
      calName: json['calName'],
      recentNewsLoop: json['recentNewsLoop'],
      recentVideos: json['recentVideos'],
      breadcrumb: json['breadcrumb'],
    );
  }
}