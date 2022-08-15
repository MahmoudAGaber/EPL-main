import 'package:arseli/Provider/EachMatchViewModel.dart';
import 'package:arseli/Provider/LeaguesViewModel.dart';
import 'package:arseli/Provider/MatchesViewModel.dart';
import 'package:arseli/Provider/EachLeagueViewModel.dart';
import 'package:arseli/Provider/SearchViewModel.dart';
import 'package:arseli/setting.dart';
import 'package:arseli/tv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'EachLeague/eachLeague.dart';
import 'EachTeam/VideoTeam.dart';
import 'EachTeam/allDeatails.dart';
import 'EachTeam/eachTeam.dart';
import 'EachTeam/teamNews.dart';
import 'EachTeam/teamTeam.dart';
import 'Matches/EndMatches/matchEvent_a.dart';
import 'Matches/matchInfo.dart';
import 'Matches/EndMatches/matchInfo_a.dart';
import 'More.dart';
import 'News/transferCenter.dart';
import 'Playrers/players.dart';
import 'Provider/VideosViewModel.dart';
import 'Reels.dart';
import 'SplashScreen.dart';
import 'webView.dart';
import 'Provider/NewsViewModel.dart';
import 'clanderbar.dart';
import 'lang/LocalizationService.dart';
import 'package:provider/provider.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Channel',
  'des',
  importance: Importance.high,
  playSound: true,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
// Future<void> _firebaseMassgingBackgrundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('A bg message just showed upL ${message.messageId}');
// }

Widget NoData() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 150,
        width: 150,
        child: Image.asset("assets/EPL-Logo.png"),
      ),
      Container(
        height: 400,
        child: Text(
          "لا توجد بيانات متوفرة",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    ],
  );
}

Widget NoMatches() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 150,
        width: 150,
        child: Image.asset("assets/EPL-Logo.png"),
      ),
      Container(
        height: 400,
        child: Text(
          "لا توجد مباريات اليوم",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    ],
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();
  // var token = FirebaseMessaging.instance.getToken();
  // print(token);
  // FirebaseMessaging.onMessage.listen((event) {
  //   print(event.data.toString());
  // });
  // FirebaseMessaging.onBackgroundMessage(_firebaseMassgingBackgrundHandler);
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //     alert: true, badge: true, sound: true);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EachLeagueViewModel()),
        ChangeNotifierProvider(create: (_) => MatchesViewModel()),
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
        ChangeNotifierProvider(create: (_) => EachMatchViewModel()),
        ChangeNotifierProvider(create: (_) => LeaguesViewModel()),
        ChangeNotifierProvider(create: (_) => NewsViewModel()),
        ChangeNotifierProvider(create: (_) => VideosViewModel()),
        ChangeNotifierProvider(create: (_) => VideosProvider()),
      ],
      child: MyApp(),
    ),
  );
}

ThemeData _themeDataDark = ThemeData(
  primaryColor: Colors.white,
  accentColor: Colors.white,
  brightness: Brightness.dark,
  indicatorColor: Colors.yellow,
  fontFamily: 'DroidKufi',
);

ThemeData _themeDatalight = ThemeData(
  primaryColor: Colors.white,
  primarySwatch: Colors.white,
  accentColor: Colors.black,
  brightness: Brightness.light,
  indicatorColor: Colors.yellow,
  fontFamily: 'Tajawal',
);
bool _light = true;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        locale: LocalizationService.locale,
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: LocalizationService(),
        theme: ThemeData(
          primaryColor: Color.fromRGBO(95, 31, 117, 1.0),
          primarySwatch: Colors.grey,
        ),
        //title: ' EPLWORLD',
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          "/matchInfo": (BuildContext context) => new matchInfo(),
          "/matchInfo_a": (BuildContext context) => new matchInfo_a(),
          "/eachLeague": (BuildContext context) => new EachLeague(),
          "/eachTeam": (BuildContext context) => new EachTeam(),
          "/players": (BuildContext context) => new EachPlayer(),
          "/transferCenter": (BuildContext context) => new transferCenter(),
          "/clanderbar": (BuildContext context) => new clanderbar(),
          "/tv": (BuildContext context) => new tv(),
          "/matchEvent_a": (BuildContext context) => new MatchEvent_a(),
          "/setting": (BuildContext context) => new setting(),
          "/teamNews": (BuildContext context) => new TeamNews(),
          "/VideoTeam": (BuildContext context) => new VideoTeam(),
          "/teamTeam": (BuildContext context) => new teamTeam(),
          "/More": (BuildContext context) => new More(),
          "/allDetails": (BuildContext context) => new allDetaials(),
          "/webView": (BuildContext context) => new webView(),
        });
  }
}
