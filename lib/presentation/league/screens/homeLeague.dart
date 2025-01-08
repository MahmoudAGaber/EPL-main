
import 'package:epl/presentation/league/screens/groupStandings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../../Data/StateModel.dart';
import '../../../shared/Utils/Constants.dart';
import '../provider/LeagueViewModel.dart';
import '../../../domain/Models/Standing.dart';
import 'LeagueStanding.dart';
import 'cups.dart';
import 'playersStats.dart';
import 'leagueNews.dart';
import 'matchsForLeague.dart';
import 'teamsStats.dart';
import 'transferCenter.dart';

class LeagueHome extends ConsumerStatefulWidget {
  dynamic leagueId;
  String? leagueName;
  String? logo;
  LeagueHome({this.leagueId, this.leagueName, this.logo});
  @override
  _LeagueHomeState createState() => _LeagueHomeState();
}

class _LeagueHomeState extends ConsumerState<LeagueHome> with TickerProviderStateMixin {
  ScrollController _controller = ScrollController();

  TextStyle tapbar =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 14, color: Colors.white);
  TextStyle head =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 16, color: Colors.white);

  bool chContaier = false;

  TabController? tabController;
  ScrollController? scrollController;
  int _selectedIndex = 0;
  int page = 1;
  String? seasonId;

  AnimationController? animationController;
  Animation<double>? _animation;

  List<Widget> tabNamee = [];
  List<Widget> tabVieww = [];



  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {

      ref.read(LeagueSeasonsProvider.notifier).getLeagueSeasons(widget.leagueId.toString()).then((seasonId){
        this.seasonId = seasonId!;
        ref.read(LeagueStandingProvider.notifier).getTable(seasonId, "total");
        ref.read(LeagueGroupStandingProvider.notifier).getTable(seasonId, "total");
        ref.read(PlayerStatsProvider.notifier).getPlayerStats(seasonId);
        ref.read(TeamStatsProvider.notifier).getTeamStats(seasonId);

        print("SEASONID${this.seasonId}");
      });
      ref.read(LeagueNewsProvider.notifier).getNews(widget.leagueName!);

      _controller.addListener(() {
        if (_controller.position.pixels ==
            _controller.position.maxScrollExtent) {
          page++;
        }
      });
    });

    animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);

    _animation =
        CurvedAnimation(parent: animationController!, curve: Curves.easeIn);

    animationController!.forward();
    super.initState();
  }


  @override
  void dispose() {
    //tabController.dispose();
    //G.socketUtils!.closeConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var standings = ref.watch(LeagueStandingProvider);

    List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        Directionality(
          textDirection: TextDirection.rtl,
          child: SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0.0,
            actions: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                      ),
                      onPressed: null),
                  IconButton(
                      icon: Icon(Icons.star, color: Colors.white),
                      onPressed: null),
                ],
              )
            ],
            expandedHeight: 130.0,
            pinned: true,
            floating: true,
            snap: true,
            flexibleSpace:
                // tabNamee = tabName(provider);
                //tabVieww = tabView(provider);
                //tabController = new TabController(length: tabVieww.length, vsync: this, initialIndex: _selectedIndex);
                //provider.toggleLoading(false);
                 FlexibleSpaceBar(
                        background: Container(
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 25, top: 60),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        height: 60,
                                        width: 55,
                                        child: Image.network(
                                          "${Constants.leagueImage}${widget.leagueId}.png",
                                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                            return CircleAvatar(backgroundColor: Colors.grey,);
                                          },
                                        ),)
                                  ],
                                ),
                              ),
                              // Positioned(
                              //     top: 105,
                              //     right: 100,
                              //     child: Row(
                              //       children: <Widget>[
                              //         Text(
                              //          "belong",
                              //           style: TextStyle(
                              //               fontFamily: 'Vazirmatn',
                              //               color: Colors.white),
                              //         )
                              //       ],
                              //     ))
                            ],
                          ),
                        ),
                        centerTitle: false,
                        titlePadding: EdgeInsets.only(top: 1.0, bottom: 20.0, left: 4, right: 100),
                        title: FittedBox(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 0.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        widget.leagueName!,
                                        style: head,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )

          ),
        ),
        Directionality(
            textDirection: TextDirection.rtl,
            child: SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                    maxHeight: 55,
                    minHeight: 45,
                    child: Container(
                                height: 55,
                                color: Theme.of(context).primaryColor,
                                child: DefaultTabController(
                                  length: tabName("").length,
                                  child: TabBar(
                                      indicatorColor: Colors.white,
                                      isScrollable: true,
                                      onTap: (index) {
                                        _selectedIndex = index;
                                        tabController!.animateTo(_selectedIndex);
                                      },
                                      controller: tabController,
                                      tabs: List.generate(
                                          5,
                                          (index) => tabName("")[
                                                  index]).toList()),
                                ),
                    )
                )
            )
        ),
      ];
    }

    return new Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            controller: _controller,
            physics: ClampingScrollPhysics(),
            headerSliverBuilder: _sliverBuilder,
            body: TabBarView(
                          controller: tabController = new TabController(
                              length: tabView(standings).length,
                              vsync: this,
                              initialIndex: _selectedIndex),
                          children: List.generate(tabView(standings).length, (index) => tabView(standings)[index]).toList())
    )
          ),

    )
    );
  }

  Widget PositionN() {
    return Tab(
      child: Text(
        "المراكز".tr,
        style: tapbar,
      ),
    );
  }

  Widget matchesN() {
    return Tab(
      child: Text(
        "المباريات".tr,
        style: tapbar,
      ),
    );
  }

  Widget NewsN() {
    return Tab(
      child: Text(
        "الأخبار".tr,
        style: tapbar,
      ),
    );
  }

  Widget playersStatsN() {
    return Tab(
      child: Text(
        "احصائيات اللاعبين".tr,
        style: tapbar,
      ),
    );
  }

  Widget teamsStatsN() {
    return Tab(
      child: Text(
        "احصائيات الفرق".tr,
        style: tapbar,
      ),
    );
  }

  Widget transferN() {
    return Tab(
      child: Text(
        "الأنتقالات".tr,
        style: tapbar,
      ),
    );
  }

  Widget cupsN() {
    return Tab(
      child: Text(
        " المواسم".tr,
        style: tapbar,
      ),
    );
  }

  List<Widget> tabName(provider) {
    List<Widget> test = [];
    test.add(PositionN());
    test.add(matchesN());
    test.add(NewsN());
    test.add(playersStatsN());
    test.add(teamsStatsN());
    test.add(transferN());
    test.add(cupsN());


    // if (provider.tablesModelList != null) {
    //   test.add(PositionN());
    // }
    //
    // if (provider.recentMatcheBox != null) {
    //   test.add(matchesN());
    // }
    //
    // if (provider.newsModelList != null) {
    //   test.add(NewsN());
    // }
    //
    // if (provider.playersModel != null) {
    //   test.add(playersStatsN());
    // }
    //
    // if (provider.teamsModel != null) {
    //   test.add(teamsStatsN());
    // }
    //
    // if (provider.transferBoxesModelList != null) {
    //   test.add(transferN());
    // }
    //
    // if (provider.trophiesBoxesModelList != null) {
    //   test.add(cupsN());
    // }

    return test;
  }

  /*
  List<Widget> tabName(OneLeagueViewModel provider) {
    List<Widget> test = [];
      test.add(PositionN());
      test.add(matchesN());
      test.add(NewsN());
      test.add(playersStatsN());
      test.add(teamsStatsN());
      test.add(transferN());
      test.add(cupsN());

    return test;
  }

   */

  Widget position() {
    return ListView(children: <Widget>[
      LeagueStanding()
    ]);
  }

  Widget positionGTable() {
    return ListView(children: <Widget>[
      MatchGPosition(

      )
    ]);
  }

  Widget matches() {
    return ListView(children: <Widget>[matchesForLeague()]);
  }

  Widget News() {
    return ListView(children: <Widget>[leagueNews()]);
  }

  Widget playerStats() {
    return ListView(children: <Widget>[
      playersStats(

      )
    ]);
  }

  Widget teamStats() {
    return ListView(children: <Widget>[TeamState()]);
  }

  Widget transfers() {
    return ListView(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: <Widget>[TransferCenter()],
    );
  }

  Widget cups() {
    return ListView(children: <Widget>[
      Cups()
    ]);
  }

  List<Widget> tabView(StateModel<TableModel> standings) {
    List<Widget> test = [];

    if(standings.data !=null) {
      test.add(position());

    }else{
      test.add(positionGTable());
    }

    test.add(matches());
    test.add(News());
    test.add(playerStats());
    test.add(teamStats());
    test.add(transfers());
    test.add(cups());


    // if (provider.tablesModelList != null &&
    //     provider.tablesModelList[0].list.length == 1) {
    // }
    //
    // if (provider.tablesModelList != null &&
    //     provider.tablesModelList[0].list.length > 1) {
    // }
    //
    // if (provider.recentMatcheBox != null) {
    // }
    //
    // if (provider.newsModelList != null) {
    // }
    //
    // if (provider.playersModel != null) {
    // }
    //
    // if (provider.teamsModel != null) {
    // }
    //
    // if (provider.transferBoxesModelList != null) {
    // }
    //
    // if (provider.trophiesBoxesModelList != null) {
    // }

    return test;
  }

/*
  List<Widget> tabView(url) {
    List<Widget> test = [];
      test.add(Position(url));
      test.add(fixture(url));
      test.add(news(url));
      test.add(playerStats(url));
      test.add(teamStats(url));
      test.add(transfers(url));
      test.add(cups(url));

    return test;
  }

 */

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
