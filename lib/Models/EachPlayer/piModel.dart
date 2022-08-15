import 'package:arseli/Models/EachPlayer/StatsModel.dart';

class PiModel{
  dynamic uid;
  String id;
  String countryOfBirth;
  String countryOfBirthId;
  String dateOfBirth;
  String firstName;
  String gender;
  String height;
  String lastUpdated;
  String lastName;
  String matchName;
  List membership;
  String nationality;
  String nationalityId;
  String ocId;
  String ocNationalityId;
  String position;
  String status;
  String type;
  bool active;
  int comp_order;
  bool home;
  String shortFirstName;
  String shortLastName;
  String countryOfBirth_En;
  String firstName_En;
  String lastName_En;
  String matchName_En;
  String nationality_En;
  int age;
  String nationalityLogo;
  StatsModel Stats;
  List career;

  PiModel(
     { this.uid,
      this.id,
      this.countryOfBirth,
      this.countryOfBirthId,
      this.dateOfBirth,
      this.firstName,
      this.gender,
       this.height,
      this.lastUpdated,
      this.lastName,
      this.matchName,
      this.membership,
      this.nationality,
      this.nationalityId,
      this.ocId,
      this.ocNationalityId,
      this.position,
      this.status,
      this.type,
      this.active,
      this.comp_order,
      this.home,
      this.shortFirstName,
      this.shortLastName,
      this.countryOfBirth_En,
      this.firstName_En,
      this.lastName_En,
      this.matchName_En,
      this.nationality_En,
      this.age,
      this.nationalityLogo,
      this.Stats,
      this.career});

  factory PiModel.json(Map json){
    return PiModel(
      uid: json['uid'],
      id: json['id'],
      countryOfBirth: json['countryOfBirth'],
      countryOfBirthId: json['countryOfBirthId'],
      dateOfBirth: json['dateOfBirth'],
      firstName: json['firstName'],
      gender: json['gender'],
      height: json['height'] == null ? '':json['height'],
      lastUpdated: json['lastUpdated'],
      lastName: json['lastName'],
      matchName: json['matchName'],
      membership: json['membership'],
      nationality: json['nationality'],
      nationalityId: json['nationalityId'],
      ocId: json['ocId'],
      ocNationalityId: json['ocNationalityId'],
      position: json['position'],
      status: json['status'],
      type: json['type'],
      active: json['active'],
      comp_order: json['comp_order'],
      home: json['home'],
      shortFirstName: json['shortFirstName'],
      shortLastName: json['shortLastName'],
      countryOfBirth_En: json['countryOfBirth_En'],
      firstName_En: json['firstName_En'],
      lastName_En: json['lastName_En'],
      matchName_En: json['matchName_En'],
      nationality_En: json['nationality_En'],
      age: json['age'],
      nationalityLogo: json['nationalityLogo'],
      Stats: StatsModel.json(json['Stats']?? Map()),
      career: json['career'],
    );
  }
}