
class CoachModel{
  String name;
  String id;
  String img;
  String quickViewLink;
  String link;


  CoachModel(
      {this.name,
      this.id,
      this.img,
      this.quickViewLink,
      this.link,});

  factory CoachModel.json(Map json){
    return CoachModel(
      name: json['name'],
      id: json['id'],
      img: json['img'],
      quickViewLink: json['quickViewLink'],
      link: json['link'],
    );
  }

  static List<CoachModel> listFromJson(List jsonData){
    return jsonData.map((e) => CoachModel.json(e)).toList();
  }
}