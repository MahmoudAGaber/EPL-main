import 'package:arseli/Models/matches/EachMatch/Events/DetailsModel.dart';

class EventsModel{
  String linkedTo;
 DetailsModel details;

  EventsModel({this.linkedTo, this.details});

  factory EventsModel.json(Map json){
    return EventsModel(
      linkedTo: json['linkedTo'],
      details: DetailsModel.json(json['details'])
    );
  }

  static List<EventsModel>listFromJson(List jsonData){
    return jsonData.map((e) => EventsModel.json(e)).toList();
  }

}