import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../competations/provider/CompetitionViewModel.dart';
import '../../news/provider/NewsViewModel.dart';
import '../../videos/provider/VideosViewModel.dart';
import 'home.dart';

class SplashScreen extends ConsumerStatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  static final String oneSignalAppId = '141280ca-d653-4400-a580-0064de00194e';
  String oneSignalUserId='';
  // Future<Void>? initPlatformState() async {
  //   OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  //   OneSignal.shared.setAppId(oneSignalAppId);
  //   final status = await OneSignal.shared.getDeviceState();
  //   final String osUserID = status?.userId;
  //   oneSignalUserId=osUserID;
  //   await OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);
  //   OneSignal.shared.promptLocationPermission().then((dynamic accepted) {
  //     print('Accepted permission: $accepted ');
  //   });
  // }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(TopCompetitionProvider.notifier).getTopCompetition();
      ref.read(CompetitionProvider.notifier).getCompetition();
      ref.read(videosProvider.notifier).getVideos(1);
      ref.read(newsProvider.notifier).getNews(1);

    });
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home(index: 0,dateTime: DateTime.now(),)));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Container(
                height: MediaQuery.of(context).size.height * .45,
                width: MediaQuery.of(context).size.width * .45,
                child: Image.asset(
                  'assets/EPL-Logo.png',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
