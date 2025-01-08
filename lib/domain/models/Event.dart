class EventModel {
  final Time time;
  final Team team;
  final Player player;
  final Assist assist;
  final String type;
  final String detail;
  final String? comments;

  EventModel({
    required this.time,
    required this.team,
    required this.player,
    required this.assist,
    required this.type,
    required this.detail,
    this.comments,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      time: Time.fromJson(json['time'] ?? {}),
      team: Team.fromJson(json['team'] ?? {}),
      player: Player.fromJson(json['player'] ?? {}),
      assist: Assist.fromJson(json['assist'] ?? {}),
      type: json['type'] ?? '',
      detail: json['detail'] ?? '',
      comments: json['comments'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time.toJson(),
      'team': team.toJson(),
      'player': player.toJson(),
      'assist': assist.toJson(),
      'type': type,
      'detail': detail,
      'comments': comments,
    };
  }

  static List<EventModel> listFromJson(List jsonData) {
    return jsonData.map((e) => EventModel.fromJson(e)).toList();
  }
}

class Time {
  final String elapsed;
  final String? extra;

  Time({
    required this.elapsed,
    this.extra,
  });

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      elapsed: json['elapsed'] ?? '',
      extra: json['extra'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'elapsed': elapsed,
      'extra': extra,
    };
  }
}

class Team {
  final String id;
  final String? name;
  final String logo;

  Team({
    required this.id,
    this.name,
    required this.logo,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'] ?? '',
      name: json['name'],
      logo: json['logo'] ?? '',
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

class Player {
  final String id;
  final String name;
  final String shirtnumber;

  Player({
    required this.id,
    required this.name,
    required this.shirtnumber,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      shirtnumber: json['shirtnumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shirtnumber': shirtnumber,
    };
  }
}

class Assist {
  final String? name;
  final String? id;

  Assist({
    this.name,
    this.id,
  });

  factory Assist.fromJson(Map<String, dynamic> json) {
    return Assist(
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }
}
