
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epl/presentation/fixture/screens/EndMatches/matchEvent_a.dart';
import 'package:epl/presentation/fixture/screens/EndMatches/matchInfo_a.dart';
import 'package:epl/presentation/fixture/screens/matchInfo.dart';
import 'package:epl/presentation/league/screens/homeLeague.dart';
import 'package:epl/presentation/home/screens/widgets/setting.dart';
import 'package:epl/presentation/home/screens/widgets/tv.dart';
import 'package:epl/presentation/news/screens/transferCenter.dart';
import 'package:epl/shared/Themes/Styles.dart';
import 'package:epl/shared/Utils/Themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'presentation/home/screens/widgets/More.dart';
import 'presentation/home/screens/SplashScreen.dart';
import 'presentation/home/screens/widgets/clanderbar.dart';
import 'lang/LocalizationService.dart';
import 'presentation/playrers/screens/playerHome.dart';
import 'presentation/team/screens/teamHome.dart';
import 'presentation/team/screens/teamNews.dart';
import 'presentation/team/screens/teamSquad.dart';
import 'presentation/team/screens/teamViedos.dart';
import 'presentation/team/screens/allDeatails.dart';

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel',
//   'High Importance Channel',
//   'des',
//   importance: Importance.high,
//   playSound: true,
// );
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
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
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 22)
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
                style:Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 22
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
  FlutterError.onError = (FlutterErrorDetails details) {
    if (details.exceptionAsString().contains('_ClientSocketException')) {
      // Suppress _ClientSocketException logs
      return;
    }
    FlutterError.dumpErrorToConsole(details);
  };
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);


  runApp(
    ProviderScope(
        child: MyApp()),
  );
}


class MyApp extends ConsumerStatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  run() async {}




  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var darkMode = ref.watch(darkModeProvider);
    return GetMaterialApp(

             // initialBinding: InitialBinding(),
              debugShowCheckedModeBanner: false,
              locale: LocalizationService.locale,
              fallbackLocale: LocalizationService.fallbackLocale,
              translations: LocalizationService(),
              theme:darkMode ? Styles.DarkThemeStyle : Styles.LightThemeStyle,

        //title: ' EPLWORLD',
              home: SplashScreen(),
              routes: <String, WidgetBuilder>{
                "/matchInfo": (BuildContext context) =>  MatchInfo(),
               // "/matchInfo_a": (BuildContext context) =>  matchInfo_a(),
                "/eachLeague": (BuildContext context) =>  LeagueHome(),
                "/eachTeam": (BuildContext context) =>  HomeTeam(),
                "/players": (BuildContext context) =>  Players(),
                "/transferCenter": (BuildContext context) => transferCenter(),
                "/clanderbar": (BuildContext context) =>  clanderbar(),
                "/tv": (BuildContext context) =>  tv(),
               // "/matchEvent_a": (BuildContext context) =>  MatchEvent_a(),
                "/setting": (BuildContext context) =>  setting(),
                "/teamNews": (BuildContext context) =>  TeamNews(),
                "/VideoTeam": (BuildContext context) =>  VideoTeam(),
                "/teamTeam": (BuildContext context) =>  TeamSquad(),
                "/More": (BuildContext context) =>  More(),
                "/allDetails": (BuildContext context) =>  allDetaials(),
                //"/webView": (BuildContext context) => new webView(),
              });
  }
}
