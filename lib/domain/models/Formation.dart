class FormationsModel {
  List<Formation> formations;
  List<List<Bench>> bench;
  FormationsModel({required this.formations, required this.bench});

  factory FormationsModel.fromJson(Map<String, dynamic> json) {
    return FormationsModel(
      formations: List<Formation>.from(json['formations'].map((item) => Formation.fromJson(item)),),
      bench: List<List<Bench>>.from(json['bench'].map((item) => List<Bench>.from(item.map((benchItem) => Bench.fromJson(benchItem)))),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'formations': formations.map((item) => item.toJson()).toList(),
      'bench': bench.map((item) => item.map((benchItem) => benchItem.toJson()).toList()).toList(),
    };
  }
}

class Formation {
  Team team;
  Coach coach;
  String formation;
  List<StartXI> startXI;

  Formation({
    required this.team,
    required this.coach,
    required this.formation,
    required this.startXI,
  });

  factory Formation.fromJson(Map<String, dynamic> json) {
    return Formation(
      team: Team.fromJson(json['team']),
      coach: Coach.fromJson(json['coach']),
      formation: json['formation']??"4-4-2",
      startXI: List<StartXI>.from(
        json['startXI'].map((item) => StartXI.fromJson(item)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'team': team.toJson(),
      'coach': coach.toJson(),
      'formation': formation,
      'startXI': startXI.map((item) => item.toJson()).toList(),
    };
  }
}

class Team {
  String id;
  String name;
  String logo;

  Team({required this.id, required this.name, required this.logo});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id']??"",
      name: json['name']??"",
      logo: json['logo']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
    };
  }
}

class Coach {
  String? id;
  String? name;
  String photo;

  Coach({this.id, this.name, required this.photo});

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      id: json['id']??"",
      name: json['name']??"",
      photo: json['photo']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
    };
  }
}

class StartXI {
  PlayerForamtion player;

  StartXI({required this.player});

  factory StartXI.fromJson(Map<String, dynamic> json) {
    return StartXI(
      player: PlayerForamtion.fromJson(json['player']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'player': player.toJson(),
    };
  }
}

class PlayerForamtion {
  int id;
  String name;
  int number;
  String pos;
  String grid;
  List<Event> events;

  PlayerForamtion({
    required this.id,
    required this.name,
    required this.number,
    required this.pos,
    required this.grid,
    required this.events,
  });

  factory PlayerForamtion.fromJson(Map<String, dynamic> json) {
    return PlayerForamtion(
      id: json['id']??0,
      name: json['name']??"",
      number: json['number']??0,
      pos: json['pos']??"",
      grid: json['grid']??"",
      events: List<Event>.from(
        json['events'].map((item) => Event.fromJson(item)) ?? [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'pos': pos,
      'grid': grid,
      'events': events.map((item) => item.toJson()).toList(),
    };
  }
}

class Event {
  Time time;
  Assist? assist;
  String type;
  String detail;
  String? comments;

  Event({
    required this.time,
    this.assist,
    required this.type,
    required this.detail,
    this.comments,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      time: Time.fromJson(json['time']),
      assist: json['assist'] != null ? Assist.fromJson(json['assist']) : null,
      type: json['type']??"",
      detail: json['detail']??"",
      comments: json['comments']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time.toJson(),
      'assist': assist?.toJson(),
      'type': type,
      'detail': detail,
      'comments': comments,
    };
  }
}

class Time {
  String elapsed;
  String? extra;

  Time({required this.elapsed, this.extra});

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      elapsed: json['elapsed']??"",
      extra: json['extra']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'elapsed': elapsed,
      'extra': extra,
    };
  }
}

class Assist {
  String? name;
  String? id;
  String? shirtnumber;

  Assist({this.name, this.id, this.shirtnumber});

  factory Assist.fromJson(Map<String, dynamic> json) {
    return Assist(
      name: json['name']??"",
      id: json['id']??"",
      shirtnumber: json['shirtnumber']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'shirtnumber': shirtnumber,
    };
  }
}

class Bench {
  String eventId;
  String code;
  String name;
  String person;
  String personId;
  String owPersonId;
  String teamId;
  String owTeamId;
  String minute;
  String? minuteExtra;
  String shirtnumber;
  String lastUpdated;
  PersonNumber? personNumber;
  List<Event> event;

  Bench({
    required this.eventId,
    required this.code,
    required this.name,
    required this.person,
    required this.personId,
    required this.owPersonId,
    required this.teamId,
    required this.owTeamId,
    required this.minute,
    this.minuteExtra,
    required this.shirtnumber,
    required this.lastUpdated,
    this.personNumber, // Make nullable
    required this.event,
  });

  factory Bench.fromJson(Map<String, dynamic> json) {
    return Bench(
      eventId: json['event_id'] ?? "",
      code: json['code'] ?? "",
      name: json['name'] ?? "",
      person: json['person'] ?? "",
      personId: json['person_id'] ?? "",
      owPersonId: json['ow_person_id'] ?? "",
      teamId: json['team_id'] ?? "",
      owTeamId: json['ow_team_id'] ?? "",
      minute: json['minute'] ?? "",
      minuteExtra: json['minute_extra'] ?? "",
      shirtnumber: json['shirtnumber'] ?? "",
      lastUpdated: json['last_updated'] ?? "",
      personNumber: json['person_number'] != null ? PersonNumber.fromJson(json['person_number']) : null,
      event: (json['events'] as List<dynamic>?)?.map((item) => Event.fromJson(item)).toList() ?? [], // Handle nullable events list
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'code': code,
      'name': name,
      'person': person,
      'person_id': personId,
      'ow_person_id': owPersonId,
      'team_id': teamId,
      'ow_team_id': owTeamId,
      'minute': minute,
      'minute_extra': minuteExtra,
      'shirtnumber': shirtnumber,
      'last_updated': lastUpdated,
      'person_number': personNumber?.toJson(), // Handle nullable personNumber
      'events': event.map((item) => item.toJson()).toList(),
    };
  }
}


class PersonNumber {
  String eventId;
  String code;
  String name;
  String person;
  String personId;
  String owPersonId;
  String teamId;
  String owTeamId;
  String minute;
  String? minuteExtra;
  String shirtnumber;
  String lastUpdated;

  PersonNumber({
    required this.eventId,
    required this.code,
    required this.name,
    required this.person,
    required this.personId,
    required this.owPersonId,
    required this.teamId,
    required this.owTeamId,
    required this.minute,
    this.minuteExtra,
    required this.shirtnumber,
    required this.lastUpdated,
  });

  factory PersonNumber.fromJson(Map<String, dynamic> json) {
    return PersonNumber(
      eventId: json['event_id']??"",
      code: json['code']??"",
      name: json['name']??"",
      person: json['person']??"",
      personId: json['person_id']??"",
      owPersonId: json['ow_person_id']??"",
      teamId: json['team_id']??"",
      owTeamId: json['ow_team_id']??"",
      minute: json['minute']??"",
      minuteExtra: json['minute_extra']??"",
      shirtnumber: json['shirtnumber']??"",
      lastUpdated: json['last_updated']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'code': code,
      'name': name,
      'person': person,
      'person_id': personId,
      'ow_person_id': owPersonId,
      'team_id': teamId,
      'ow_team_id': owTeamId,
      'minute': minute,
      'minute_extra': minuteExtra,
      'shirtnumber': shirtnumber,
      'last_updated': lastUpdated,
    };
  }
}

