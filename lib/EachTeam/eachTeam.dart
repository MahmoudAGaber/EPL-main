import 'package:arseli/EachTeam/transferTeam.dart';
import 'package:arseli/EachTeam/VideoTeam.dart';
import 'package:arseli/EachTeam/statisticsForTeam.dart';
import 'package:arseli/EachTeam/teamNews.dart';
import 'package:arseli/EachTeam/teamTeam.dart';
import 'package:arseli/Models/OneLeague/TableModel.dart';
import 'package:arseli/webView.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:arseli/Provider/MatchesViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'Teampostions.dart';
import 'cups.dart';
import 'matchesForteam.dart';
import 'overView.dart';

class EachTeam extends StatefulWidget {
  String url;
  String id;
  EachTeam({
    this.url,
    this.id,
  });
  @override
  _EachTeamState createState() => _EachTeamState();
}

class _EachTeamState extends State<EachTeam> with TickerProviderStateMixin {
  EachTeamViewModel eachTeamViewModel;
  ScrollController _controller = ScrollController();
  static const TextStyle tapbar = TextStyle(
      fontFamily: 'Vazirmatn',
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: Colors.white);
  TextStyle head =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 16, color: Colors.white);

  bool chContaier = false;

  TabController tabController;
  int _selectedIndex = 0;
  int newsPages = 1;
  int videosPages = 1;

  AnimationController animationController;
  Animation<double> _animation;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      eachTeamViewModel = Provider.of(context, listen: false);
      await eachTeamViewModel.getOverView("${widget.url}/overview");
      eachTeamViewModel.getNews("${widget.url}/news", 1);
      eachTeamViewModel.getVideos("${widget.url}/videos", 1);
      eachTeamViewModel.getAllMatches(widget.url, 'matches');
      eachTeamViewModel.getTables(widget.url, 'tables');
      eachTeamViewModel.getSquads("${widget.url}/squad");
      eachTeamViewModel.getTransfers("${widget.url}", 'transfers', context);
      eachTeamViewModel.getCups("${widget.url}/trophies");

      _controller.addListener(() {
        if (_controller.position.pixels ==
            _controller.position.maxScrollExtent) {
          if (tabController.index == 1) {
            newsPages++;
            eachTeamViewModel.getNews("${widget.url}/news", newsPages);
            print("hi");
          } else if (tabController.index == 2) {
            videosPages++;
            eachTeamViewModel.getVideos("${widget.url}/videos", videosPages);
          }
        }
      });
    });

    animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);

    _animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);

    animationController.forward();
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
            expandedHeight: 120.0,
            pinned: true,
            floating: true,
            snap: true,
            flexibleSpace: Consumer<EachTeamViewModel>(
              builder: (context, provider, child) {
                if (provider.headerProfileModel == null) {
                  return Center(
                    child: Container(),
                  );
                } else {
                  return FlexibleSpaceBar(
                    background: Container(
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 25, top: 60),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    height: 60,
                                    width: 55,
                                    child: Image.network(
                                        "https://www.eplworld.com${provider.headerProfileModel.logo}")),
                              ],
                            ),
                          ),
                          Positioned(
                              top: 100,
                              right: 100,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    provider.headerProfileModel.belongsTo.tr,
                                    style: TextStyle(
                                        fontFamily: 'Vazirmatn',
                                        color: Colors.white),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                    titlePadding:
                        EdgeInsets.only(top: 1.0, bottom: 20.0, right: 100),
                    title: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                provider.headerProfileModel.name.tr,
                                style: head,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
        Directionality(
            textDirection: TextDirection.rtl,
            child: SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                    maxHeight: 45,
                    minHeight: 45,
                    child: Consumer<EachTeamViewModel>(
                      builder: (context, provider, child) {
                        return Container(
                          color: Theme.of(context).primaryColor,
                          child: tabController == null
                              ? Container()
                              : TabBar(
                                  indicatorColor: Colors.white,
                                  isScrollable: true,
                                  onTap: (index) {
                                    _selectedIndex = index;
                                    tabController.animateTo(_selectedIndex);
                                  },
                                  controller: tabController,
                                  tabs: List.generate(tabName(provider).length,
                                          (index) => tabName(provider)[index])
                                      .toList()),
                        );
                      },
                    )))),
      ];
    }

    return new Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer<EachTeamViewModel>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SafeArea(
              child: NestedScrollView(
                controller: _controller,
                physics: ClampingScrollPhysics(),
                headerSliverBuilder: _sliverBuilder,
                body: TabBarView(
                  physics: ClampingScrollPhysics(),
                  controller: tabController = new TabController(
                      length: tabView(provider).length,
                      vsync: this,
                      initialIndex: _selectedIndex),
                  children: List.generate(tabView(provider).length,
                      (index) => tabView(provider)[index]),
                ),
              ),
            ),
          );
        },
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

  List<Widget> tabName(EachTeamViewModel provider) {
    List<Widget> test = [];
    if (provider.statsModel != null) {
      test.add(overViewN());
    }
    if (provider.newsModelList != null) {
      test.add(teamNewsN());
    }
    if (provider.videoModelList != null) {
      test.add(videoTeamN());
    }

    if (provider.recentMatcheBox != null) {
      test.add(matchesForTeamN());
    }
    if (provider.tablesModelList != null) {
      test.add(teamPositionN());
    }
    if (provider.squadsModel != null) {
      test.add(teamSquadN());
    }

    if (provider.transferBoxesModelList != null) {
      test.add(transferTeamN());
    }
    if (provider.trophiesBoxesModelList != null) {
      test.add(cupsN());
    }

    return test;
  }

  Widget overView() {
    return ListView(children: <Widget>[
      OverView(
        url: widget.url,
        id:widget.id
      )
    ]);
  }

  Widget teamNews() {
    return ListView(physics: NeverScrollableScrollPhysics(), children: <Widget>[
      TeamNews(
        url: widget.url,
      )
    ]);
  }

  Widget videoTeam() {
    return ListView(children: <Widget>[
      VideoTeam(
        url: widget.url,
      )
    ]);
  }

  Widget matchesForTeam() {
    return ListView(children: <Widget>[
      MatchesForTeam(
        url: widget.url,
      )
    ]);
  }

  Widget teamPosition() {
    return ListView(
      children: <Widget>[
        TeamPosition(
          url: widget.url,
          id: widget.id,
        )
      ],
    );
  }

  Widget teamSquad() {
    return ListView(children: <Widget>[
      teamTeam(
        url: widget.url,
      )
    ]);
  }

  Widget statisticsForTeam() {
    return ListView(children: <Widget>[statisticsForTeam()]);
  }

  Widget transferTeam() {
    return ListView(children: <Widget>[
      tranferTeam(
        url: widget.url,
      )
    ]);
  }

  Widget cups() {
    return ListView(children: <Widget>[
      Cups(
        url: widget.url,
      )
    ]);
  }

  List<Widget> tabView(EachTeamViewModel provider) {
    List<Widget> test = [];
    if (provider.statsModel != null) {
      test.add(overView());
    }
    if (provider.newsModelList != null) {
      test.add(teamNews());
    }
    if (provider.videoModelList != null) {
      test.add(videoTeam());
    }

    if (provider.recentMatcheBox != null) {
      test.add(matchesForTeam());
    }
    if (provider.tablesModelList != null) {
      test.add(teamPosition());
    }
    if (provider.squadsModel != null) {
      test.add(teamSquad());
    }

    if (provider.transferBoxesModelList != null) {
      test.add(transferTeam());
    }
    if (provider.trophiesBoxesModelList != null) {
      test.add(cups());
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
