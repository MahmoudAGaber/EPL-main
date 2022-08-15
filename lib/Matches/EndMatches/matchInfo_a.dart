import 'package:arseli/EachLeague/postions.dart';
import 'package:arseli/EachTeam/eachTeam.dart';
import 'package:arseli/Matches/EndMatches/Lineup.dart';
import 'package:arseli/Matches/MatchGPosition.dart';
import 'package:arseli/Matches/preConfron.dart';
import 'package:arseli/Provider/EachMatchViewModel.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:arseli/Provider/MatchesViewModel.dart';
import 'package:arseli/utils/Global.dart';
import 'package:arseli/utils/Socket_Response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:get/get.dart';
import '../MatchPostion.dart';
import 'MatchStats.dart';
import 'matchEvent_a.dart';

class matchInfo_a extends StatefulWidget {
  String homeId;
  String awayId;
  String url;
  String comName;

  matchInfo_a({this.url,this.homeId,this.awayId,this.comName});

  @override
  _matchInfo_aState createState() => _matchInfo_aState();
}

class _matchInfo_aState extends State<matchInfo_a>
    with TickerProviderStateMixin {


  TextStyle content = TextStyle(fontSize: 13.5);
  TextStyle content2 = TextStyle(fontSize: 13.5, color: Colors.grey);
  TextStyle content3 = TextStyle(fontSize: 12);
  TextStyle content4 = TextStyle(fontSize: 12, color: Colors.grey);
  TextStyle number = TextStyle(fontSize: 18, fontWeight: FontWeight.w400);

  static const TextStyle tapbar =
  TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black);
  TextStyle head = TextStyle(
      fontSize: 16, color: Colors.white
  );

  bool chContaier = false;

  ScrollController _scrollController = new ScrollController();

  TabController tabController;
  int _selectedIndex = 0;

  AnimationController animationController;
  Animation<double> _animation;

  EachMatchViewModel eachMatchViewModel;
  bool _connectedToSocket;
  String _connectMessage;


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
        print(_connectMessage + "--> id ==>" + SocketResponse
            .fromJson(data)
            .id);
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


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async{
      eachMatchViewModel = Provider.of(context, listen: false);
     getData();
      animationController =
          AnimationController(duration: const Duration(seconds: 1), vsync: this);

      _animation =
          CurvedAnimation(parent: animationController, curve: Curves.easeIn);

      animationController.forward();
      // print("FromMatchInfo${widget.url}");
    });



    super.initState();
  }

  @override
  void dispose() async{
    super.dispose();
    tabController.dispose();
    G.socketUtils.closeConnection();

  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero,(){
      _connectedToSocket = false;
      _connectMessage = 'Connecting...';
      _connectTosocket();
    });

    List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        Directionality(
          textDirection: TextDirection.rtl,
          child: SliverAppBar(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 0.0,
              actions: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.black,
                        ),
                        onPressed: null),
                  ],
                )
              ],
              expandedHeight: 120.0,
              pinned: true,
              floating: true,
              snap: true,
              flexibleSpace: Consumer<EachMatchViewModel>(
                  builder: (context, provider, child) {
                    return provider.loadingMsn
                        ? Center(child: Container(),)
                        : FlexibleSpaceBar(
                      background: Padding(
                        padding: const EdgeInsets.only(bottom: 63, left: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.notifications_none,
                                  color: Colors.black,
                                ),
                                onPressed: null),
                            IconButton(
                                icon: Icon(Icons.star_border, color: Colors.black),
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
                                          builder:(context)=>  ChangeNotifierProvider<EachTeamViewModel>(
                                              create: (_) => EachTeamViewModel(),
                                              child: EachTeam(
                                                url: provider.msnModel.homeTeamURL,
                                                id: widget.homeId,)
                                          ))
                                  );
                                },
                                child: Container(
                                    width: 40,
                                    height: 30,
                                    child: Image.network(
                                        "https://www.eplworld.com${provider
                                            .msnModel.homeTeamLogo}")),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "${provider.msnModel
                                    .homeTeamScores} - ${provider.msnModel
                                    .awayTeamScores}",
                                style: TextStyle(fontSize: 18,color: Colors.black),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                          builder:(context)=>  ChangeNotifierProvider<EachTeamViewModel>(
                                              create: (_) => EachTeamViewModel(),
                                              child: EachTeam(
                                                url: provider.msnModel.homeTeamURL,
                                                id: widget.awayId,)
                                          ))
                                  );
                                },
                                child: Container(
                                    width: 40,
                                    height: 30,
                                    child: Image.network(
                                        "https://www.eplworld.com${provider
                                            .msnModel.awayTeamLogo}")),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  })
          ),
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: SliverPersistentHeader(
            delegate: _SliverAppBarDelegate1(
                minHeight: 45.0,
                maxHeight: 60,
                child: Consumer<EachMatchViewModel>(
                  builder: (context, provider, child) {
                    return provider.msnModel == null
                        ? Container(color:Colors.white,)
                        : Container(
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * .4,
                                child: Center(
                                  child: Text(
                                    provider.msnModel.homeTeamName.tr,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * .2,
                                child: Center(
                                  child: Text(
                                    provider.msnModel.matchStatus == 'Playing'
                                        ? provider.msnModel.matchTime.toString()
                                        : "انتهت",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * .4,
                                child: Center(
                                  child: Text(
                                    provider.msnModel.awayTeamName.tr,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
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
                  maxHeight: 45,
                  minHeight: 45,
                  child:Consumer<EachMatchViewModel>(
                    builder: (context,provider,child){
                      return Container(
                        color: Colors.white,
                        child: TabBar(
                            indicatorColor: Theme.of(context).primaryColor,
                            isScrollable: true,
                            onTap: (index){
                              _selectedIndex = index;
                              tabController.animateTo(_selectedIndex);
                            },
                            controller: tabController,
                            tabs: List.generate(tabName(provider).length, (index) => tabName(provider)[index]).toList()
                        ),
                      );
                    },
                  )

              )),
        ),
      ];
    }

    return new Directionality(
        textDirection: TextDirection.rtl,
        child: Consumer<EachMatchViewModel>(
          builder: (context, provider, child) {
            return Scaffold(
                body: SafeArea(
                  child: NestedScrollView(
                    headerSliverBuilder: _sliverBuilder,
                    body: TabBarView(
                        controller: tabController = new TabController(length: tabView(provider).length, vsync: this,initialIndex: _selectedIndex),
                        children:List.generate(tabView(provider).length, (index) => tabView(provider)[index]).toList()),
                  ),
                ));
          },

        ));
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
  List<Widget> tabName(EachMatchViewModel provider) {
    List<Widget> test = [];
    if (provider.eventsModel != null) {
      test.add(matchEventName());
    }
    if (provider.lineupsModel != null) {
      test.add(lineUpName());
    }
    if(provider.sortedStatsModelMatch!=null) {
      test.add(statsName());

    }
    if (provider.tablesModelList != null) {
      test.add(matchTableName());
    }

    if (provider.headToHeadModel != null) {
      test.add(matchHTHName());
    }
    return test;
  }


  Widget matchEvent(){
    return  ListView(
        children: <Widget>[MatchEvent_a(url: widget.url)]);

  }
  Widget lineUp(String matchID){

    return  Lineup(url: widget.url,matchID:matchID);

  }
  Widget stats(){
    return MatchStats(url: widget.url,);

  }
  Widget matchTable(){
    return  ListView(
      children: [
        MatchPostions(
          url: widget.url,
          homeId: widget.homeId,
          awayId: widget.awayId,),
      ],);

  }
  Widget matchGTable(){
    return  ListView(
      children: [
        MatchGPosition(
          url: widget.url,
          homeId: widget.homeId,
          awayId: widget.awayId,),
      ],);

  }
  Widget matchHTH(){
    return  ListView(
        children: <Widget>[PreConfront(url: widget.url,)]);




  }
  List<Widget> tabView(EachMatchViewModel provider){
    List<Widget> test = [];
    if(provider.eventsModel!=null){
      test.add(matchEvent());
    }
    if(provider.lineupsModel!=null){
      test.add(lineUp(provider.msnModel.matchID));
    }
    if(provider.sortedStatsModelMatch!=null){
      test.add(stats());
    }

    if(provider.tablesModelList!=null&&provider.tablesModelList[0].list.length==1){
      test.add(matchTable());
    }
    if(provider.tablesModelList!=null&&provider.tablesModelList[0].list.length>1){
      test.add(matchGTable());
    }

    if(provider.headToHeadModel!=null){
      test.add(matchHTH());
    }

    return test;
  }

  void getData() async{
    eachMatchViewModel.getMSN(widget.url,context);
    await eachMatchViewModel.getMatchEndEvent(widget.url);
    eachMatchViewModel.getMatchLineups(widget.url);
    eachMatchViewModel.getTables(widget.url);
    eachMatchViewModel.getMatchStats(widget.url);
    eachMatchViewModel.getHTHMatch(widget.url);
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

