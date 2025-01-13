//
// import 'dart:math';
//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:get/get.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//
// import '../../../league/screens/groupStandings.dart';
// import '../../../team/screens/teamHome.dart';
// import '../H2H.dart';
// import '../matchStanding.dart';
// import '../Lineup.dart';
// import '../MatchStats.dart';
// import 'matchEvent_a.dart';
//
// class matchInfo_a extends StatefulWidget {
//   String? homeId;
//   String? awayId;
//   String? url;
//   String? comName;
//
//   matchInfo_a({this.url, this.homeId, this.awayId, this.comName});
//
//   @override
//   _matchInfo_aState createState() => _matchInfo_aState();
// }
//
// class _matchInfo_aState extends State<matchInfo_a>
//     with TickerProviderStateMixin {
//
//
//   static const TextStyle tapbar = TextStyle(
//       fontFamily: 'Vazirmatn',
//       fontSize: 14,
//       fontWeight: FontWeight.w500,
//       color: Colors.white);
//
//   bool chContaier = false;
//   double heightOfgoals = 65;
//
//   ScrollController _scrollController = new ScrollController();
//
//   TabController? tabController;
//   int _selectedIndex = 0;
//
//   AnimationController? animationController;
//   Animation<double>? _animation;
//
//
//
//   @override
//   void initState() {
//     print('initState');
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       tabs = _tabs(3);
//       //tabView = _tabView(provider);
//       tabController = new TabController(
//         length: tabView!.length,
//         vsync: this,
//       );
//
//
//       setState(() {});
//
//       animationController = AnimationController(
//           duration: const Duration(seconds: 1), vsync: this);
//
//       _animation =
//           CurvedAnimation(parent: animationController!, curve: Curves.easeIn);
//
//       animationController!.forward();
//       // print("FromMatchInfo${widget.url}");
//     });
//   }
//
//   List<Widget>? tabs;
//   List<Widget>? tabView;
//
//
//   @override
//   void dispose() async {
//     super.dispose();
//     tabController!.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
//       return <Widget>[
//
//         Directionality(
//           textDirection: TextDirection.rtl,
//           child: SliverAppBar(
//               iconTheme: IconThemeData(color: Colors.white),
//               backgroundColor: Theme.of(context).primaryColor,
//               elevation: 0.0,
//               actions: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     IconButton(
//                         icon: Icon(
//                           Icons.more_vert,
//                           color: Colors.white,
//                         ),
//                         onPressed: null),
//                   ],
//                 )
//               ],
//               expandedHeight: 130.0,
//               pinned: true,
//               floating: true,
//               snap: true,
//               flexibleSpace: FlexibleSpaceBar(
//                         background: Padding(
//                           padding: const EdgeInsets.only(bottom: 75, left: 40,),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: <Widget>[
//                               /*
//                               IconButton(
//                                   icon: Icon(
//                                     Icons.notifications_none,
//                                     color: Colors.white,
//                                   ),
//                                   onPressed: null),
//
//                                */
//                               IconButton(
//                                   icon: Icon(Icons.star_border,
//                                       color: Colors.white),
//                                   onPressed: null),
//                             ],
//                           ),
//                         ),
//                         titlePadding: EdgeInsets.only(bottom: 10),
//                         centerTitle: true,
//                         title: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: <Widget>[
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: <Widget>[
//                                 InkWell(
//                                   onTap: () {
//                                     Navigator.push(context,
//                                         MaterialPageRoute(
//                                             builder: (context) => HomeTeam(
//                                               teamName: '',
//                                               teamId: widget.homeId,
//                                             )));
//                                   },
//                                   child: Container(
//                                       width: 40,
//                                       height: 30,
//                                       child: Image.network(
//                                           "https://www.eplworld.com")),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: <Widget>[
//                                 Text(
//                                   "homeTeamScores - awayTeamScores",
//                                   style: TextStyle(
//                                       fontFamily: 'Vazirmatn',
//                                       fontSize: 18,
//                                       color: Colors.white),
//                                 )
//                               ],
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: <Widget>[
//                                 InkWell(
//                                   onTap: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 HomeTeam(
//                                                   teamId: '',
//                                                   teamName: widget.awayId,
//                                                 )));
//                                   },
//                                   child: Container(
//                                       width: 40,
//                                       height: 30,
//                                       child: Image.network(
//                                           "https://www.eplworld.com")),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       )
//               ),
//         ),
//         Directionality(
//           textDirection: TextDirection.rtl,
//           child: SliverPersistentHeader(
//             delegate: _SliverAppBarDelegate1(
//                 minHeight: 45.0,
//                 maxHeight: 50,
//                 child:  Container(
//                             color: Theme.of(context).primaryColor,
//                             child: Stack(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                           height: 40,
//                                           width: MediaQuery.of(context).size.width * .5,
//                                           child: Center(
//                                             child: Padding(
//                                               padding: const EdgeInsets.only(left: 25),
//                                               child: Text('homeTeamName',
//                                                 style: TextStyle(
//                                                     fontFamily: 'Vazirmatn',
//                                                     color: Colors.white,
//                                                     fontSize: 20,
//                                                     fontWeight: FontWeight.w500),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                           height: 40,
//                                           width: MediaQuery.of(context).size.width * .5,
//                                           child: Center(
//                                             child: Padding(
//                                               padding: const EdgeInsets.only(right: 30),
//                                               child: Text(
//                                                 'awayTeamName',
//                                                 style: TextStyle(
//                                                     fontFamily: 'Vazirmatn',
//                                                     color: Colors.white,
//                                                     fontSize: 20,
//                                                     fontWeight: FontWeight.w500),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 Positioned(
//                                   right: MediaQuery.of(context).size.width*.2,
//                                   left: MediaQuery.of(context).size.width*.2,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         width: MediaQuery.of(context).size.width * .2,
//                                         child: Center(
//                                           child: Text(
//                                             'Playing' == 'Playing'
//                                                 ? 'playing'
//                                                 : "نهايه اللقاء",
//                                             style: TextStyle(
//                                                 fontFamily: 'Vazirmatn',
//                                                 color: Colors.white,
//                                                 fontSize: 15,fontWeight: FontWeight.w500),
//                                           ),
//                                         ),
//                                       ),
//                                       /*
//                                       Padding(
//                                         padding: const EdgeInsets.only(top: 5),
//                                         child: Container(
//                                           child: Column(
//                                               children:List.generate(provider.eventsModel.length, (index){
//                                                 return event(index);
//                                               })),
//                                         ),
//                                       )
//
//                                        */
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                   ),
//           ),
//         ),
//         Directionality(
//           textDirection: TextDirection.rtl,
//           child: SliverPersistentHeader(
//               pinned: true,
//               delegate: _SliverAppBarDelegate(
//                   maxHeight: 60,
//                   minHeight: 45,
//                   child: Container(
//                         height: 60,
//                         color: Theme.of(context).primaryColor,
//                         child: TabBar(
//                             indicatorColor: Colors.white,
//                             labelColor: Theme.of(context).primaryColor,
//                             isScrollable: true,
//                             onTap: (index) {
//                               _selectedIndex = index;
//                               tabController!.animateTo(_selectedIndex);
//                             },
//                             controller: this.tabController,
//                             // controller: tabController,
//                             tabs:tabs!),
//                       )
//                     )
//           )
//         ),
//       ];
//     }
//
//     return new Directionality(
//         textDirection: TextDirection.rtl,
//         child: Scaffold(
//                 body: this.tabView == null
//                     ? Center(
//                         child: Center(child: CircularProgressIndicator()),
//                       )
//                     : SafeArea(
//                         child: NestedScrollView(
//                           headerSliverBuilder: _sliverBuilder,
//                           body: TabBarView(
//                               controller: tabController,
//                               children: tabView!),
//                         ),
//                       ))
//           );
//   }
//
//   Widget _goal(index) {
//     return  Directionality(
//        textDirection:  'home' == 'home'
//             ? TextDirection.rtl
//             : TextDirection.ltr,
//         child: Container(
//           decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(8)
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(top: 1,bottom: 1,right: 10,left: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Icon(
//                   MdiIcons.soccer,
//                   size: 13,
//                   color: Colors.black,
//                 ),
//                 SizedBox(width: 4,),
//                 Container(
//                   child: Text(
//                       'time',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12)
//                   ),
//                 ),
//                 SizedBox(width: 3,),
//                 Text('belongsToName',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),)
//               ],
//             ),
//           ),
//         ),
//       );
//   }
//   Widget event(index) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 2, bottom: 2),
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         child: "home" == "home"
//                 ? Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                     child: "goal" == "goal"
//                         ? _goal(index)
//                         : Container()),
//               ],
//             )
//                 : "away" == "away"
//                 ? Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Container(
//                   child: "goal" ==
//                       "goal"
//                       ? _goal(index)
//                       : Container(),
//                 ),
//               ],
//             )
//                 :Container()
//
//       ),
//     );
//   }
//
//   Widget matchEventName() {
//     return Tab(
//       child: Text(
//         "احداث المبارة".tr,
//         style: tapbar,
//       ),
//     );
//   }
//
//   Widget lineUpName() {
//     return Tab(
//       child: Text(
//         "تشكيلة".tr,
//         style: tapbar,
//       ),
//     );
//   }
//
//   Widget statsName() {
//     return Tab(
//       child: Text(
//         "إحصائيات".tr,
//         style: tapbar,
//       ),
//     );
//   }
//
//   Widget matchTableName() {
//     return Tab(
//       child: Text(
//         "المراكز".tr,
//         style: tapbar,
//       ),
//     );
//   }
//
//   Widget matchHTHName() {
//     return Tab(
//       child: Text(
//         "المواجهات السابقة".tr,
//         style: tapbar,
//       ),
//     );
//   }
//
//
//   List<Widget> _tabs( provider) {
//     List<Widget> test = [];
//     if (provider.eventsModel != null) {
//       test.add(matchEventName());
//     }
//     if (provider.lineupsModel != null) {
//       test.add(lineUpName());
//     }
//     if (provider.sortedStatsModelMatch != null) {
//       test.add(statsName());
//     }
//     if (provider.tablesModelList[0].list.isNotEmpty) {
//       test.add(matchTableName());
//     }
//
//     if (provider.headToHeadModel != null) {
//       test.add(matchHTHName());
//     }
//     return test;
//   }
//
//   Widget matchEvent() {
//     return ListView(children: <Widget>[MatchEvent_a(url: widget.url!,homeId: widget.homeId!,awayId: widget.awayId!,)]);
//   }
//
//   Widget lineUp(String matchID) {
//     return LineUps(url: widget.url, matchID: matchID);
//   }
//
//   Widget stats() {
//     return MatchStats(
//       url: widget.url!,
//     );
//   }
//
//   Widget matchTable() {
//     return ListView(
//       children: [
//         MatchStanding(
//           url: widget.url!,
//           homeId: widget.homeId!,
//           awayId: widget.awayId!,
//         ),
//       ],
//     );
//   }
//
//   Widget matchGTable() {
//     return ListView(
//       children: [
//         MatchGPosition(
//           url: widget.url!,
//           homeId: widget.homeId!,
//           awayId: widget.awayId!,
//         ),
//       ],
//     );
//   }
//
//   Widget matchHTH() {
//     return ListView(children: <Widget>[
//       H2H(
//         url: widget.url!,
//       )
//     ]);
//   }
//
//   List<Widget> _tabView( provider) {
//     List<Widget> test = [];
//     if (provider.eventsModel != null) {
//       test.add(matchEvent());
//     }
//     if (provider.lineupsModel != null) {
//       test.add(lineUp(provider.msnModel.matchID));
//     }
//     if (provider.sortedStatsModelMatch != null) {
//       test.add(stats());
//     }
//
//     if (provider.tablesModelList[0].list.isNotEmpty &&
//         provider.tablesModelList[0].list.length == 1) {
//       test.add(matchTable());
//     }
//     if (provider.tablesModelList[0].list.isNotEmpty &&
//         provider.tablesModelList[0].list.length > 1) {
//       test.add(matchGTable());
//     }
//
//     if (provider.headToHeadModel != null) {
//       test.add(matchHTH());
//     }
//
//     return test;
//   }
//
//
// }
//
// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   _SliverAppBarDelegate({
//     required this.minHeight,
//     required this.maxHeight,
//     required this.child,
//   });
//
//   final double minHeight;
//   final double maxHeight;
//   final Widget child;
//
//   @override
//   double get minExtent => minHeight;
//
//   @override
//   double get maxExtent => maxHeight;
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return new SizedBox.expand(child: child);
//   }
//
//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return maxHeight != oldDelegate.maxHeight ||
//         minHeight != oldDelegate.minHeight ||
//         child != oldDelegate.child;
//   }
// }
//
// class _SliverAppBarDelegate1 extends SliverPersistentHeaderDelegate {
//   _SliverAppBarDelegate1({
//     required this.minHeight,
//     required this.maxHeight,
//     required this.child,
//   });
//
//   final double minHeight;
//   final double maxHeight;
//   final Widget child;
//
//   @override
//   double get minExtent => minHeight;
//
//   @override
//   double get maxExtent => maxHeight;
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return new SizedBox.expand(child: child);
//   }
//
//   @override
//   bool shouldRebuild(_SliverAppBarDelegate1 oldDelegate) {
//     return maxHeight != oldDelegate.maxHeight ||
//         minHeight != oldDelegate.minHeight ||
//         child != oldDelegate.child;
//   }
// }
//
// class ShapesPointer2 extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint();
//
//     paint.color = Color.fromRGBO(0, 147, 92, 1.0);
//     var rect = Rect.fromLTWH(0, 0, size.width, 850);
//     canvas.drawRect(rect, paint);
//
//     paint.color = Color.fromRGBO(26, 158, 109, 1.0);
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 4;
//     var rectbig = Rect.fromLTWH(size.width / 4.5, 0, 225, 100);
//     canvas.drawRect(rectbig, paint);
//
//     paint.color = Color.fromRGBO(26, 158, 109, 1.0);
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 4;
//     var rectsmall = Rect.fromLTWH(size.width / 2.77, 0, 112, 50);
//     canvas.drawRect(rectsmall, paint);
//
//     paint.color = Color.fromRGBO(26, 158, 109, 1.0);
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 4;
//     var rectbig1 = Rect.fromLTWH(size.width / 4.5, 750, 225, 100);
//     canvas.drawRect(rectbig1, paint);
//
//     paint.color = Color.fromRGBO(26, 158, 109, 1.0);
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 4;
//     var rectsmall1 = Rect.fromLTWH(size.width / 2.77, 800, 112, 50);
//     canvas.drawRect(rectsmall1, paint);
//
//     final rect3 = Rect.fromLTRB(150, 50, 260, 125);
//     final startAngle = pi / 9;
//     final sweepAngle = pi / 1.3;
//     final useCenter = false;
//     paint.color = Color.fromRGBO(26, 158, 109, 1.0);
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 4;
//     canvas.drawArc(rect3, startAngle, sweepAngle, useCenter, paint);
//
//     final rect4 = Rect.fromLTRB(150, 720, 260, 820);
//     final startAngle2 = -pi / 9;
//     final sweepAngle2 = -pi / 1.3;
//     final useCenter2 = false;
//     paint.color = Color.fromRGBO(26, 158, 109, 1.0);
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 4;
//     canvas.drawArc(rect4, startAngle2, sweepAngle2, useCenter2, paint);
//
//     paint.color = Color.fromRGBO(26, 158, 109, 1.0);
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 4;
//     var center = Offset(size.width / 2, size.height / 2);
//     canvas.drawCircle(center, 60.0, paint);
//
//     paint.color = Color.fromRGBO(26, 158, 109, 1.0);
//     var line1 = Offset(size.width, size.height / 2);
//     var line2 = Offset(0, size.height / 2);
//     canvas.drawLine(line1, line2, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
