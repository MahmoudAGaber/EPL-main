class MatchesCheckNoti{
  bool goal;
  bool missedPenalty;
  bool started;
  bool halfTimeBreak;
  bool endMatch;
  bool redCard;
  bool plan;
  bool gameReminder;

  MatchesCheckNoti(
      {this.goal,
      this.missedPenalty,
      this.started,
      this.halfTimeBreak,
      this.endMatch,
      this.redCard,
      this.plan,
      this.gameReminder});

  Map<String ,dynamic> toMap(){
    return {
      'goal':goal,
      'missedPenalty':missedPenalty,
      'started':started,
      'halfTimeBreak':halfTimeBreak,
      'endMatch':endMatch,
      'redCard':redCard,
      'plan':plan,
      'gameReminder':gameReminder


    };
  }

  factory MatchesCheckNoti.json(Map json){
    return MatchesCheckNoti(
      goal: json['json'],
      missedPenalty: json['missedPenalty'],
      started: json['started'],
      halfTimeBreak: json['halfTimeBreak'],
      endMatch: json['endMatch'],
      redCard: json['redCard'],
      plan: json['plan'],
      gameReminder: json['gameReminder'],

    );
  }


}