
import 'package:arseli/EachTeam/eachTeam.dart';
import 'package:arseli/Matches/MatchPostion.dart';
import 'package:arseli/Matches/MatchGPosition.dart';
import 'package:arseli/Matches/preConfron.dart';
import 'package:arseli/Provider/EachMatchViewModel.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'MatchEvent.dart';

class matchInfo extends StatefulWidget {
  String homeId;
  String awayId;
  String url;
  String comName;

  matchInfo({this.url, this.homeId, this.awayId,this.comName});

  @override
  _matchInfoState createState() => _matchInfoState();
}

class _matchInfoState extends State<matchInfo> with TickerProviderStateMixin {

  static const TextStyle tapbar = TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white);
  TextStyle head = TextStyle(fontSize: 16, color: Colors.white);


  TabController tabController;
  int _selectedIndex = 0;
  EachMatchViewModel eachMatchViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async{
        eachMatchViewModel = Provider.of(context, listen: false);
        eachMatchViewModel.getMSN(widget.url,context);
        await eachMatchViewModel.getMatchEvent(widget.url);
        eachMatchViewModel.getTables(widget.url);
        eachMatchViewModel.getHTHMatch(widget.url);


    });


    super.initState();
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
                          icon: Icon(Icons.more_vert, color: Colors.white),
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
                  return provider.loadingMsn || provider.loadingEvents
                      ? Center(
                          child: Container(),
                        )
                      : FlexibleSpaceBar(
                          background: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 63, left: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(
                                      Icons.notifications_none,
                                      color: Colors.white,
                                    ),
                                    onPressed: null),
                                IconButton(
                                    icon:
                                        Icon(Icons.share, color: Colors.white),
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
                                            "https://www.eplworld.com${provider.msnModel.homeTeamLogo}")),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    provider.matchDetailsModel.date
                                        .split('،')
                                        .first
                                        .tr,
                                    style: TextStyle(fontSize: 18),
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
                                                    url: provider.msnModel.awayTeamURL,
                                                  id: widget.awayId,)
                                              ))
                                      );
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
                }))),
        Directionality(
          textDirection: TextDirection.rtl,
          child: SliverPersistentHeader(
            delegate: _SliverAppBarDelegate1(
                minHeight: 45.0,
                maxHeight: 45,
                child: Consumer<EachMatchViewModel>(
                  builder: (context, provider, child) {
                    return provider.msnModel == null
                        ? Container(
                            color: Theme.of(context).primaryColor,
                          )
                        : Container(
                            color: Theme.of(context).primaryColor,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * .5,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: Text(
                                        provider.msnModel.homeTeamName.tr,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                                /*
                                Container(
                                  width: 50,
                                  child: Text(
                                   "",
                                    style: TextStyle(color: Colors.black,),overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                 */
                                Container(
                                  width: MediaQuery.of(context).size.width * .5,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 25),
                                      child: Text(
                                        provider.msnModel.awayTeamName.tr,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
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
              child:SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                      maxHeight: 45,
                      minHeight: 45,
                      child:Consumer<EachMatchViewModel>(
                        builder: (context,provider,child){
                          return Container(
                            color: Theme.of(context).primaryColor,
                            child: TabBar(
                                indicatorColor: Colors.white,
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

                  ))
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
                        controller: tabController =  TabController(length: tabView(provider).length, vsync: this,initialIndex: _selectedIndex),
                        children:List.generate(tabView(provider).length, (index) => tabView(provider)[index]).toList()),
                  ),
                ));
          },

        ));
  }

  Widget matchEventName(){

    return Tab(
      child: Text(
        "احداث المبارة".tr,
        style: tapbar,
      ),
    );

  }
  Widget matchTableName(){

    return Tab(
      child: Text(
        "المراكز".tr,
        style: tapbar,
      ),
    );

  }
  Widget matchHTHName(){

    return Tab(
      child: Text(
        "المواجهات السابقة".tr,
        style: tapbar,
      ),
    );

  }

  List<Widget> tabName(EachMatchViewModel provider){
    List<Widget> test = [];
    if (provider.teamFormModel != null) {
      test.add(matchEventName());
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

    return ListView(children: <Widget>[MatchEvents(widget.url)]);

  }
  Widget matchTable(){
    return  ListView(children: <Widget>[
      MatchPostions(
        url:widget.url,
        awayId:widget.awayId,
        homeId:widget.homeId,
      )
    ]);

  }
  Widget matchGTable(){
    return  ListView(children: <Widget>[
      MatchGPosition(
        url:widget.url,
        awayId:widget.awayId,
        homeId:widget.homeId,
      )
    ]);

  }
  Widget matchHTH(){
    //matchesViewModel.getHTHMatch(widget.url);
    // print("FromOutSide${matchesViewModel.headToHeadModel.rows[0].homeTeamName}");

    return  ListView(children: <Widget>[
      PreConfront(
        url: widget.url,
      )
    ]);




  }

  List<Widget> tabView(EachMatchViewModel provider){
    List<Widget> test = [];
    if(provider.teamFormModel!=null){
      test.add(matchEvent());
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
