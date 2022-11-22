
import 'dart:math';

import 'package:arseli/EachTeam/eachTeam.dart';
import 'package:arseli/Matches/EndMatches/Lineup.dart';
import 'package:arseli/Matches/MatchGPosition.dart';
import 'package:arseli/Matches/preConfron.dart';
import 'package:arseli/Provider/EachMatchViewModel.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:arseli/utils/Global.dart';
import 'package:arseli/utils/Socket_Response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../MatchPostion.dart';
import 'MatchStats.dart';
import 'matchEvent_a.dart';

class matchInfo_a extends StatefulWidget {
  String homeId;
  String awayId;
  String url;
  String comName;

  matchInfo_a({this.url, this.homeId, this.awayId, this.comName});

  @override
  _matchInfo_aState createState() => _matchInfo_aState();
}

class _matchInfo_aState extends State<matchInfo_a>
    with TickerProviderStateMixin {


  static const TextStyle tapbar = TextStyle(
      fontFamily: 'Vazirmatn',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white);

  bool chContaier = false;
  double heightOfgoals = 65;

  ScrollController _scrollController = new ScrollController();

  TabController tabController;
  int _selectedIndex = 0;

  AnimationController animationController;
  Animation<double> _animation;

  EachMatchViewModel eachMatchViewModel;
  bool _connectedToSocket;
  String _connectMessage;

  Future getData() async {
    await Future.wait([
      eachMatchViewModel.getMSN(widget.url, context),
      eachMatchViewModel.getMatchEndEvent(widget.url),
      eachMatchViewModel.getMatchLineups(widget.url),
      eachMatchViewModel.getTables(widget.url),
      eachMatchViewModel.getMatchStats(widget.url),
      eachMatchViewModel.getHTHMatch(widget.url),
    ]);
  }

  _connectTosocket() async {
    G.initSocket();
    await G.socketUtils.initSocket();
    G.socketUtils.connectToSocket();
    G.socketUtils.setOnconnectListener(onConnect);
    G.socketUtils.setOnConnectionErrorListener(onConnectionError);
    G.socketUtils.setOnconnectionTimeOutListener(onConnectionTimeout);
    G.socketUtils.setOnDisconnectListener(onDisconnect);
    G.socketUtils.setOnErrorListener(onError);
    G.socketUtils.setOnMessageReceived(onMessageReceived);
  }

  onConnect(data) {
    if (mounted) {
      setState(() {
        _connectedToSocket = true;
        _connectMessage = 'Connected';
        print(_connectMessage);
      });
    }
  }

  onMessageReceived(data) {
    if (mounted) {
      setState(() {
        _connectedToSocket = false;
        _connectMessage = 'message each League ';
        print(_connectMessage + "--> id ==>" + SocketResponse.fromJson(data).id);
        eachMatchViewModel.getMatchEndEvent(widget.url);
         getData();
      });
    }
  }

  onConnectionError(data) {
    if (mounted) {
      setState(() {
        _connectedToSocket = false;
        _connectMessage = 'Connection Error';
        print(_connectMessage + data.toString());
      });
    }
  }

  onConnectionTimeout(data) {
    if (mounted) {
      setState(() {
        _connectedToSocket = false;
        _connectMessage = 'Connection Timeout';
        print(_connectMessage);
      });
    }
  }

  onError(data) {
    if (mounted) {
      setState(() {
        _connectedToSocket = false;
        _connectMessage = 'Connection Error';
        print(_connectMessage);
      });
    }
  }

  onDisconnect(data) {
    if (mounted) {
      setState(() {
        _connectedToSocket = false;
        _connectMessage = 'Disconnected';
        print(_connectMessage);
      });
    }
  }


  HeightOfGoals(){
    eachMatchViewModel.eventsModel.forEach((element) {
      if(element.details.name == 'goal'){
        heightOfgoals = heightOfgoals + 35;
      }else
        {
          heightOfgoals = heightOfgoals + 0.0;
        }
    });
  }

  @override
  void initState() {
    print('initState');
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {

      eachMatchViewModel = Provider.of(context, listen: false);
      await getData();
      final provider = eachMatchViewModel;
      tabs = _tabs(provider);
      tabView = _tabView(provider);
      tabController = new TabController(
        length: tabView.length,
        vsync: this,
      );
      HeightOfGoals();

      setState(() {});

      animationController = AnimationController(
          duration: const Duration(seconds: 1), vsync: this);

      _animation =
          CurvedAnimation(parent: animationController, curve: Curves.easeIn);

      animationController.forward();
      // print("FromMatchInfo${widget.url}");
    });
  }

  List<Widget> tabs;
  List<Widget> tabView;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() async {
    super.dispose();
    tabController.dispose();
    G.socketUtils.closeConnection();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      _connectedToSocket = false;
      _connectMessage = 'Connecting...';
      _connectTosocket();
    });
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
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        onPressed: null),
                  ],
                )
              ],
              expandedHeight: 130.0,
              pinned: true,
              floating: true,
              snap: true,
              flexibleSpace: Consumer<EachMatchViewModel>(
                  builder: (context, provider, child) {
                return provider.loadingMsn
                    ? Center(
                        child: Container(),
                      )
                    : FlexibleSpaceBar(
                        background: Padding(
                          padding: const EdgeInsets.only(bottom: 75, left: 40,),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              /*
                              IconButton(
                                  icon: Icon(
                                    Icons.notifications_none,
                                    color: Colors.white,
                                  ),
                                  onPressed: null),

                               */
                              IconButton(
                                  icon: Icon(Icons.star_border,
                                      color: Colors.white),
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
                                    Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (context) => ChangeNotifierProvider<EachTeamViewModel>(create: (_) => EachTeamViewModel(),
                                                    child: EachTeam(
                                                      url: provider.msnModel.homeTeamURL,
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
                                  "${provider.msnModel.homeTeamScores} - ${provider.msnModel.awayTeamScores}",
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
                                                      url: provider
                                                          .msnModel.awayTeamURL,
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
              })),
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: SliverPersistentHeader(
            delegate: _SliverAppBarDelegate1(
                minHeight: 45.0,
                maxHeight: 50,
                child: Consumer<EachMatchViewModel>(
                  builder: (context, provider, child) {
                    return provider.msnModel == null
                        ? Container(
                            color: Theme.of(context).primaryColor
                          )
                        : Container(
                            color: Theme.of(context).primaryColor,
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 40,
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
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 40,
                                          width: MediaQuery.of(context).size.width * .5,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 30),
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
                                  ],
                                ),
                                Positioned(
                                  right: MediaQuery.of(context).size.width*.2,
                                  left: MediaQuery.of(context).size.width*.2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width * .2,
                                        child: Center(
                                          child: Text(
                                            provider.msnModel.matchStatus ==
                                                'Playing'
                                                ? provider.msnModel.matchTime
                                                .toString()
                                                : "نهايه اللقاء",
                                            style: TextStyle(
                                                fontFamily: 'Vazirmatn',
                                                color: Colors.white,
                                                fontSize: 15,fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      /*
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Container(
                                          child: Column(
                                              children:List.generate(provider.eventsModel.length, (index){
                                                return event(index);
                                              })),
                                        ),
                                      )

                                       */
                                    ],
                                  ),
                                ),
                              ],
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
                        child: TabBar(
                            indicatorColor: Colors.white,
                            labelColor: Theme.of(context).primaryColor,
                            isScrollable: true,
                            onTap: (index) {
                              _selectedIndex = index;
                              tabController.animateTo(_selectedIndex);
                            },
                            controller: this.tabController,
                            // controller: tabController,
                            tabs:tabs),
                      );
                    },
                  ))),
        ),
      ];
    }

    return new Directionality(
        textDirection: TextDirection.rtl,
        child: Consumer<EachMatchViewModel>(
          builder: (context, provider, child) {
            return Scaffold(
                body: this.tabView == null
                    ? Center(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : SafeArea(
                        child: NestedScrollView(
                          headerSliverBuilder: _sliverBuilder,
                          body: TabBarView(
                              controller: tabController,
                              children: tabView),
                        ),
                      ));
          },
        ));
  }

  Widget _goal(index) {
    return Consumer<EachMatchViewModel>(builder: (context, provider, child) {
      return Directionality(
        textDirection: provider.eventsModel[index].linkedTo == 'home'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8)
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 1,bottom: 1,right: 10,left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  MdiIcons.soccer,
                  size: 13,
                  color: Colors.black,
                ),
                SizedBox(width: 4,),
                Container(
                  child: Text(
                      provider.eventsModel[index].details.time.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12)
                  ),
                ),
                SizedBox(width: 3,),
                Text(provider.eventsModel[index].details.belongsToName,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),)
              ],
            ),
          ),
        ),
      );
    });
  }
  Widget event(index) {
    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 2),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Consumer<EachMatchViewModel>(
          builder: (context, provider, child) {
            return provider.eventsModel[index].linkedTo == "home"
                ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    child: provider.eventsModel[index].details.name == "goal"
                        ? _goal(index)
                        : Container()),
              ],
            )
                : provider.eventsModel[index].linkedTo == "away"
                ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: provider.eventsModel[index].details.name ==
                      "goal"
                      ? _goal(index)
                      : Container(),
                ),
              ],
            )
                :Container();
          },
        ),
      ),
    );
  }

  Widget matchEventName() {
    return Tab(
      child: Text(
        "احداث المبارة".tr,
        style: tapbar,
      ),
    );
  }

  Widget lineUpName() {
    return Tab(
      child: Text(
        "تشكيلة".tr,
        style: tapbar,
      ),
    );
  }

  Widget statsName() {
    return Tab(
      child: Text(
        "إحصائيات".tr,
        style: tapbar,
      ),
    );
  }

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
        "المواجهات السابقة".tr,
        style: tapbar,
      ),
    );
  }


  List<Widget> _tabs(EachMatchViewModel provider) {
    List<Widget> test = [];
    if (provider.eventsModel != null) {
      test.add(matchEventName());
    }
    if (provider.lineupsModel != null) {
      test.add(lineUpName());
    }
    if (provider.sortedStatsModelMatch != null) {
      test.add(statsName());
    }
    if (provider.tablesModelList[0].list.isNotEmpty) {
      test.add(matchTableName());
    }

    if (provider.headToHeadModel != null) {
      test.add(matchHTHName());
    }
    return test;
  }

  Widget matchEvent() {
    return ListView(children: <Widget>[MatchEvent_a(url: widget.url,homeId: widget.homeId,awayId: widget.awayId,)]);
  }

  Widget lineUp(String matchID) {
    return Lineup(url: widget.url, matchID: matchID);
  }

  Widget stats() {
    return MatchStats(
      url: widget.url,
    );
  }

  Widget matchTable() {
    return ListView(
      children: [
        MatchPostions(
          url: widget.url,
          homeId: widget.homeId,
          awayId: widget.awayId,
        ),
      ],
    );
  }

  Widget matchGTable() {
    return ListView(
      children: [
        MatchGPosition(
          url: widget.url,
          homeId: widget.homeId,
          awayId: widget.awayId,
        ),
      ],
    );
  }

  Widget matchHTH() {
    return ListView(children: <Widget>[
      PreConfront(
        url: widget.url,
      )
    ]);
  }

  List<Widget> _tabView(EachMatchViewModel provider) {
    List<Widget> test = [];
    if (provider.eventsModel != null) {
      test.add(matchEvent());
    }
    if (provider.lineupsModel != null) {
      test.add(lineUp(provider.msnModel.matchID));
    }
    if (provider.sortedStatsModelMatch != null) {
      test.add(stats());
    }

    if (provider.tablesModelList[0].list.isNotEmpty &&
        provider.tablesModelList[0].list.length == 1) {
      test.add(matchTable());
    }
    if (provider.tablesModelList[0].list.isNotEmpty &&
        provider.tablesModelList[0].list.length > 1) {
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

class ShapesPointer2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = Color.fromRGBO(0, 147, 92, 1.0);
    var rect = Rect.fromLTWH(0, 0, size.width, 850);
    canvas.drawRect(rect, paint);

    paint.color = Color.fromRGBO(26, 158, 109, 1.0);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    var rectbig = Rect.fromLTWH(size.width / 4.5, 0, 225, 100);
    canvas.drawRect(rectbig, paint);

    paint.color = Color.fromRGBO(26, 158, 109, 1.0);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    var rectsmall = Rect.fromLTWH(size.width / 2.77, 0, 112, 50);
    canvas.drawRect(rectsmall, paint);

    paint.color = Color.fromRGBO(26, 158, 109, 1.0);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    var rectbig1 = Rect.fromLTWH(size.width / 4.5, 750, 225, 100);
    canvas.drawRect(rectbig1, paint);

    paint.color = Color.fromRGBO(26, 158, 109, 1.0);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    var rectsmall1 = Rect.fromLTWH(size.width / 2.77, 800, 112, 50);
    canvas.drawRect(rectsmall1, paint);

    final rect3 = Rect.fromLTRB(150, 50, 260, 125);
    final startAngle = pi / 9;
    final sweepAngle = pi / 1.3;
    final useCenter = false;
    paint.color = Color.fromRGBO(26, 158, 109, 1.0);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    canvas.drawArc(rect3, startAngle, sweepAngle, useCenter, paint);

    final rect4 = Rect.fromLTRB(150, 720, 260, 820);
    final startAngle2 = -pi / 9;
    final sweepAngle2 = -pi / 1.3;
    final useCenter2 = false;
    paint.color = Color.fromRGBO(26, 158, 109, 1.0);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    canvas.drawArc(rect4, startAngle2, sweepAngle2, useCenter2, paint);

    paint.color = Color.fromRGBO(26, 158, 109, 1.0);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    var center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, 60.0, paint);

    paint.color = Color.fromRGBO(26, 158, 109, 1.0);
    var line1 = Offset(size.width, size.height / 2);
    var line2 = Offset(0, size.height / 2);
    canvas.drawLine(line1, line2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
