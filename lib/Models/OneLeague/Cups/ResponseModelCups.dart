class ResponseModelLeagueCups{
  dynamic subNav;
  dynamic headerProfile;
  String pPath;
  String UIID;
  String calName;
  dynamic trophiesBoxes;
  dynamic breadcrumb;

  ResponseModelLeagueCups(
      {this.subNav,
        this.headerProfile,
        this.pPath,
        this.UIID,
        this.calName,
        this.trophiesBoxes,
        this.breadcrumb});

  factory ResponseModelLeagueCups.json(Map json){
    return ResponseModelLeagueCups(
      subNav:json['subNav'],
      headerProfile:json['headerProfile'],
      pPath:json['pPath'],
      UIID:json['UIID'],
      calName:json['calName'],
      trophiesBoxes:json['trophiesBoxes'],
      breadcrumb:json['breadcrumb'],
    );
  }

}