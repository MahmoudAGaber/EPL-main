import 'dart:math';
import 'dart:ui';

import 'package:epl/Data/StateModel.dart';
import 'package:epl/shared/Views/custom/custom_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../../shared/Utils/Constants.dart';
import '../../home/screens/widgets/More.dart';
import '../../team/screens/teamHome.dart';
import '../provider/fixtureViewModel.dart';
import '../../../shared/Utils/date_converter.dart';
import '../../../domain/Models/Event.dart';
import 'Lineup.dart';
import 'MatchStats.dart';
import 'H2H.dart';
import 'MatchEvent.dart';
import 'matchStanding.dart';


class MatchInfo extends ConsumerStatefulWidget {
  String? homeId;
  String? awayId;
  String? url;
  String? comName;
  String? matchId;
  String? fixtureId;
  String? seasonId;
  List<Widget>? tabs;
  List<Widget>? tabsView;
  bool? isLoading;

  MatchInfo(
      {this.fixtureId,
      this.url,
      this.homeId,
      this.awayId,
      this.comName,
      this.matchId,
      this.seasonId,
         this.tabs,
         this.tabsView,
        this.isLoading});

  @override
  _MatchInfoState createState() => _MatchInfoState();
}

class _MatchInfoState extends ConsumerState<MatchInfo> with TickerProviderStateMixin {


  TabController? tabController;
  int _selectedIndex = 0;

  int goalsLength = 0;
  bool isLoading = true;
  List<Widget> tabsName = [];
  List<Widget> tabsView = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchAllData();
      setUpTabsAndViews();
       // tabsName = widget.tabs!;
       // tabsView = widget.tabsView!;


      // ref.read(MatchInfoProvider.notifier).getMatchInfo(widget.fixture_id!).then((value) {
        // print("FixtureID${widget.fixture_id!}");
      //   ref.read(TableProvider.notifier).getTable(value!.league.season!,"total");
      //   ref.read(TableInOverviewProvider.notifier).getTeamsInTable(widget.homeId!, widget.awayId!);
      // });
      // ref.read(MatchEventsProvider.notifier).getMatchEvents(widget.fixture_id!).then((value) {
      //   if (value != null || value!.isNotEmpty) {
      //     value.forEach((event) {
      //       if (event.type == "G") {
      //         goalsLength++;
      //       }
      //     });
      //   }
      // });
      // ref.read(TeamFormProvider.notifier).getTeamForm(widget.fixture_id!);
      // ref.read(LineUpsProvider.notifier).getLinUps(widget.fixture_id!);
      // ref.read(MatchStatisticsProvider.notifier).getMatchStatistics(widget.fixture_id!);
      // ref.read(H2HProvider.notifier).getH2HModel(widget.fixture_id!);

      var loading = ref.watch(fixtureLoadingTabsProvider);


    //  tabs = getTabs(ref);
     // tabView = getTabView(ref);
    });

    super.initState();
  }

    Future<void> fetchAllData() async {
    try {
      final matchInfo = await ref.read(MatchInfoProvider.notifier).getMatchInfo(widget.fixtureId!);

      await Future.wait([
       ref.read(matchEventsProvider.notifier).fetchMatchEvents(widget.fixtureId!),
     ref.read(matchTeamFormProvider.notifier).fetchMatchTeamForm(widget.fixtureId!),
      ref.read(matchLineupsProvider.notifier).fetchMatchLineUps(widget.fixtureId!),
        ref.read(matchTableProvider.notifier).fetchMatchTable(matchInfo!.league.season!,'total'),
        ref.read(matchStatsProvider.notifier).fetchMatchStats(widget.fixtureId!),
          ref.read(matchH2HProvider.notifier).fetchMatchH2H(widget.fixtureId!),
      ]);
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  void setUpTabsAndViews() {
    setState(() {
      tabsName = getTabs()['tabsName']!;
      tabsView = getTabs()['tabsView']!;
      // Update the TabController if the tab count changes
      tabController = TabController(length: tabsName.length, vsync: this);
    });
  }

  Map<String,List<Widget>> getTabs() {
    final matchEventsState = ref.watch(matchEventsProvider);
    final matchTeamFormState = ref.watch(matchTeamFormProvider);
    final matchLineupsState = ref.watch(matchLineupsProvider);
    final matchTableState = ref.watch(matchTableProvider);
    final matchStatsState = ref.watch(matchStatsProvider);
    final matchH2HState = ref.watch(matchH2HProvider);

    final tabsName = <Widget>[];
    final tabsView = <Widget>[];

    Map<String,List<Widget>> tabs= {
      'tabsName':tabsName,
      'tabsView': tabsView
    };


    if (matchEventsState.data != null || matchTeamFormState.data != null) {
      tabsName.add(matchEventName());
      tabsView.add(matchEvent());

    }
    if (matchLineupsState.data != null) {
      tabsName.add(lineUpName());
      tabsView.add(lineUp());

    }
    if (matchStatsState.data != null) {
      tabsName.add(statsName());
      tabsView.add(stats());

    }
    if (matchTableState.data != null) {
      tabsName.add(matchTableName());
      tabsView.add(matchTable());

    }
    if (matchH2HState.data != null) {
      tabsName.add(matchHTHName());
      tabsView.add(matchHTH());

    }

    return tabs;
  }


  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
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
    var matchInfo = ref.watch(MatchInfoProvider);
    var events = ref.watch(MatchEventsProvider);
    var lineups = ref.watch(LineUpsProvider);
    var table = ref.watch(TableProvider);
    var statistics = ref.watch(MatchStatisticsProvider);
    var headToHead = ref.watch(H2HProvider);
    var loading = ref.watch(fixtureLoadingTabsProvider);

    final matchEventsState = ref.watch(matchEventsProvider);
    final matchTeamFormState = ref.watch(matchTeamFormProvider);
    final matchLineupsState = ref.watch(matchLineupsProvider);
    final matchTableState = ref.watch(matchTableProvider);
    final matchStatsState = ref.watch(matchStatsProvider);
    final matchH2HState = ref.watch(matchH2HProvider);

    // List<Widget> tabsName = [];
    // List<Widget> tabsView = [];
    //
    // if (matchEventsState.data!=null || matchTeamFormState.data!=null) {
    //   tabsName.add(matchEventName());
    //   tabsView.add(matchEvent());
    // }
    //
    // if (matchLineupsState.data != null) {
    //   tabsName.add(lineUpName());
    //   tabsView.add(lineUp());
    // }
    //
    // if (matchStatsState.data != null) {
    //   tabsName.add(statsName());
    //   tabsView.add(stats());
    // }
    //
    // if (matchTableState.data != null) {
    //   tabsName.add(matchTableName());
    //   tabsView.add(matchTable());
    // }
    //
    // if (matchH2HState.data != null) {
    //   tabsName.add(matchHTHName());
    //   tabsView.add(matchHTH());
    // }
    //
    // tabController = TabController(length: tabsName.length, vsync: this);


    List<Widget> sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        Directionality(
            textDirection: TextDirection.rtl,
            child: SliverAppBar(
                iconTheme: IconThemeData(color: Colors.white),
                elevation: 0.0,
                actions: <Widget>[
                  Row(
                    children: <Widget>[],)
                ],
                expandedHeight: 130.0,
                backgroundColor: Theme.of(context).primaryColor,
                pinned: true,
                floating: true,
                snap: true,
                flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.only(bottom: 63, left: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.notifications_none,
                                color: Colors.white,
                              ),
                              onPressed: () {}),
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
                    title: matchInfo.handelState(
                        onLoading: (state) => SizedBox(),
                        onSuccess: (state) => Row(
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
                                                      HomeTeam(teamName: matchInfo.data!.teams.home.name,
                                                        teamId: matchInfo.data!.teams.home.id,
                                                        country: matchInfo.data!.league.country,
                                                      )));
                                        },
                                        child: SizedBox(
                                            width: 40,
                                            height: 30,
                                              child: Image.network(
                                                "${Constants.teamImage}${widget.homeId}.png",
                                                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                                  return CircleAvatar(backgroundColor: Colors.grey,);
                                                },
                                              ),
                                        ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    matchInfo.data!.fixture.status!.long == "Not Started"
                                        ? Text(DateConverter.isoStringToLocalTimeOnly(matchInfo.data!.fixture.date),
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
                                          )
                                        : matchInfo.data!.fixture.status!.long == 'Postponed'
                                            ? Text('time', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white))
                                            : Text(
                                                "${matchInfo.data!.score.fulltime!.home} - ${matchInfo.data!.score.fulltime!.away}",
                                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
                                              ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) => HomeTeam(
                                                      teamName: matchInfo.data!.teams.away.name,
                                                      teamId: matchInfo.data!.teams.away.id,
                                                      country: matchInfo.data!.league.country,
                                                    )));
                                      },
                                      child: SizedBox(
                                        width: 40,
                                        height: 30,
                                        child: Image.network(
                                          "${Constants.teamImage}${widget.awayId}.png",
                                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                            return CircleAvatar(backgroundColor: Colors.grey,);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        onFailure: (state) => Text("Shit"))))),
        Directionality(
            textDirection: TextDirection.rtl,
            child: SliverPersistentHeader(
                floating: true,
                delegate: _SliverAppBarDelegate1(
                    minHeight: 45.0,
                    maxHeight: goalsInHeaders().length == 0
                        ? 60
                        : min((goalsInHeaders().length * 25) / 1.1 + 60, MediaQuery.of(context).size.height / 2),
                    child: matchInfo.handelState(
                        onLoading: (state) => SizedBox(),
                        onSuccess: (state) => Container(
                              color: Theme.of(context).primaryColor,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width *.5,
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 25),
                                                child: Text(
                                                  matchInfo.data!.teams.home.name!,
                                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * .5,
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 25),
                                                child: Text(
                                                  matchInfo.data!.teams.away.name!,
                                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width * .2,
                                            child: Center(
                                              child: Text(
                                                matchInfo.data!.fixture.status!.shortStatus != 'FT'
                                                    ? ''
                                                    : "نهايه اللقاء",
                                                style: const TextStyle(
                                                  fontFamily: 'Vazirmatn',
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 1),
                                            child: Column(
                                              children: List.of(goalsInHeaders()),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        onFailure: (state) => Text("Shit"))))),
        Directionality(
            textDirection: TextDirection.rtl,
            child: SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  maxHeight: 45,
                  minHeight: 40,
                  child: matchInfo.handelState(
                      onLoading: (state) => SizedBox(),
                      onSuccess: (state) => Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              border: Border(top: BorderSide(color: Colors.white, width: .1))),
                          child: !isLoading? DefaultTabController(
                            length: isLoading?tabsName.length:0,
                              child: TabBar(
                            tabs: tabsName,
                            controller: tabController,
                            indicatorColor: Colors.white,
                            labelColor: Colors.white,
                            isScrollable: true,
                            onTap: (index) {
                              _selectedIndex = index;
                              tabController!.animateTo(_selectedIndex);
                            },
                          )):SizedBox()),
                      onFailure: (state) => Text("Shit")),
                )))
      ];
    }

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            body: SafeArea(child: NestedScrollView(
          headerSliverBuilder: sliverBuilder,
          body: DefaultTabController(
            length: !isLoading?tabsView.length:0,
            child: TabBarView(
              controller: tabController,
              children: !isLoading? tabsView: [Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CustomLoader(),
                  ),
                ],
              )],
            ),
          ),
        ))));

  }

  Widget goal(String homeTeamId, EventModel? eventModel) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Directionality(
          textDirection: homeTeamId == eventModel!.team.id
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      child: Text("${eventModel.time.elapsed}'",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                    ),
                    eventModel.time.extra != null
                        ? Text("${eventModel.time.extra}+",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 10,
                                    color: Colors.white60,
                                    fontWeight: FontWeight.bold))
                        : SizedBox(),
                  ],
                ),
                SizedBox(
                  width: 3,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          eventModel.player.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 12, color: Colors.white),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  List<Widget> goalsInHeaders() {
    var matchInfo = ref.watch(MatchInfoProvider);
    var events = ref.watch(matchEventsProvider);

    List<Widget> goals = [];

    if(matchInfo.data!=null && events.data!=null){
      if (events.data!.isNotEmpty || events.data != null) {
        events.data!.forEach((eventModel) {
          if (eventModel.type == "G") {
            goals.add(goal(matchInfo.data!.teams.home.id, eventModel));
          }
        });
      }
    }

    return goals;
  }

  Widget matchEventName() => Tab(
    child: Text(
      "معاينة ".tr,
      style: tapbar,
    ),
  );

  Widget lineUpName() => Tab(
    child: Text(
      "تشكيلة".tr,
      style: tapbar,
    ),
  );

  Widget matchTableName() => Tab(
    child: Text(
      "المراكز".tr,
      style: tapbar,
    ),
  );

  Widget statsName() => Tab(
    child: Text(
      "إحصائيات".tr,
      style: tapbar,
    ),
  );

  Widget matchHTHName() => Tab(
    child: Text(
      "المواجهة ".tr,
      style: tapbar,
    ),
  );

  Widget matchEvent() => ListView(
    children: [
      MatchEvents(
        fixture_id: widget.fixtureId,
        homeId: widget.homeId,
        awayId: widget.awayId,
      ),
    ],
  );

  Widget lineUp() => LineUps();

  Widget matchTable() => ListView(children: [MatchStanding()]);

  Widget stats() => MatchStats();

  Widget matchHTH() => ListView(children: [H2H()]);
  }



class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
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
    required this.minHeight,
    required this.maxHeight,
    required this.child,
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
