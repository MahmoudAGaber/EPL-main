class ResponseModelHeadToHead{
  String UIID;
  String UIID2;
  dynamic tables;
  dynamic subNav;
  dynamic MSN;
  dynamic matchDetails;
  dynamic headtohead;

  ResponseModelHeadToHead({this.UIID, this.UIID2, this.tables, this.subNav, this.MSN,
      this.matchDetails,this.headtohead});

  factory ResponseModelHeadToHead.json(Map json){
    return ResponseModelHeadToHead(
      UIID:json['UIID'],
      UIID2:json['UIID2'],
      tables:json['tables'],
      subNav:json['subNav'],
      MSN:json['MSN'],
      matchDetails:json['matchDetails'],
      headtohead:json['headToHead'],
    );
  }
}