class ResponseModelTransfers{
  dynamic subNav;
  dynamic headerProfile;
  String pPath;
  String UIID;
  String dropdownURL;
  dynamic dropTableRows;
  String calName;
  dynamic transferBoxes;
  dynamic breadcrumb;

  ResponseModelTransfers(
      {this.subNav,
        this.headerProfile,
        this.pPath,
        this.UIID,
        this.dropdownURL,
        this.dropTableRows,
        this.calName,
        this.transferBoxes,
        this.breadcrumb});

  factory ResponseModelTransfers.json(Map json){
    return ResponseModelTransfers(
      subNav:json['subNav'],
      headerProfile:json['headerProfile'],
      pPath:json['pPath'],
      UIID:json['UIID'],
      dropdownURL: json['dropdownURL'],
      dropTableRows: json['dropTableRows'],
      calName:json['calName'],
      transferBoxes:json['transferBoxes'],
      breadcrumb:json['breadcrumb'],
    );
  }

}