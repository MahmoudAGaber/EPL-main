
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RequestHandler {
  static const mainUrl = "https://eplworld.com/api/";
  static const mainUrl2 = "http://mobile.eplworld.com:5678/webhook/subs?fbclid=IwAR0e62KHeSh-uaZKhpkO2MjGYBCEPDpo_nB-e2wn6DWn-EZ5VoA5AhrH_R8";


  Future<T>postData<T>({endPoint, String parma = '',
    auth = false,
    required Map<String, dynamic> requestBody,
    required T Function(dynamic json) fromJson}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var request = http.Request('POST', Uri.parse(mainUrl + endPoint + parma))
      ..headers.addAll(auth ? {
        "Authorization": "Bearer ${prefs.get('token')}",
        "Content-Type": "application/json; charset=UTF-8",
        "username": "eplworld",
        "password": "ew1o.d1ewpeepooe1o.l"
      } : {
        "Content-Type": "application/json; charset=UTF-8"
      }) //if
      ..body = jsonEncode(requestBody);
    try {
      final response = await http.Client().send(request);

      final responseBody = await http.Response.fromStream(response);
      final decodedResponse = json.decode(responseBody.body);
      return fromJson(decodedResponse);
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to make the POST request');
    }
  }

  Future<T> getData<T>({
    required String endPoint,
    String param = '',
    bool auth = false,
    required T Function(dynamic json) fromJson,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String url = mainUrl + endPoint + param;

    try {
      http.Response response;

      if (auth) {
        response = await http.get(
          Uri.parse(url),
          headers: {
            "Authorization": "Bearer ${prefs.get('token')}",
            "Content-Type": "application/json; charset=UTF-8"
          },
        );
      } else {
        response = await http.get(Uri.parse(url));
      }
      print(prefs.get('token'));
      if (response.statusCode == 200) {
        dynamic decodedResponse = json.decode(response.body);
        return fromJson(decodedResponse);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to make the GET request');
    }
  }

}