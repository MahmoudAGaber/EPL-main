class PlayerTransfer {
  final String personId;
  final String name;
  final String type;
  final String position;
  final String nationalityId;
  final String owPersonId;
  final List<Membership> membership;

  PlayerTransfer({
    required this.personId,
    required this.name,
    required this.type,
    required this.position,
    required this.nationalityId,
    required this.owPersonId,
    required this.membership,
  });

  factory PlayerTransfer.fromJson(Map<String, dynamic> json) {
    return PlayerTransfer(
      personId: json["person_id"],
      name: json["name"],
      type: json["type"],
      position: json["position"],
      nationalityId: json["nationality_id"],
      owPersonId: json["ow_person_id"],
      membership: json['membership'] is List
      ? (json["membership"] as List).map((e) => Membership.fromJson(e)).toList()
          : [json["membership"]].map((e) => Membership.fromJson(e)).toList() ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "person_id": personId,
      "name": name,
      "type": type,
      "position": position,
      "nationality_id": nationalityId,
      "ow_person_id": owPersonId,
      "membership": membership.map((e) => e.toJson()).toList(),
    };
  }

  static List<PlayerTransfer> listFromJson(List jsonData){
    return jsonData.map((e)=> PlayerTransfer.fromJson(e)).toList();
  }
}

class Membership {
  final String teamPeopleId;
  final String teamId;
  final String clubName;
  final String active;
  final String startDate;
  final String endDate;
  final String owTeamId;
  final Transfer transfer;

  Membership({
    required this.teamPeopleId,
    required this.teamId,
    required this.clubName,
    required this.active,
    required this.startDate,
    required this.endDate,
    required this.owTeamId,
    required this.transfer,
  });

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
      teamPeopleId: json["team_people_id"],
      teamId: json["team_id"],
      clubName: json["club_name"],
      active: json["active"],
      startDate: json["start_date"],
      endDate: json["end_date"],
      owTeamId: json["ow_team_id"],
      transfer: Transfer.fromJson(json["transfer"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "team_people_id": teamPeopleId,
      "team_id": teamId,
      "club_name": clubName,
      "active": active,
      "start_date": startDate,
      "end_date": endDate,
      "ow_team_id": owTeamId,
      "transfer": transfer.toJson(),
    };
  }
}

class Transfer {
  final String type;
  final String value;
  final String currency;
  final String announcedDate;
  final String fromTeamId;
  final String fromClubName;
  final String owFromTeamId;

  Transfer({
    required this.type,
    required this.value,
    required this.currency,
    required this.announcedDate,
    required this.fromTeamId,
    required this.fromClubName,
    required this.owFromTeamId,
  });

  factory Transfer.fromJson(Map<String, dynamic> json) {
    return Transfer(
      type: json["type"],
      value: json["value"],
      currency: json["currency"],
      announcedDate: json["announced_date"],
      fromTeamId: json["from_team_id"],
      fromClubName: json["from_club_name"],
      owFromTeamId: json["ow_from_team_id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "value": value,
      "currency": currency,
      "announced_date": announcedDate,
      "from_team_id": fromTeamId,
      "from_club_name": fromClubName,
      "ow_from_team_id": owFromTeamId,
    };
  }
}
