import 'package:arseli/Models/Leagues/Transfers/QuickDetailsModel.dart';

class TransferBoxesModel{
  String link;
  String date;
  String mainIMG;
  String name;
  String nameEn;
  String position;
  String positionEn;
  String fromURL;
  String fromName;
  String fromNameEn;
  String fromLogo;
  String toURL;
  String toName;
  String toNameEn;
  String toLogo;
  QuickDetailsModel quickDetails;
  String sdate;

  TransferBoxesModel(
      {this.link,
      this.date,
      this.mainIMG,
      this.name,
      this.nameEn,
      this.position,
      this.positionEn,
      this.fromURL,
      this.fromName,
      this.fromNameEn,
      this.fromLogo,
      this.toURL,
      this.toName,
      this.toNameEn,
      this.toLogo,
      this.quickDetails,
      this.sdate});

  factory TransferBoxesModel.json(Map json){
    return TransferBoxesModel(
      link: json['link'],
      date: json['date'],
      mainIMG: json['mainIMG'],
      name: json['name'],
      nameEn: json['nameEn'],
      position: json['position'],
      positionEn: json['positionEn'],
      fromURL: json['fromURL'],
      fromName: json['fromName'],
      fromNameEn: json['fromNameEn'],
      fromLogo: json['fromLogo'],
      toURL: json['toURL'],
      toName: json['toName'],
      toNameEn: json['toNameEn'],
      toLogo: json['toLogo'],
      quickDetails: QuickDetailsModel.json(json['quickDetails']),
      sdate: json['sdate'],


    );
  }

  static List<TransferBoxesModel>listFromJson(List jsonData){
    return jsonData.map((e) => TransferBoxesModel.json(e)).toList();
  }
}