class ResponseModelCups{
  dynamic subNav;
  dynamic headerProfile;
  String pPath;
  String UIID;
  String calName;
  dynamic trophiesBoxes;
  dynamic breadcrumb;

  ResponseModelCups(
      {this.subNav,
        this.headerProfile,
        this.pPath,
        this.UIID,
        this.calName,
        this.trophiesBoxes,
        this.breadcrumb});

  factory ResponseModelCups.json(Map json){
    return ResponseModelCups(
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