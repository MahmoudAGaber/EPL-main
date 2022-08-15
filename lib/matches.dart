import 'dart:async';
import 'dart:io';

import 'package:arseli/EachTeam/eachTeam.dart';
import 'package:arseli/Matches/MatchesDate/TodayMatch.dart';
import 'package:arseli/More.dart';
import 'package:arseli/Provider/EachPlayerViewModel.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:arseli/Provider/SearchViewModel.dart';
import 'package:arseli/webView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'EachLeague/eachLeague.dart';
import 'Playrers/players.dart';
import 'Provider/MatchesViewModel.dart';
import 'Provider/EachLeagueViewModel.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home.dart';

class Matches extends StatefulWidget {
  DateTime dateTime;
  Matches({this.dateTime});
  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> with SingleTickerProviderStateMixin {
  MatchesViewModel matchesViewModel;

  TextStyle tapbar =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white);
  TextStyle headline = TextStyle(fontSize: 15, fontWeight: FontWeight.w400);
  TextStyle content = TextStyle(
    fontSize: 14,
  );
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Creat

  bool isSwitched = false;
  bool liveMatches = false;
  bool selected = false;

  TabController tabController;
  ScrollController scrollViewColtroller;

  DateTime dateScheduale;
  var today = '';
  var yesterday = '';
  var oneDayAgo = '';
  var twoDaysAgo = '';
  var tomorrow = '';
  var oneDayThen = '';
  var twoDaysThen = '';
  var threeDayThen = '';
  var fourDayThen = '';
  var fiveDayThen = '';

  var todayD = '';
  var yesterdayD = '';
  var oneDayAgoD = '';
  var twoDaysAgoD = '';
  var tomorrowD = '';
  var oneDayThenD = '';
  var twoDaysThenD = '';
  var threeDayThenD = '';
  var fourDayThenD = '';
  var fiveDayThenD = '';

  List<String> tabView=[];
  List<String> tabName=[];

  SearchViewModel searchViewModel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      searchViewModel = Provider.of(context, listen: false);
      matchesViewModel = Provider.of(context, listen: false);
      searchViewModel.getDataSearch('1');

      initDate();
      tabController = new TabController(length: 10, vsync: this);

      tabController.animateTo(3,
          duration: Duration(milliseconds: 100), curve: Curves.fastOutSlowIn);
    });
  }


  @override
  void dispose() {
    // tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.0,
          centerTitle: false,
          title: Transform(
            transform:  Matrix4.translationValues(-125.0, 0.0, 0.0),
            child: Container(
              child: Text(
                'EPL WORLD',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          leadingWidth: 150,
          leading: SizedBox(
            width: 200,
            height: 200,
            child: Consumer<MatchesViewModel>(
                builder: (context, provider, child) {
                  return Row(
                    children: <Widget>[
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.menu,
                          size: 28,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.search,
                          size: 28,
                          color: Colors.white,
                        ),
                        onPressed: () {
                        },
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.calendar_today,
                          size: 22,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/clanderbar');
                        },
                      ),


                    ],
                  );
                },
              ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          bottom: tabController == null
              ? PreferredSize(
                  preferredSize: Size.fromHeight(50), child: Container())
              : TabBar(
                  isScrollable: true,
                  controller: tabController,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  labelStyle: tapbar,
                  tabs: List.generate(10, (index){
                    return Tab(
                        child: Text(
                        tabName[index].tr,
                        style: tapbar,
                    ));
                  })
                ),
        ),
        backgroundColor: Colors.grey[200],

        drawer: Drawer(
          child: More(),
        ),


        body: tabController == null
            ? Container()
            : TabBarView(controller: tabController, children:
            List.generate(10, (index){
              return ChangeNotifierProvider<MatchesViewModel>(
                  create: (_) => MatchesViewModel(),
                  child: TodayMatches(
                    date: tabView[index],
                  ));
            })
              ));

  }

  initDate(){
    setState(() {
      initializeDateFormatting("AR_SA", null).then((_) {
        DateTime now = new DateTime.now();
        var timeNow =  DateFormat.MMMEd('AR_SA').format(DateTime.now());
        // DateFormat.MMMEd('AR_SA').format(widget.dateTime??now);
        widget.dateTime == null?  now = new DateTime.now(): now = widget.dateTime;

        today = DateFormat.MMMEd('AR_SA').format(now.subtract(new Duration(days: 0)));
        yesterday = DateFormat.MMMEd('AR_SA').format(now.subtract(new Duration(days: 1)));
        oneDayAgo = DateFormat('E d','AR_SA').format(now.subtract(new Duration(days: 2)));
        twoDaysAgo = DateFormat('E d','AR_SA').format(now.subtract(new Duration(days: 3)));
        tomorrow = DateFormat.MMMEd('AR_SA').format(now.add(new Duration(days: 1)));
        oneDayThen = DateFormat('E d','AR_SA').format(now.add(new Duration(days: 2)));
        twoDaysThen = DateFormat('E d','AR_SA').format(now.add(new Duration(days: 3)));
        threeDayThen = DateFormat('E d','AR_SA').format(now.add(new Duration(days: 4)));
        fourDayThen = DateFormat('E d','AR_SA').format(now.add(new Duration(days: 5)));
        fiveDayThen = DateFormat('E d','AR_SA').format(now.add(new Duration(days: 6)));

        tabName=[
          twoDaysAgo,
          oneDayAgo,
          timeNow.toString()== DateFormat.MMMEd('AR_SA').format(now).toString()?"امس":yesterday,
          timeNow.toString()== DateFormat.MMMEd('AR_SA').format(now).toString()?"اليوم":today,
          timeNow.toString()== DateFormat.MMMEd('AR_SA').format(now).toString()?"غدا":tomorrow,
          oneDayThen,
          twoDaysThen,
          threeDayThen,
          fourDayThen,
          fiveDayThen
        ];
      });
    });

    setState(() {
      initializeDateFormatting("EN_SA", null).then((_) {
        var now = new DateTime.now();
        widget.dateTime == null?  now = new DateTime.now(): now = widget.dateTime;

        todayD = DateFormat("dd-MM-yyyy", 'EN_SA').format(now.subtract(new Duration(days: 0)));
        yesterdayD = DateFormat("dd-MM-yyyy", 'EN_SA').format(now.subtract(new Duration(days: 1)));
        oneDayAgoD = DateFormat("dd-MM-yyyy", 'EN_SA').format(now.subtract(new Duration(days: 2)));
        twoDaysAgoD = DateFormat("dd-MM-yyyy", 'EN_SA').format(now.subtract(new Duration(days: 3)));
        tomorrowD = DateFormat("dd-MM-yyyy", 'EN_SA').format(now.add(new Duration(days: 1)));
        oneDayThenD = DateFormat("dd-MM-yyyy", 'EN_SA').format(now.add(new Duration(days: 2)));
        twoDaysThenD = DateFormat("dd-MM-yyyy", 'EN_SA').format(now.add(new Duration(days: 3)));
        threeDayThenD = DateFormat("dd-MM-yyyy", 'EN_SA').format(now.add(new Duration(days: 4)));
        fourDayThenD = DateFormat("dd-MM-yyyy", 'EN_SA').format(now.add(new Duration(days: 5)));
        fiveDayThenD = DateFormat("dd-MM-yyyy", 'EN_SA').format(now.add(new Duration(days: 6)));

        tabView=[
          twoDaysAgoD,
          oneDayAgoD,
          yesterdayD,
          todayD,
          tomorrowD,
          oneDayThenD,
          twoDaysThenD,
          threeDayThenD,
          fourDayThenD,
          fiveDayThenD
        ];
      });
    });
  }
}
