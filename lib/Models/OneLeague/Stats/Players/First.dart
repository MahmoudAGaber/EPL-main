class FirstModel{
String URL;
String name;
String nameEn;
String teamLogo;
String teamName;
String teamNameEn;
String number;
String IMG;

FirstModel({this.URL, this.name, this.nameEn, this.teamLogo, this.teamName,
      this.teamNameEn, this.number, this.IMG});

factory FirstModel.json(Map json){
  return FirstModel(
    URL: json['URL'],
    name: json['name'],
    nameEn: json['nameEn'],
    teamLogo: json['teamLogo'],
    teamName: json['teamName'],
    teamNameEn: json['teamNameEn'],
    number: json['number'],
    IMG: json['IMG'],

  );
}
}