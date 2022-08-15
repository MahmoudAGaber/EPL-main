class TableModel{
  String tag;
  String id;
  String ocId;
  int serial;
  String link;
  String name;
  String logo;
  String logoAlternate;
  int colL;
  int colF;
  int colT;
  int colK;
  String colFA;
  int colN;

  TableModel(
      {this.tag,
      this.id,
      this.ocId,
      this.serial,
      this.link,
      this.name,
      this.logo,
      this.logoAlternate,
      this.colL,
      this.colF,
      this.colT,
      this.colK,
      this.colFA,
      this.colN});

  factory TableModel.json(Map json){
    return TableModel(
      tag: json['tag'],
      id: json['id'],
      ocId: json['ocId'],
      serial: json['serial'],
      link: json['link'],
      name: json['name'],
      logo: json['logo'],
      logoAlternate: json['logoAlternate'],
      colL: json['colL'],
      colF: json['colF'],
      colT: json['colT'],
      colK: json['colK'],
      colFA: json['colFA'],
      colN: json['colN'],

    );
  }

  static List<TableModel> listFromJson(List jsonData){
    return jsonData.map((obj) => TableModel.json(obj)).toList();
  }
}