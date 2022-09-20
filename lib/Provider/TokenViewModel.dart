import 'dart:convert';
import 'dart:io';

import 'package:arseli/Models/token.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class TokenViewModel with ChangeNotifier {
  Future<http.Response> sendToken(Token token) async {
    Map<String, String> data = {
      'id': token.id,
      'DeviceName': token.deviceName,
      'AppVersion': token.appVersion,
      'DeviceType': token.deviceType,
      'DeviceModel': token.deviceModel,
      'SystemVersion': token.systemVersion,
      'defaultLocale': token.defaultLocale,
      'TimeZone': token.timeZone,
      'OneSignalToken': token.oneSignalToken
    };

    return http.post(
        Uri.parse('http://mobile.eplworld.com:5678/webhook/device'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Basic TW9iaWxlQXBwOjVkb2F5ZXloZm56bHo1ZWM3YXhiOWxzMGs=',
          "Content-Type": "application/json"
        },
        body: json.encode(data));
  }
}
