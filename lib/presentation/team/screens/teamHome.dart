
import 'package:epl/presentation/team/provider/TeamViewModel.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../shared/Utils/Constants.dart';
import 'teamNews.dart';
import 'teamSquad.dart';
import 'teamStanding.dart';
import 'teamViedos.dart';
import 'trophy.dart';
import 'teamMatches.dart';
import 'teamOverview.dart';
import 'transferTeam.dart';

class HomeTeam extends ConsumerStatefulWidget {
  String? teamName;
  String? teamId;
  String? country;
  HomeTeam({
    this.teamId,
    this.teamName,
    this.country
  });
  @override
  _EachTeamState createState() => _EachTeamState();
}

class _EachTeamState extends ConsumerState<HomeTeam> with TickerProviderStateMixin {
  ScrollController _controller = ScrollController();
  static const TextStyle tapbar = TextStyle(
      fontFamily: 'Vazirmatn',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white);
  TextStyle head =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 16, color: Colors.white);

  bool chContaier = false;

  TabController? tabController;
  int _selectedIndex = 0;
  int newsPages = 1;
  int videosPages = 1;
  int transfersPages = 1;

  AnimationController? animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {


      ref.read(TeamSeasonsProvider.notifier).getTeamSeasons(widget.teamId!).then((seasonId)async{
        print("SeasonID${seasonId}");
        ref.read(TeamOverviewProvider.notifier).getTeamOverview(widget.teamId!, seasonId!);
        ref.read(TeamNewsProvider.notifier).getNews(widget.teamName!);
        ref.read(TeamVideosProvider.notifier).getVideos(widget.teamName!);
        ref.read(TeamMatchesProvider.notifier).getMatches(widget.teamId!, seasonId);
        print("TeamId${widget.teamId}");
        ref.read(TeamTableProvider.notifier).getTable(seasonId,"total");
        ref.read(SquadProvider.notifier).getSquad(widget.teamId!);
        ref.read(TrophyProvider.notifier).getTrophy(widget.teamId!);
      });




      _controller.addListener(() {
        if (_controller.position.pixels ==
            _controller.position.maxScrollExtent) {
          if (tabController!.index == 1) {
            newsPages++;
            //eachTeamViewModel!.getNews("${widget.url}/news", newsPages);
            print("hi");
          } else if (tabController!.index == 2) {
            videosPages++;
           // eachTeamViewModel!.getVideos("${widget.url}/videos", videosPages);
          }
          else if (tabController!.index == 6) {
            transfersPages++;
          //  eachTeamViewModel!.getTransfers("${widget.url}/transfers", transfersPages);
          }
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            flexibleSpace:FlexibleSpaceBar(
                    background: Container(
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 25, top: 60),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                 SizedBox(
                                  width: 55,
                                  height: 55,
                                  child: Image.network(
                                    "${Constants.teamImage}${widget.teamId}.png",
                                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                      return CircleAvatar(backgroundColor: Colors.grey,);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                              top: 105,
                              right: 100,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    widget.country??"",
                                    style: TextStyle(
                                        fontFamily: 'Vazirmatn',
                                        color: Colors.white),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                    centerTitle: false,
                    titlePadding: EdgeInsets.only(top: 1.0, bottom: 25.0, right: 100),
                    title: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                widget.teamName!,
                                style: head,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),

            ),
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
                          child: tabController == null
                              ? Container()
                              : TabBar(
                                  indicatorColor: Colors.white,
                                  isScrollable: true,
                                  onTap: (index) {
                                    _selectedIndex = index;
                                    tabController!.animateTo(_selectedIndex);
                                  },
                                  controller: tabController,
                                  tabs: List.generate(8, (index) => tabName("")[index]).toList()),
                        )
                      ))),
      ];
    }

    return new Directionality(
      textDirection: TextDirection.rtl,
      child:  Scaffold(
            body: SafeArea(
              child: NestedScrollView(
                controller: _controller,
                physics: ClampingScrollPhysics(),
                headerSliverBuilder: _sliverBuilder,
                body: TabBarView(
                  physics: ClampingScrollPhysics(),
                  controller: tabController = new TabController(
                      length: tabView("").length,
                      vsync: this,
                      initialIndex: _selectedIndex),
                  children: List.generate(tabView("").length,
                      (index) => tabView("")[index]),
                ),
              ),
            ),

      ),
    );
  }

  Widget overViewN() {
    return Tab(
      child: Text(
        "عام".tr,
        style: tapbar,
      ),
    );
  }

  Widget teamNewsN() {
    return Tab(
      child: Text(
        "الأخبار".tr,
        style: tapbar,
      ),
    );
  }

  Widget videoTeamN() {
    return Tab(
      child: Text(
        "الفيديو".tr,
        style: tapbar,
      ),
    );
  }

  Widget matchesForTeamN() {
    return Tab(
      child: Text(
        "المباريات".tr,
        style: tapbar,
      ),
    );
  }

  Widget teamPositionN() {
    return Tab(
      child: Text(
        "المراكز".tr,
        style: tapbar,
      ),
    );
  }

  Widget teamSquadN() {
    return Tab(
      child: Text(
        " الفريق".tr,
        style: tapbar,
      ),
    );
  }

  Widget statisticsForTeamN() {
    return Tab(
      child: Text(
        " إحصائيات".tr,
        style: tapbar,
      ),
    );
  }

  Widget transferTeamN() {
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
        " الأنجازات".tr,
        style: tapbar,
      ),
    );
  }

  List<Widget> tabName( provider) {
    List<Widget> test = [];

    test.add(overViewN());
    test.add(teamNewsN());
    test.add(videoTeamN());
    test.add(matchesForTeamN());
    test.add(teamPositionN());
    test.add(teamSquadN());
    test.add(transferTeamN());
    test.add(cupsN());




    // if (provider.statsModel != null) {
    // }
    // if (provider.newsModelList != null) {
    // }
    // if (provider.videoModelList != null) {
    // }
    //
    // if (provider.recentMatcheBox != null) {
    // }
    // if (provider.tablesModelList != null) {
    // }
    // if (provider.squadsModel != null) {
    // }
    //
    // if (provider.transferBoxesModelList != null) {
    // }
    // if (provider.trophiesBoxesModelList != null) {
    // }

    return test;
  }

  Widget overView() {
    return ListView(children: <Widget>[
      OverView()
    ]);
  }

  Widget teamNews() {
    return ListView(physics: NeverScrollableScrollPhysics(), children: <Widget>[
      TeamNews()
    ]);
  }

  Widget videoTeam() {
    return ListView(children: <Widget>[
      VideoTeam()
    ]);
  }

  Widget matchesForTeam() {
    return ListView(children: <Widget>[
      MatchesForTeam(teamId:widget.teamId)
    ]);
  }

  Widget teamPosition() {
    return ListView(
      children: <Widget>[
        TeamPosition(teamId:widget.teamId)
      ],
    );
  }

  Widget teamSquad() {
    return ListView(children: <Widget>[
      TeamSquad()
    ]);
  }

  Widget statisticsForTeam() {
    return ListView(children: <Widget>[statisticsForTeam()]);
  }

  Widget transferTeam() {
    return ListView(children: <Widget>[
      tranferTeam()
    ]);
  }

  Widget cups() {
    return ListView(children: <Widget>[
      Trophy()
    ]);
  }

  List<Widget> tabView( provider) {
    List<Widget> test = [];

    test.add(overView());

    test.add(teamNews());

    test.add(videoTeam());

    test.add(matchesForTeam());

    test.add(teamPosition());

    test.add(teamSquad());

    test.add(transferTeam());

    test.add(cups());

    // if (provider.statsModel != null) {
    // }
    // if (provider.newsModelList != null) {
    // }
    // if (provider.videoModelList != null) {
    // }
    //
    // if (provider.recentMatcheBox != null) {
    // }
    // if (provider.tablesModelList != null) {
    // }
    // if (provider.squadsModel != null) {
    // }
    //
    // if (provider.transferBoxesModelList != null) {
    // }
    // if (provider.trophiesBoxesModelList != null) {
    // }

    return test;
  }
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
