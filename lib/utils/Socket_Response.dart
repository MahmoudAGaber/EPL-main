/// ID : "Jgk5wR"
/// Home : 3
/// Away : 1
/// Status : "Played"
/// Time : null
/// Period : 14

class SocketResponse {
  SocketResponse({
      String id, 
      int home, 
      int away, 
      String status, 
      dynamic time, 
      int period,}){
    _id = id;
    _home = home;
    _away = away;
    _status = status;
    _time = time;
    _period = period;
}

  SocketResponse.fromJson(dynamic json) {
    _id = json['ID'];
    _home = json['Home'];
    _away = json['Away'];
    _status = json['Status'];
    _time = json['Time'];
    _period = json['Period'];
  }
  String _id;
  int _home;
  int _away;
  String _status;
  dynamic _time;
  int _period;

  String get id => _id;
  int get home => _home;
  int get away => _away;
  String get status => _status;
  dynamic get time => _time;
  int get period => _period;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['Home'] = _home;
    map['Away'] = _away;
    map['Status'] = _status;
    map['Time'] = _time;
    map['Period'] = _period;
    return map;
  }

}