import 'package:arseli/Provider/EachLeagueViewModel.dart';
import 'package:arseli/Provider/EachMatchViewModel.dart';
import 'package:arseli/Provider/LeaguesViewModel.dart';
import 'package:arseli/Provider/MapProvider.dart';
import 'package:arseli/Provider/MatchesViewModel.dart';
import 'package:arseli/Provider/SearchViewModel.dart';
import 'package:arseli/Provider/TokenViewModel.dart';
import 'package:arseli/binding/initial_binding.dart';
import 'package:arseli/config/dio.dart';
import 'package:arseli/injection.dart';
import 'package:arseli/setting.dart';
import 'package:arseli/tv.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'EachLeague/eachLeague.dart';
import 'EachTeam/VideoTeam.dart';
import 'EachTeam/allDeatails.dart';
import 'EachTeam/eachTeam.dart';
import 'EachTeam/teamNews.dart';
import 'EachTeam/teamTeam.dart';
import 'Matches/EndMatches/matchEvent_a.dart';
import 'Matches/EndMatches/matchInfo_a.dart';
import 'Matches/matchInfo.dart';
import 'More.dart';
import 'News/transferCenter.dart';
import 'Playrers/players.dart';
import 'Provider/NewsViewModel.dart';
import 'Provider/ThemeProvider.dart';
import 'Provider/VideosViewModel.dart';
import 'Reels.dart';
import 'SplashScreen.dart';
import 'Themes/Styles.dart';
import 'clanderbar.dart';
import 'lang/LocalizationService.dart';
import 'webView.dart';

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
            fontFamily: 'Vazirmatn',
            fontSize: 22,
          ),
        ),
      ),
    ],
  );
}
Widget NoMatchesPN(context) {
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
          "لا توجد مباريات تلعب الان",
          style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 22)
          ),
        ),
    ],
  );
}
Widget NoData2(context) {
  return Scaffold(
    body: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              child: Image.asset("assets/EPL-Logo.png"),
            ),
            Container(
              height: 100,
              child: Text(
                "لا توجد بيانات متوفرة",
                style:Theme.of(context).textTheme.headline2.copyWith(fontSize: 22
                ),
              ),
            ),
          ],
        ),
      ],
    ),
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
            fontFamily: 'Vazirmatn',
            fontSize: 22,
          ),
        ),
      ),
    ],
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ConfiguredDio(), permanent: true);

  await Injection.setup();
  runApp(
    MultiProvider(
      providers: [
       // ChangeNotifierProvider(create: (_) => EachLeagueViewModel()),
        ChangeNotifierProvider(create: (_) => MatchesViewModel()),
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
        ChangeNotifierProvider(create: (_) => EachMatchViewModel()),
        ChangeNotifierProvider(create: (_) => LeaguesViewModel()),
        ChangeNotifierProvider(create: (_) => NewsViewModel()),
        ChangeNotifierProvider(create: (_) => VideosViewModel()),
        ChangeNotifierProvider(create: (_) => VideosProvider()),
        ChangeNotifierProvider(create: (_) => TokenViewModel()),
        ChangeNotifierProvider(create: (_) => DarkThemeProvider()),
        ChangeNotifierProvider(create: (_) => MapProvider()),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  run() async {
    initCancel();
    runOperation();
    Future.delayed(Duration(seconds: 2));
    cancel();
  }

  Future future() async {
    return Future.delayed(Duration(seconds: 5), () {
      print('end');
    });
    print('start');
    await Future.delayed(Duration(seconds: 5));
    print('end');
  }

  CancelableOperation cancelableOperation;

  cancel() {
    cancelableOperation?.cancel();
  }

  initCancel() {
    cancelableOperation =
        CancelableOperation.fromFuture(future(), onCancel: () {
      print('its canceled');
    });
    print('inited');
  }

  Future runOperation() {
    return cancelableOperation.value;
  }

  hello() {
    CancelableCompleter completer = CancelableCompleter(onCancel: () {
      print('onCancel');
    });

    // completer.operation.cancel();  // uncomment this to test cancellation

    completer.complete(future());
    print('isCanceled: ${completer.isCanceled}');
    print('isCompleted: ${completer.isCompleted}');
    // completer.operation.

    completer.operation.cancel();
    completer.operation.value.then((value) => {
          print('then: $value'),
        });
    completer.operation.value.whenComplete(() => {
          print('onDone'),
        });
  }

  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_){
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context,provider,child){
          return GetMaterialApp(
              initialBinding: InitialBinding(),
              debugShowCheckedModeBanner: false,
              locale: LocalizationService.locale,
              fallbackLocale: LocalizationService.fallbackLocale,
              translations: LocalizationService(),
              theme: Styles.themeData(themeChangeProvider.darkTheme, context),
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
        },
      ),
    );
  }
}
