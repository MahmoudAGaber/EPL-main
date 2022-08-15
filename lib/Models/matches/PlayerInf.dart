/// playerId : "QlDYd8"
/// firstName : "خوسي أنتونيو"
/// lastName : "ديلغادو فيار"
/// shortFirstName : "José Antonio"
/// shortLastName : "Delgado Villar"
/// knownName : "Nono"
/// matchName : "نونو"
/// shirtNumber : 6
/// position : "وسط"
/// positionSide : "Left/Centre"
/// formationPlace : "10"
/// statAPI : [{"title":"توزيع","attr":[{"key":"تمريرات","value":"24"}]},{"title":"هجوم","attr":[{"key":"تمريرات","value":"24"},{"key":"تسديدات","value":"1"},{"key":"تسديدات على المرمى","value":"1"},{"key":"تسديدات داخل المنطقة","value":"1"}]}]
/// positionEn : "Centre"
/// image : "/img/players/150/QlDYd8.png"
/// nameEn : "Nono"
/// url : "/player/QlDYd8"

class PlayerInf {
  PlayerInf({
      String playerId, 
      String firstName, 
      String lastName, 
      String shortFirstName, 
      String shortLastName, 
      String knownName, 
      String matchName, 
      int shirtNumber, 
      String position, 
      String positionSide, 
      String formationPlace, 
      List<StatApi> statAPI, 
      String positionEn, 
      String image, 
      String nameEn, 
      String url,}){
    _playerId = playerId;
    _firstName = firstName;
    _lastName = lastName;
    _shortFirstName = shortFirstName;
    _shortLastName = shortLastName;
    _knownName = knownName;
    _matchName = matchName;
    _shirtNumber = shirtNumber;
    _position = position;
    _positionSide = positionSide;
    _formationPlace = formationPlace;
    _statAPI = statAPI;
    _positionEn = positionEn;
    _image = image;
    _nameEn = nameEn;
    _url = url;
}

  PlayerInf.fromJson(dynamic json) {
    _playerId = json['playerId'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _shortFirstName = json['shortFirstName'];
    _shortLastName = json['shortLastName'];
    _knownName = json['knownName'];
    _matchName = json['matchName'];
    _shirtNumber = json['shirtNumber'];
    _position = json['position'];
    _positionSide = json['positionSide'];
    _formationPlace = json['formationPlace'];
    if (json['statAPI'] != null) {
      _statAPI = [];
      json['statAPI'].forEach((v) {
        _statAPI.add(StatApi.fromJson(v));
      });
    }
    _positionEn = json['positionEn'];
    _image = json['image'];
    _nameEn = json['nameEn'];
    _url = json['url'];
  }
  String _playerId;
  String _firstName;
  String _lastName;
  String _shortFirstName;
  String _shortLastName;
  String _knownName;
  String _matchName;
  int _shirtNumber;
  String _position;
  String _positionSide;
  String _formationPlace;
  List<StatApi> _statAPI;
  String _positionEn;
  String _image;
  String _nameEn;
  String _url;
PlayerInf copyWith({  String playerId,
  String firstName,
  String lastName,
  String shortFirstName,
  String shortLastName,
  String knownName,
  String matchName,
  int shirtNumber,
  String position,
  String positionSide,
  String formationPlace,
  List<StatApi> statAPI,
  String positionEn,
  String image,
  String nameEn,
  String url,
}) => PlayerInf(  playerId: playerId ?? _playerId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  shortFirstName: shortFirstName ?? _shortFirstName,
  shortLastName: shortLastName ?? _shortLastName,
  knownName: knownName ?? _knownName,
  matchName: matchName ?? _matchName,
  shirtNumber: shirtNumber ?? _shirtNumber,
  position: position ?? _position,
  positionSide: positionSide ?? _positionSide,
  formationPlace: formationPlace ?? _formationPlace,
  statAPI: statAPI ?? _statAPI,
  positionEn: positionEn ?? _positionEn,
  image: image ?? _image,
  nameEn: nameEn ?? _nameEn,
  url: url ?? _url,
);
  String get playerId => _playerId;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get shortFirstName => _shortFirstName;
  String get shortLastName => _shortLastName;
  String get knownName => _knownName;
  String get matchName => _matchName;
  int get shirtNumber => _shirtNumber;
  String get position => _position;
  String get positionSide => _positionSide;
  String get formationPlace => _formationPlace;
  List<StatApi> get statAPI => _statAPI;
  String get positionEn => _positionEn;
  String get image => _image;
  String get nameEn => _nameEn;
  String get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['playerId'] = _playerId;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['shortFirstName'] = _shortFirstName;
    map['shortLastName'] = _shortLastName;
    map['knownName'] = _knownName;
    map['matchName'] = _matchName;
    map['shirtNumber'] = _shirtNumber;
    map['position'] = _position;
    map['positionSide'] = _positionSide;
    map['formationPlace'] = _formationPlace;
    if (_statAPI != null) {
      map['statAPI'] = _statAPI.map((v) => v.toJson()).toList();
    }
    map['positionEn'] = _positionEn;
    map['image'] = _image;
    map['nameEn'] = _nameEn;
    map['url'] = _url;
    return map;
  }

}

/// title : "توزيع"
/// attr : [{"key":"تمريرات","value":"24"}]

class StatApi {
  StatApi({
      String title, 
      List<Attr> attr,}){
    _title = title;
    _attr = attr;
}

  StatApi.fromJson(dynamic json) {
    _title = json['title'];
    if (json['attr'] != null) {
      _attr = [];
      json['attr'].forEach((v) {
        _attr.add(Attr.fromJson(v));
      });
    }
  }
  String _title;
  List<Attr> _attr;
StatApi copyWith({  String title,
  List<Attr> attr,
}) => StatApi(  title: title ?? _title,
  attr: attr ?? _attr,
);
  String get title => _title;
  List<Attr> get attr => _attr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    if (_attr != null) {
      map['attr'] = _attr.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// key : "تمريرات"
/// value : "24"

class Attr {
  Attr({
      String key, 
      String value,}){
    _key = key;
    _value = value;
}

  Attr.fromJson(dynamic json) {
    _key = json['key'];
    _value = json['value'];
  }
  String _key;
  String _value;
Attr copyWith({  String key,
  String value,
}) => Attr(  key: key ?? _key,
  value: value ?? _value,
);
  String get key => _key;
  String get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = _key;
    map['value'] = _value;
    return map;
  }

}