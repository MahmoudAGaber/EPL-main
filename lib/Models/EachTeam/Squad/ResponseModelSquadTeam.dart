class ResponseModelSquadTeam{
  dynamic subNav;
  dynamic headerProfile;
  String pPath;
  String UIID;
  String calName;
  dynamic squads;
  dynamic breadcrumb;

  ResponseModelSquadTeam(
      {this.subNav,
        this.headerProfile,
        this.pPath,
        this.UIID,
        this.calName,
        this.squads,
        this.breadcrumb});

  factory ResponseModelSquadTeam.json(Map json){
    return ResponseModelSquadTeam(
      subNav:json['subNav'],
      headerProfile:json['headerProfile'],
      pPath:json['pPath'],
      UIID:json['UIID'],
      calName:json['calName'],
      squads:json['squads'],
      breadcrumb:json['breadcrumb'],
    );
  }

}