class Token {
  String id;
  String deviceName;
  String appVersion;
  String deviceType;
  String deviceModel;
  String systemVersion;
  String defaultLocale;
  String timeZone;
  String oneSignalToken;

  Token({
    this.id,
    this.deviceName,
    this.appVersion,
    this.deviceType,
    this.deviceModel,
    this. systemVersion,
    this.defaultLocale,
    this.timeZone,
    this.oneSignalToken,
  });

  Map<String, dynamic> toJson() =>{
    "id": id,
    "deviceName":deviceName,
    "appVersion": appVersion,
    "deviceType": deviceType,
    "deviceModel": deviceModel,
    "systemVersion": systemVersion,
    "defaultLocale": defaultLocale,
    "timeZone": timeZone,
    "oneSignalToken": oneSignalToken,
  };

  factory Token.json(Map json){
    return Token(
      id: json['id'],
      deviceName: json['deviceName'],
      appVersion: json['appVersion'],
      deviceType: json['deviceType'],
      deviceModel: json['deviceModel'],
      systemVersion: json['systemVersion'],
      defaultLocale: json['defaultLocale'],
      timeZone: json['timeZone'],
      oneSignalToken: json['oneSignalToken'],
    );
  }
}
