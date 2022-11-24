import 'package:arseli/Playrers/playerMatches.dart';
import 'package:arseli/Playrers/playerStatistics.dart';
import 'package:arseli/Playrers/playerTransference.dart';
import 'package:arseli/Playrers/profile.dart';
import 'package:arseli/Provider/EachPlayerViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EachPlayer extends StatefulWidget {
  String url;
  String teamImg;
  EachPlayer({this.url, this.teamImg});
  @override
  _EachPlayerState createState() => _EachPlayerState();
}

class _EachPlayerState extends State<EachPlayer> with TickerProviderStateMixin {
  static const TextStyle tapbar = TextStyle(
      fontFamily: 'Vazirmatn',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white);
  TextStyle head = TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 16,
  );

  bool chContaier = false;
  ScrollController _scrollController = new ScrollController();

  TabController tabController;
  int _selectedIndex = 0;

  AnimationController animationController;
  Animation<double> _animation;

  EachplayerViewModel eachplayerViewModel;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      eachplayerViewModel = Provider.of(context, listen: false);
      eachplayerViewModel.getHeaderProfile(widget.url, context);
    });

    tabController = new TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {
        _selectedIndex = tabController.index;
      });
      print(tabController.index.toString());
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
    tabController.dispose();
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
                        Icons.people,
                        color: Colors.white,
                      ),
                      onPressed: null),
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
            flexibleSpace: Consumer<EachplayerViewModel>(
              builder: (context, provider, child) {
                return provider.loadingHeader
                    ? Center(
                        child: Container(),
                      )
                    : FlexibleSpaceBar(
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
                                        height: 55,
                                        width: 55,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100)),
                                            child: provider.headerProfileModel == null
                                                ? CircularProgressIndicator()
                                                : Image.network(
                                                    "https://www.eplworld.com${provider.headerProfileModel.logo}",
                                                  ))),
                                  ],
                                ),
                              ),
                              Positioned(
                                  top: 105,
                                  right: 95,
                                  child: Row(
                                    children: <Widget>[
                                      widget.teamImg == null
                                          ? Container()
                                          : Container(
                                              height: 25,
                                              width: 25,
                                              child: Image.network(
                                                  "https://www.eplworld.com${widget.teamImg}"),
                                            ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        provider.headerProfileModel.belongsTo
                                                .isBlank
                                            ? ""
                                            : provider.headerProfileModel
                                                .belongsTo.tr,
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
                        titlePadding:
                            EdgeInsets.only(top: 1.0, bottom: 20.0, right: 100),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  provider.headerProfileModel.name.tr,
                                  style: TextStyle(
                                      fontFamily: 'Vazirmatn', fontSize: 18),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
              },
            ),
          ),
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: DefaultTabController(
            length: 2,
            child: SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                  maxHeight: 60,
                  minHeight: 45,
                  child:Container(
                    height: 60,
                    color: Theme.of(context).backgroundColor,
                    child: TabBar(
                        indicatorColor: Colors.white,
                        labelColor: Theme.of(context).primaryColor,
                        isScrollable: true,
                        controller: tabController,
                        onTap: (index) {
                          setState(() {
                            if (index == 1) {}
                          });
                          },
                    tabs: [
                      Tab(
                        child: Text(
                          "الملف الشخصي".tr,
                          style: tapbar,
                        ),
                      ),
                      /*

                      Tab(
                        child: Text(
                          "احصائيات".tr,
                          style: tapbar,
                        ),
                      ),

                       */
                      Tab(
                        child: Text(
                          "المهنه".tr,
                          style: tapbar,
                        ),
                      ),
                      /*
                      Tab(
                        child: Text(
                          "المباريات".tr,
                          style: tapbar,
                        ),
                      ),

                       */
                      /*
                      Tab(
                        child: Text(
                          "انتقالات".tr,
                          style: tapbar,
                        ),
                      ),

                       */
                    ]),
                  )),
            ),
          ),
        ),
      ];
    }

    return new Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: _sliverBuilder,
            body: new TabBarView(controller: tabController, children: [
              ListView(children: <Widget>[
                profile(url: widget.url, teamImg: widget.teamImg)
              ]),
              //ListView(children: <Widget>[playerMatches()]),
              ListView(children: <Widget>[playerStatistics(url: widget.url)]),
              /*
              ListView(children: <Widget>[playerMatches(url: widget.url)]),

               */

              // ListView(children: <Widget>[playerTransference()]),
            ]),
          ),
        ),
      ),
    );
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
