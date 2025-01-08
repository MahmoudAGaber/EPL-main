
import 'package:epl/Data/StateModel.dart';
import 'package:epl/presentation/playrers/screens/playerStatistics.dart';
import 'package:epl/presentation/playrers/screens/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../provider/PlayerViewModel.dart';


class Players extends ConsumerStatefulWidget {
  String? playerId;
  Players({this.playerId});
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends ConsumerState<Players> with TickerProviderStateMixin {
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

  TabController? tabController;
  int _selectedIndex = 0;

  AnimationController? animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      print("PlayerId${widget.playerId}");

      ref.read(PlayerProvider.notifier).getPlayer(widget.playerId);
    });

    tabController = new TabController(length: 2, vsync: this);
    tabController!.addListener(() {
      setState(() {
        _selectedIndex = tabController!.index;
      });
      print(tabController!.index.toString());
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
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var player = ref.watch(PlayerProvider);
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
            flexibleSpace: player.handelState(
              onLoading: (state)=> SizedBox(),
              onSuccess: (state)=> FlexibleSpaceBar(
                background: Container(
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 25, top: 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                height: 55,
                                width: 55,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                    child: CircleAvatar())),
                          ],
                        ),
                      ),
                      Positioned(
                          top: 105,
                          right: 80,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                height: 25,
                                width: 25,
                                child: CircleAvatar(),
                              ),
                              SizedBox(width: 10,),
                              Text("",
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
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12,),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width *.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 12,),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Flexible(
                                child: Text("${player.data!.person.firstName } ${player.data!.person.lastName }",
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18,color: Colors.white),overflow: TextOverflow.clip,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              onFailure: (state)=> SizedBox()
            )

          ),
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: DefaultTabController(
            length: 2,
            child: SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                  maxHeight: 45,
                  minHeight: 40,
                  child:Container(
                    height: 60,
                    color: Theme.of(context).primaryColor,
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

    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: _sliverBuilder,
            body:  TabBarView(controller: tabController, children: [
              ListView(children: <Widget>[
                PlayerProfile()
              ]),
              //ListView(children: <Widget>[playerMatches()]),
              ListView(children: <Widget>[playerCareer()]),
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
