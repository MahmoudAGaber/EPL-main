import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:arseli/Models/token.dart';
import 'package:arseli/Provider/TokenViewModel.dart';
import 'package:arseli/main.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static final String oneSignalAppId = '141280ca-d653-4400-a580-0064de00194e';
  Future<Void> initPlatformState() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId(oneSignalAppId);
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
    OneSignal.shared.promptLocationPermission().then((dynamic accepted) {
      print('Accepted permission: $accepted ');
    });
  }

  @override
  void initState() {
    getToken();

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification notification = message.notification;
    //   AndroidNotification android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //       notification.hashCode,
    //       notification.title,
    //       notification.body,
    //       NotificationDetails(
    //         android: AndroidNotificationDetails(
    //           channel.id,
    //           channel.name,
    //           channel.description,
    //           color: Colors.blue,
    //           playSound: true,
    //           icon: '@mipmap/ic_launcher',
    //         ),
    //       ),
    //     );
    //   }
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('A new onMessageOpenedApp event');
    //   RemoteNotification notification = message.notification;
    //   AndroidNotification android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     showDialog(
    //         context: context,
    //         builder: (_) {
    //           return AlertDialog(
    //             title: Text(notification.title),
    //             content: SingleChildScrollView(
    //                 child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(notification.body),
    //               ],
    //             )),
    //           );
    //         });
    //   }
    // });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => home()));
    });
    initPlatformState();
    super.initState();
  }

  Token token = Token();
  final String defaultLocale = Platform.localeName;
  getToken() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      token.id = androidInfo.id;
      token.deviceName = androidInfo.device;
      token.appVersion = androidInfo.version.release;
      token.deviceType = "Android";
      token.deviceModel = androidInfo.model;
      token.systemVersion = Platform.operatingSystemVersion;
      token.defaultLocale = defaultLocale;
      token.timeZone = DateTime.now().timeZoneName;
      token.oneSignalToken = "";

      if (token.id != null) {
        saveToken(token);
      }
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

      token.id = iosInfo.identifierForVendor;
      token.deviceName = iosInfo.name;
      token.appVersion = iosInfo.systemVersion;
      token.deviceType = "IOS";
      token.deviceModel = iosInfo.model;
      token.systemVersion = Platform.operatingSystemVersion;
      token.defaultLocale = defaultLocale;
      token.timeZone = DateTime.now().timeZoneName;
      token.oneSignalToken = "";
      if (token.id != null) {
        saveToken(token);
      }
    }
  }

  saveToken(Token token) async {
    var prefs = await SharedPreferences.getInstance();
    var userPref = prefs.setString("DeviceID", token.id);
    var res = await Provider.of<TokenViewModel>(context, listen: false)
        .sendToken(token);
  }

  void ShowNotification() {
    flutterLocalNotificationsPlugin.show(
      0,
      'Testing s',
      'How you doin ?',
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
          importance: Importance.high,
          color: Colors.blue,
          playSound: true,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * .45,
              width: MediaQuery.of(context).size.width * .45,
              child: Image.asset(
                'assets/EPL-Logo.png',
              ),
            ),
          ),
          //CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,)
        ],
      ),
    );
  }
}
