import 'dart:convert';
import 'dart:ui';

import 'package:arseli/EachTeam/eachTeam.dart';
import 'package:arseli/Matches/MatchGPosition.dart';
import 'package:arseli/Matches/MatchPostion.dart';
import 'package:arseli/Matches/preConfron.dart';
import 'package:arseli/Models/MatchesList.dart';
import 'package:arseli/Models/matchesNoti.dart';
import 'package:arseli/Models/token.dart';
import 'package:arseli/Provider/EachMatchViewModel.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:arseli/Provider/MapProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MatchEvent.dart';
import 'PlayerInjured.dart';

class matchInfo extends StatefulWidget {
  String homeId;
  String awayId;
  String url;
  String comName;
  String matchId;

  matchInfo({this.url, this.homeId, this.awayId, this.comName,this.matchId});

  @override
  _matchInfoState createState() => _matchInfoState();
}

class _matchInfoState extends State<matchInfo> with TickerProviderStateMixin {
  static const TextStyle tapbar = TextStyle(
      fontFamily: 'Vazirmatn',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white);
  TextStyle head =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 16, color: Colors.black);

  TabController tabController;
  int _selectedIndex = 0;
  EachMatchViewModel eachMatchViewModel;
  Token token = Token();

  loadData() {
    return Future.wait([
      eachMatchViewModel.getMSN(widget.url, context),
      eachMatchViewModel.getMatchEvent(widget.url),
      eachMatchViewModel.getTables(widget.url),
      eachMatchViewModel.getHTHMatch(widget.url)
    ]);
  }

  List<Widget> tabs;
  List<Widget> tabView;
  MatchesList matchesList;
  MatchesCheckNoti matchesCheckNoti;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      eachMatchViewModel = Provider.of(context, listen: false);
      await loadData();
      //getToken();
      tabController = TabController(
          length: getTabView(eachMatchViewModel).length,
          vsync: this,
          initialIndex: _selectedIndex);
      tabs = getTabs(eachMatchViewModel);
      tabView = getTabView(eachMatchViewModel);
    });

    super.initState();
  }

  List<bool> notifCheak = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  List<String> notficationString = [
    "اعدادت التنبيهات",
    "جميع الاحداث",
    "أهداف",
    "ضربة جزاء ضائعة",
    "بدأت",
    "استراحة ما بين الشوطين",
    "نهايت المبارة",
    "بطاقات حمراء",
    "تشكيلة",
    "تذكير بالمبارة",
  ];

  Map<String, bool> notifState = {
    "Goal": false,
    "Missed penalty": false,
    "Started": false,
    "Halftime break": false,
    "End match": false,
    "Red card": false,
    "Plan": false,
    "Game reminder": false,
  };


  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context,listen: false);
    List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        Directionality(
            textDirection: TextDirection.rtl,
            child: SliverAppBar(
                iconTheme: IconThemeData(color: Colors.white),
                elevation: 0.0,
                actions: <Widget>[
                  Row(
                    children: <Widget>[
                      /*
                      IconButton(
                          icon: Icon(Icons.more_vert, color: Colors.white),
                          onPressed: null),

                       */
                    ],
                  )
                ],
                expandedHeight: 130.0,
                backgroundColor: Theme.of(context).primaryColor,
                pinned: true,
                floating: true,
                snap: true,
                flexibleSpace: Consumer<EachMatchViewModel>(
                    builder: (context, provider, child) {
                  return provider.loadingMsn || provider.loadingEvents
                      ? Center(
                          child: Container(),
                        )
                      : FlexibleSpaceBar(
                          background: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 63, left: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(
                                      Icons.notifications_none,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      showCupertinoModalBottomSheet(
                                          context: context,
                                          builder:
                                              (context) => StatefulBuilder(
                                                      builder: (context, setState) {
                                                    return Container(
                                                      height: MediaQuery.of(context).size.width * 1.3,
                                                      width: MediaQuery.of(context).size.width * double.infinity,
                                                      child: Scaffold(
                                                        backgroundColor: Theme.of(context).backgroundColor,
                                                        body: Container(
                                                          height: MediaQuery.of(context).size.width * 1.3,
                                                          width: MediaQuery.of(context).size.width * double.infinity,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: 10,
                                                                  itemBuilder:(context, ind) {
                                                                    return Column(
                                                                      children: [
                                                                        ind == 0
                                                                            ? Container(
                                                                                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1,  color: Theme.of(context).dividerColor))),
                                                                                width: MediaQuery.of(context).size.width * double.infinity,
                                                                                child: Column(
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(left: 12,right: 12,top: 14,bottom: 14),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Text("${notficationString[ind]}", style:Theme.of(context).textTheme.headline2),
                                                                                          Selector<EachMatchViewModel,bool>(
                                                                                            selector:(context,provider)=>
                                                                                            provider.getNotificationLoading,
                                                                                            builder: (context,loading,child){
                                                                                              return InkWell(
                                                                                                onTap: () {
                                                                                                  matchesList = MatchesList(
                                                                                                    matchId: widget.matchId,
                                                                                                    matchesCheckNoti: MatchesCheckNoti(
                                                                                                      goal: notifCheak[2],
                                                                                                      missedPenalty: notifCheak[3],
                                                                                                      started: notifCheak[4],
                                                                                                      halfTimeBreak: notifCheak[5],
                                                                                                      endMatch: notifCheak[6],
                                                                                                      redCard: notifCheak[7],
                                                                                                      plan: notifCheak[8],
                                                                                                      gameReminder: notifCheak[9],
                                                                                                    )
                                                                                                  );


                                                                                                  mapProvider.dataa.putIfAbsent(widget.matchId, () => matchesList.toMap());

                                                                                                  eachMatchViewModel.matchNoti('', context,mapProvider.dataa);

                                                                                                  Navigator.pop(context);
                                                                                                },
                                                                                                child: Text("حسنًا",
                                                                                                    style: Theme.of(context).textTheme.bodyText1.copyWith(color: Color(0xFFD96BFF,),fontWeight: FontWeight.bold,fontSize: 16)),
                                                                                              );
                                                                                            },

                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            : ind == 1
                                                                                ? Container(
                                                                                    decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor))),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(left: 12,right: 12,top: 4,bottom: 4),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          Container(
                                                                                            height: 40,
                                                                                            width: 40,
                                                                                            child: Checkbox(
                                                                                                shape: CircleBorder(),
                                                                                                activeColor: Color(0xfff77109B),
                                                                                                splashRadius: 20,
                                                                                                value: notifCheak[ind],
                                                                                                onChanged: (onChange) {
                                                                                                  setState(() {
                                                                                                    notifCheak[1] = !notifCheak[1];
                                                                                                    if (notifCheak[1] == true) {
                                                                                                      notifCheak[2] = true;
                                                                                                      notifCheak[3] = true;
                                                                                                      notifCheak[4] = true;
                                                                                                      notifCheak[5] = true;
                                                                                                      notifCheak[6] = true;
                                                                                                      notifCheak[7] = true;
                                                                                                      notifCheak[8] = true;
                                                                                                      notifCheak[9] = true;
                                                                                                    } else {
                                                                                                      notifCheak[2] = false;
                                                                                                      notifCheak[3] = false;
                                                                                                      notifCheak[4] = false;
                                                                                                      notifCheak[5] = false;
                                                                                                      notifCheak[6] = false;
                                                                                                      notifCheak[7] = false;
                                                                                                      notifCheak[8] = false;
                                                                                                      notifCheak[9] = false;
                                                                                                    }
                                                                                                  });
                                                                                                }),
                                                                                          ),
                                                                                          Text("${notficationString[ind]}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : Container(
                                                                                    decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor))),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(left: 12,right: 12,top: 4,bottom: 4),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          Container(
                                                                                            height: 40,
                                                                                            width: 40,
                                                                                            child: Checkbox(
                                                                                                shape: CircleBorder(),
                                                                                                activeColor: Color(0xfff77109B),
                                                                                                splashRadius: 20,
                                                                                                value: notifCheak[ind],
                                                                                                onChanged: (onChange) {
                                                                                                  setState(() {
                                                                                                    notifCheak[ind] = !notifCheak[ind];

                                                                                                    // if (selected ==
                                                                                                    //     true) {
                                                                                                    //   for (var i = 0;
                                                                                                    //       i < 8;
                                                                                                    //       i++) {}
                                                                                                    // } else {}
                                                                                                  });
                                                                                                }),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                            child: Container(
                                                                                              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(50)),
                                                                                              height: 20,
                                                                                              width: 20,
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(3),
                                                                                                child: Image.asset("assets/soccer-ball.png"),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Text("${notficationString[ind]}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                      ],
                                                                    );
                                                                  }),
                                                        ),
                                                      ),
                                                    );
                                                  }));
                                    }),
                                IconButton(
                                    icon: Icon(
                                      Icons.star_border,
                                      color: Colors.white,
                                    ),
                                    onPressed: null),
                              ],
                            ),
                          ),
                          titlePadding: EdgeInsets.only(bottom: 10),
                          centerTitle: true,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChangeNotifierProvider<
                                                          EachTeamViewModel>(
                                                      create: (_) =>
                                                          EachTeamViewModel(),
                                                      child: EachTeam(
                                                        url: provider.msnModel
                                                            .homeTeamURL,
                                                        id: widget.homeId,
                                                      ))));
                                    },
                                    child: Container(
                                        width: 40,
                                        height: 30,
                                        child: Image.network(
                                            "https://www.eplworld.com${provider.msnModel.homeTeamLogo}")),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    provider.matchDetailsModel.date
                                        .split('،')
                                        .first
                                        .tr,
                                    style: TextStyle(
                                        fontFamily: 'Vazirmatn',
                                        fontSize: 18,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChangeNotifierProvider<
                                                          EachTeamViewModel>(
                                                      create: (_) =>
                                                          EachTeamViewModel(),
                                                      child: EachTeam(
                                                        url: provider.msnModel
                                                            .awayTeamURL,
                                                        id: widget.awayId,
                                                      ))));
                                    },
                                    child: Container(
                                        width: 40,
                                        height: 30,
                                        child: Image.network(
                                            "https://www.eplworld.com${provider.msnModel.awayTeamLogo}")),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                }))),
        Directionality(
          textDirection: TextDirection.rtl,
          child: SliverPersistentHeader(
            delegate: _SliverAppBarDelegate1(
                minHeight: 45.0,
                maxHeight: 50,
                child: Consumer<EachMatchViewModel>(
                  builder: (context, provider, child) {
                    return provider.msnModel == null
                        ? Container()
                        : Container(
                            color: Theme.of(context).primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width * .5,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 25),
                                        child: Text(
                                          provider.msnModel.homeTeamName.tr,
                                          style: TextStyle(
                                              fontFamily: 'Vazirmatn',
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                  /*
                                  Container(
                                    width: 50,
                                    child: Text(
                                     "",
                                      style: TextStyle(                      fontFamily: 'Vazirmatn',color: Colors.black,),overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                   */
                                  Container(
                                    width: MediaQuery.of(context).size.width * .5,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 25),
                                        child: Text(
                                          provider.msnModel.awayTeamName.tr,
                                          style: TextStyle(
                                              fontFamily: 'Vazirmatn',
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                  },
                )),
          ),
        ),
        Directionality(
            textDirection: TextDirection.rtl,
            child: SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                    maxHeight: 60,
                    minHeight: 45,
                    child: Consumer<EachMatchViewModel>(
                      builder: (context, provider, child) {
                        return Container(
                            height: 60,
                            color: Theme.of(context).backgroundColor,
                            child: Container(
                                child: TabBar(
                              indicatorColor: Colors.white,
                              labelColor: Theme.of(context).primaryColor,
                              isScrollable: true,
                              onTap: (index) {
                                _selectedIndex = index;
                                tabController.animateTo(_selectedIndex);
                              },
                              controller: tabController,
                              tabs: tabs,
                            )));
                      },
                    )))),
      ];
    }

    return new Directionality(
        textDirection: TextDirection.rtl,
        child: Consumer<EachMatchViewModel>(
          builder: (context, provider, child) {
            return Scaffold(
                body: SafeArea(
                    child: this.tabView == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : NestedScrollView(
                            headerSliverBuilder: _sliverBuilder,
                            body: TabBarView(
                              controller: tabController,
                              children: tabView,
                            ),
                          )));
          },
        ));
  }

  Widget matchEventName() {
    return Tab(
      child: Text(
        "معاينة ".tr,
        style: tapbar,
      ),
    );
  }
  /*
  Widget matchPlayerInjured() {
    return Tab(
      child: Text(
        "مصاب ".tr,
        style: tapbar,
      ),
    );
  }


   */
  Widget matchTableName() {
    return Tab(
      child: Text(
        "المراكز".tr,
        style: tapbar,
      ),
    );
  }

  Widget matchHTHName() {
    return Tab(
      child: Text(
        "المواجهة ".tr,
        style: tapbar,
      ),
    );
  }

  List<Widget> getTabs(EachMatchViewModel provider) {
    List<Widget> test = [];
    if (provider.teamFormModel != null) {
      test.add(matchEventName());
    }
    //test.add(matchPlayerInjured());


    if (provider.tablesModelList != null) {
      test.add(matchTableName());
    }



    if (provider.headToHeadModel != null) {
      test.add(matchHTHName());
    }
    return test;
  }

  Widget matchEvent() {
    return ListView(children: <Widget>[MatchEvents(url:widget.url,homeId:widget.homeId,awayId:widget.awayId)]);
  }

  Widget matchTable() {
    return ListView(children: <Widget>[
      MatchPostions(
        url: widget.url,
        awayId: widget.awayId,
        homeId: widget.homeId,
      )
    ]);
  }

  Widget matchGTable() {
    return ListView(children: <Widget>[
      MatchGPosition(
        url: widget.url,
        awayId: widget.awayId,
        homeId: widget.homeId,
      )
    ]);
  }

  Widget matchInjured() {
    return ListView(children: <Widget>[
      PlayerInjured()
    ]);
  }

  Widget matchHTH() {
    //matchesViewModel.getHTHMatch(widget.url);
    // print("FromOutSide${matchesViewModel.headToHeadModel.rows[0].homeTeamName}");

    return ListView(children: <Widget>[
      PreConfront(
        url: widget.url,
      )
    ]);
  }

  List<Widget> getTabView(EachMatchViewModel provider) {
    List<Widget> test = [];
    if (provider.teamFormModel != null) {
      test.add(matchEvent());
    }
   // test.add(matchInjured());


    if (provider.tablesModelList != null &&
        provider.tablesModelList[0].list.length == 1) {
      test.add(matchTable());
    }

    if (provider.tablesModelList != null && provider.tablesModelList[0].list.length > 1) {
      test.add(matchGTable());
    }



    if (provider.headToHeadModel != null) {
      test.add(matchHTH());
    }

    return test;
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class _SliverAppBarDelegate1 extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate1({
    @required this.minHeight,
    @required this.maxHeight,
    this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate1 oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
