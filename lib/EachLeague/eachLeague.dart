import 'dart:async';

import 'package:arseli/EachLeague/MatchGPosition.dart';
import 'package:arseli/EachLeague/cups.dart';
import 'package:arseli/EachLeague/playersStats.dart';
import 'package:arseli/EachLeague/postions.dart';
import 'package:arseli/EachLeague/teamsStats.dart';
import 'package:arseli/EachLeague/transferCenter.dart';
import 'package:arseli/Models/Leagues/Tournaments.dart';
import 'package:arseli/Provider/EachLeagueViewModel.dart';
import 'package:arseli/utils/Global.dart';
import 'package:arseli/utils/Socket_Response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


import 'leagueNews.dart';
import 'matchsForLeague.dart';

class EachLeague extends StatefulWidget {
  String url;
  String comName;
  EachLeague({this.url,this.comName});
  @override
  _EachLeagueState createState() => _EachLeagueState();
}

class _EachLeagueState extends State<EachLeague> with TickerProviderStateMixin {

  EachLeagueViewModel oneLeagueViewModel;
  ScrollController _controller = ScrollController();

  TextStyle tapbar = TextStyle(
      fontSize: 13, color: Colors.white
  );
  TextStyle head = TextStyle(
      fontSize: 16, color: Colors.white
  );


  bool chContaier = false;

  TabController tabController;
  ScrollController scrollController;
  int _selectedIndex = 0;
  int page=1;

  AnimationController animationController;
  Animation<double> _animation;

  List<Widget>tabNamee=[];
  List<Widget>tabVieww=[];


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
    setState(() {
      _connectedToSocket = true;
      _connectMessage = 'Connected';
      print(_connectMessage);
    });
  }

  onMessageReceived(data) {
    setState(() {
      _connectedToSocket = false;
      _connectMessage = 'message each League ';
      print(_connectMessage+"--> id ==>"+SocketResponse.fromJson(data).id);

      getData();
    });
  }

  onConnectionError(data) {
    setState(() {
      _connectedToSocket = false;
      _connectMessage = 'Connection Error';
      print(_connectMessage+data.toString());
    });
  }

  onConnectionTimeout(data) {
    setState(() {
      _connectedToSocket = false;
      _connectMessage = 'Connection Timeout';
      print(_connectMessage);
    });
  }

  onError(data) {
    setState(() {
      _connectedToSocket = false;
      _connectMessage = 'Connection Error';
      print(_connectMessage);
    });
  }

  onDisconnect(data) {
    setState(() {
      _connectedToSocket = false;
      _connectMessage = 'Disconnected';
      print(_connectMessage);
    });
  }







  @override
  void initState() {
    _connectedToSocket = false;
    _connectMessage = 'Connecting...';
    _connectTosocket();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      oneLeagueViewModel = Provider.of(context, listen: false);

/*
      oneLeagueViewModel.headerProfile(widget.url, '',context);
      await oneLeagueViewModel.getTables(widget.url, 'tables',);
      oneLeagueViewModel.getMatches(widget.url, '/matches');
      oneLeagueViewModel.getNews('${widget.url}', 'news');
      oneLeagueViewModel.getPlayersStats("${widget.url}");
      oneLeagueViewModel.getTeamsStats('${widget.url}');

 */
     getData();


      _controller.addListener(() {
        if (_controller.position.pixels ==
            _controller.position.maxScrollExtent) {
          page++;
          oneLeagueViewModel.getNews(widget.url,'news',page);
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

  void getData(){
      oneLeagueViewModel.getNews('${widget.url}', 'news', 1);
      oneLeagueViewModel.all(widget.url);
      oneLeagueViewModel.getTables(widget.url, 'tables',);
      oneLeagueViewModel.getPlayersStats("${widget.url}");
      oneLeagueViewModel.getTeamsStats('${widget.url}');
      oneLeagueViewModel.getTransfers("${widget.url}", 'transfers',);
      oneLeagueViewModel.getCups("${widget.url}/trophies");


  }

  @override
  void dispose() {
     //tabController.dispose();
    G.socketUtils.closeConnection();
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
                  backgroundColor: Theme
                      .of(context)
                      .primaryColor,
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
                  flexibleSpace: Consumer<EachLeagueViewModel>(
                    builder: (context, provider, child) {
                     // tabNamee = tabName(provider);
                      //tabVieww = tabView(provider);
                      //tabController = new TabController(length: tabVieww.length, vsync: this, initialIndex: _selectedIndex);
                      //provider.toggleLoading(false);
                      return provider.loadingMatches
                          ? Center(child: Container(),)
                          : FlexibleSpaceBar(
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
                                            "https://www.eplworld.com${provider
                                                .headerProfileModel.logo}")),
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
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        //centerTitle: true,
                        titlePadding: EdgeInsets.only(top: 1.0, bottom: 20.0,left: 4,right: 100),
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
                                        provider.headerProfileModel.name.tr,
                                        style: head,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
        Directionality(
                  textDirection: TextDirection.rtl,
                  child:SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                          maxHeight: 45,
                          minHeight: 45,
                          child:Selector<EachLeagueViewModel,bool>(
                            selector: (context,modelProvider)=>modelProvider.loadingMatches,
                            builder: (context,loading,child){
                              return loading?Container()
                                  :Container(
                                color: Theme.of(context).primaryColor,
                                child: DefaultTabController(
                                  length: tabName(oneLeagueViewModel).length,
                                  child: TabBar(
                                      indicatorColor: Colors.white,
                                      isScrollable: true,
                                      onTap: (index){
                                        _selectedIndex = index;
                                        tabController.animateTo(_selectedIndex);
                                      },
                                      controller:  tabController,
                                      tabs: List.generate(tabName(oneLeagueViewModel).length, (index) => tabName(oneLeagueViewModel)[index]).toList()
                                  ),
                                ),
                              );
                            },
                          )
                      ))
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
                body: Selector<EachLeagueViewModel,bool>(
                  selector: (context,modelProvider)=>modelProvider.loadingMatches,
                builder: (context,loading,child) {
                  return loading
                          ?Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,),)
                          :TabBarView(
                    controller: tabController = new TabController(length: tabView(oneLeagueViewModel).length, vsync: this, initialIndex: _selectedIndex),
                    children:List.generate(tabView(oneLeagueViewModel).length, (index) => tabView(oneLeagueViewModel)[index]).toList());
                }),
              ),
            ),
      ),
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


  List<Widget> tabName(EachLeagueViewModel provider) {
    List<Widget> test = [];

      if (provider.tablesModelList != null) {
        test.add(PositionN());
      }


      if (provider.recentMatcheBox != null) {
        test.add(matchesN());
      }



      if (provider.newsModelList != null) {
        test.add(NewsN());
      }


      if (provider.playersModel != null) {
        test.add(playersStatsN());
      }


      if (provider.teamsModel != null) {
        test.add(teamsStatsN());
      }

      if (provider.transferBoxesModelList != null) {
        test.add(transferN());
      }


      if (provider.trophiesBoxesModelList != null) {
        test.add(cupsN());
      }

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
    return ListView(children: <Widget>[Postions(url: widget.url,)]);
  }

  Widget positionGTable() {
    return ListView(children: <Widget>[MatchGPosition(url: widget.url,)]);
  }

  Widget matches() {
    return ListView(children: <Widget>[matchesForLeague(url: widget.url)]);
  }

  Widget News() {
    return ListView(children:<Widget>[ leagueNews(url: widget.url)]);
  }

  Widget playerStats() {
    return ListView(children: <Widget>[playersStats(url: widget.url,)]);
  }

  Widget teamStats() {
    return ListView(children: <Widget>[teamsStats(url:widget.url)]);
  }

  Widget transfers() {
    return ListView(
      physics: ClampingScrollPhysics(), scrollDirection: Axis.vertical,
      shrinkWrap: true, children: <Widget>[TransferCenter(url: widget.url)],);
  }

  Widget cups() {
    return ListView(children: <Widget>[Cups(url: widget.url,)]);
  }


  List<Widget> tabView(EachLeagueViewModel provider) {
    List<Widget> test = [];

      if (provider.tablesModelList !=null  && provider.tablesModelList[0].list.length == 1) {
        test.add(position());
      }

      if (provider.tablesModelList != null && provider.tablesModelList[0].list.length > 1) {
        test.add(positionGTable());
      }

      if (provider.recentMatcheBox !=null ) {
        test.add(matches());
      }


      if (provider.newsModelList != null) {
        test.add(News());
      }

      if (provider.playersModel != null) {
        test.add(playerStats());
      }

      if (provider.teamsModel != null) {
        test.add(teamStats());
      }

      if (provider.transferBoxesModelList != null) {
        test.add(transfers());
      }

      if (provider.trophiesBoxesModelList != null) {
        test.add(cups());
      }

    return test;
  }


/*
  List<Widget> tabView(url) {
    List<Widget> test = [];
      test.add(Position(url));
      test.add(matches(url));
      test.add(News(url));
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

