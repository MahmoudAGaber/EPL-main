
import 'package:epl/presentation/fixture/provider/fixtureViewModel.dart';
import 'package:epl/presentation/team/provider/TeamViewModel.dart';
import 'package:epl/shared/Views/custom/custom_imageView.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../shared/Utils/Constants.dart';
import '../../../shared/Views/custom/custom_loader.dart';
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
  bool isLoading = true;
  List<Widget> tabsName = [];
  List<Widget> tabsView = [];

  AnimationController? animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchAllData().then((value) => setUpTabsAndViews());

      //   _controller.addListener(() {
      //     if (_controller.position.pixels ==
      //         _controller.position.maxScrollExtent) {
      //       if (tabController!.index == 1) {
      //         newsPages++;
      //         //eachTeamViewModel!.getNews("${widget.url}/news", newsPages);
      //         print("hi");
      //       } else if (tabController!.index == 2) {
      //         videosPages++;
      //        // eachTeamViewModel!.getVideos("${widget.url}/videos", videosPages);
      //       }
      //       else if (tabController!.index == 6) {
      //         transfersPages++;
      //       //  eachTeamViewModel!.getTransfers("${widget.url}/transfers", transfersPages);
      //       }
      //     }
      //   });
      // });
      //
      // animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
      //
      // _animation = CurvedAnimation(parent: animationController!, curve: Curves.easeIn);
      //
      // animationController!.forward();
    });
    super.initState();

        }

  Future<void> fetchAllData() async {
    try {
      final seasonId = await ref.read(teamSeasonsProvider.notifier).fetchTeamSeasons(widget.teamId!);

      await Future.wait([
        ref.read(teamSeasonsProvider.notifier).fetchTeamSeasons(widget.teamId!),
        ref.read(teamOverviewProvider.notifier).fetchTeamOverview(widget.teamId!, seasonId!),
        ref.read(teamNewsProvider.notifier).fetchTeamNews(widget.teamName!),
        ref.read(teamVideosProvider.notifier).fetchTeamVideos(widget.teamName!),
        ref.read(teamMatchesProvider.notifier).fetchTeamMatches(widget.teamId!, seasonId),
        ref.read(teamStandingProvider.notifier).fetchTeamStanding(seasonId,"total"),
        ref.read(teamSquadProvider.notifier).fetchTeamSquad(widget.teamId!),
        ref.read(teamTrophyProvider.notifier).fetchTeamTrophy(widget.teamId!),
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
    final teamOverviewState = ref.watch(teamOverviewProvider);
    final teamNewsState = ref.watch(teamNewsProvider);
    final teamVideosState = ref.watch(teamVideosProvider);
    final teamSeasonsState = ref.watch(teamSeasonsProvider);
    final teamMatchesState = ref.watch(teamMatchesProvider);
    final teamStandingState = ref.watch(teamStandingProvider);
    final teamSquadState = ref.watch(teamSquadProvider);
    final teamTrophyState = ref.watch(teamTrophyProvider);


    final tabsName = <Widget>[];
    final tabsView = <Widget>[];

    Map<String,List<Widget>> tabs= {
      'tabsName':tabsName,
      'tabsView': tabsView
    };



      if (teamOverviewState.data != null) {
        tabsName.add(overViewN());
        tabsView.add(overView());
      }
      if (teamNewsState.data != null) {
        tabsName.add(teamNewsN());
        tabsView.add(teamNews());
      }
      if (teamVideosState.data != null) {
        tabsName.add(videoTeamN());
        tabsView.add(videoTeam());
      }
      if (teamMatchesState.data != null ) {
        tabsName.add(matchesForTeamN());
        tabsView.add(matchesForTeam());
      }
      if (teamStandingState.data != null ) {
        if (teamStandingState.data!.format == "default") {
          tabsName.add(teamPositionN());
          tabsView.add(teamPosition());
        } else if (teamStandingState.data!.format == "groups") {
          tabsName.add(teamPositionN());
          tabsView.add(teamPosition());
        }
      }
      if (teamSquadState.data != null) {
        tabsName.add(teamSquadN());
        tabsView.add(teamSquad());
      }

      if (teamTrophyState.data != null) {
        tabsName.add(cupsN());
        tabsView.add(cups());
      }

    return tabs;
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
                                  child:CustomImage(imgUrl:"${Constants.teamImage}${widget.teamId}.png" ,)
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

                      ))),
      ];
    }

    return  Directionality(
      textDirection: TextDirection.rtl,
      child:  Scaffold(
            body: SafeArea(
              child: NestedScrollView(
                controller: _controller,
                physics: ClampingScrollPhysics(),
                headerSliverBuilder: _sliverBuilder,
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

