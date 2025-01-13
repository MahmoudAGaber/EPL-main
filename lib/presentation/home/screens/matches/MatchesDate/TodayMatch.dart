import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:epl/Data/StateModel.dart';
import 'package:epl/presentation/team/screens/teamStanding.dart';
import 'package:epl/shared/Utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:ui'as ui;
import '../../../../../main.dart';
import '../../../../../shared/Utils/date_converter.dart';
import '../../../../../shared/Views/custom/custom_imageView.dart';
import '../../../../../shared/Views/custom/custom_loader.dart';
import '../../../../fixture/screens/matchInfo.dart';
import '../../../../league/screens/homeLeague.dart';
import '../../../provider/homeMatchesProvider.dart';




class TodayMatches extends ConsumerStatefulWidget {
  String date;
  bool? liveMatches;

  TodayMatches({required this.date, this.liveMatches});

  @override
  _TodayMatchesState createState() => _TodayMatchesState();
}



class _TodayMatchesState extends ConsumerState<TodayMatches> with AutomaticKeepAliveClientMixin {

  var today = '';

  @override
  void dispose() {
    super.dispose();
  }


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      print(widget.date);
      ref.read(MatchesProvider.notifier).getMatches(widget.date);
      var now = new DateTime.now();
      today =  DateFormat("yyyy-MM-dd", 'EN_SA').format(now.subtract(new Duration(days: 0)));

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var matches = ref.watch(MatchesProvider);
    var isLive = ref.watch(MatchesProvider.notifier).liveMatch;
    var withTime = ref.watch(MatchesProvider.notifier).withTime;

    return Scaffold(
      body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child:  RefreshIndicator(
                        onRefresh: () async{},
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                               widget.date == today
                                   ? Padding(
                                      padding: const EdgeInsets.only(left: 13, right: 13, top: 15, bottom: 8),
                                       child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          var isLive = ref.read(MatchesProvider.notifier).liveMatch = !ref.read(MatchesProvider.notifier).liveMatch;

                                          ref.read(MatchesProvider.notifier).getMatches(widget.date,liveMatch: isLive);
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Container(
                                            width: 108,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: isLive? Theme.of(context).primaryColor : null
                                            ),
                                            child: Center(child: Text('تلعب الان',
                                              style:Theme.of(context).textTheme.titleSmall!.copyWith(color: isLive ? Colors.white : null)
                                            )
                                            ),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: Container(
                                          width: 108,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Center(child: Text('مباريتي',style: Theme.of(context).textTheme.titleSmall,)),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          var withTime = ref.read(MatchesProvider.notifier).withTime = !ref.read(MatchesProvider.notifier).withTime;

                                          ref.read(MatchesProvider.notifier).getMatches(widget.date,withTime: withTime);


                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Container(
                                            width: 108,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                                color: withTime? Theme.of(context).primaryColor : null
                                            ),
                                            child: Center(child: Text('بالوقت',
                                              style:Theme.of(context).textTheme.titleSmall!.copyWith(color:withTime ? Colors.white : null)
                                            )
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                     )
                                   :SizedBox(),
                                Column(
                                     children: [
                                       matches.handelState(
                                         onLoading: (state)=> CustomLoader(),
                                         onSuccess: (state)=> ListView.builder(
                                             shrinkWrap: true,
                                             physics: ClampingScrollPhysics(),
                                             itemCount: matches.data!.length,
                                             itemBuilder: (widget, index) {
                                               var match = matches.data![index];
                                               return Padding(
                                                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                 child: Card(
                                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                                   elevation: 2,
                                                   child: Theme(
                                                     data: Theme.of(context).copyWith(
                                                         dividerColor: Colors.transparent,
                                                         colorScheme: Theme.of(context).colorScheme),
                                                     child: ExpansionTile(
                                                       initiallyExpanded: true,
                                                       title: GestureDetector(
                                                         onTap: () {
                                                           Navigator.push(
                                                               context, MaterialPageRoute(builder: (context) => LeagueHome(leagueName: match.league.name, leagueId: match.league.id, logo: match.league.logo,)));
                                                         },
                                                         child: Stack(
                                                           children: [
                                                             Positioned(
                                                               left: -15,
                                                               bottom: -11,
                                                               child: IconButton(
                                                                   onPressed: () {},
                                                                   icon: Icon(
                                                                     Icons.star,
                                                                     color: Color(0xFF862aa6),
                                                                     size: 18,
                                                                   )),
                                                             ),
                                                             Padding(
                                                               padding: const EdgeInsets.only(right: 24),
                                                               child: Row(
                                                                 mainAxisAlignment: MainAxisAlignment.center,
                                                                 children: [
                                                                   //CircleAvatar(radius: 13,backgroundColor: Colors.grey,),
                                                                   Container(
                                                                       width: 28,
                                                                       height: 28,
                                                                       child: CustomImage(imgUrl:"${Constants.leagueImage}${matches.data![index].league.id}.png" ,)

                                                                   ),
                                                                   SizedBox(
                                                                     width: 10,
                                                                   ),
                                                                   Flexible(
                                                                     child: Text(matches.data![index].league.name,
                                                                       style: Theme.of(context).textTheme.titleSmall!.copyWith(overflow: TextOverflow.clip),textAlign: TextAlign.center,softWrap: true,
                                                                     ),
                                                                   ),
                                                                 ],
                                                               ),
                                                             ),
                                                           ],
                                                         ),
                                                       ),
                                                       children: [
                                                         Divider(),
                                                         ListView.builder(
                                                           physics: ClampingScrollPhysics(),
                                                           shrinkWrap: true,
                                                           scrollDirection: Axis.vertical,
                                                           itemCount: matches.data![index].items.length,
                                                           itemBuilder: (widget, innerIndex) {
                                                             var match = matches.data![index].items[innerIndex];
                                                             var leagueInf = matches.data![index].league;

                                                             return GestureDetector(
                                                               onLongPress: () {
                                                                 // addDialog();
                                                               },
                                                               onTap: () {
                                                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                                     MatchInfo(
                                                                       fixtureId: match.fixture.id,
                                                                       seasonId: leagueInf.season,
                                                                       homeId: match.teams.home.id,
                                                                       awayId: match.teams.away.id,)));
                                                               },
                                                               child: Column(
                                                                 mainAxisAlignment:
                                                                 MainAxisAlignment.center,
                                                                 children: [
                                                                   Padding(
                                                                     padding:
                                                                     const EdgeInsets.only(left: 5, right: 8, top: 9),
                                                                     child: Row(
                                                                       mainAxisAlignment: MainAxisAlignment.center,
                                                                       children: [
                                                                         Flexible(
                                                                           flex: 5,
                                                                           child: Container(
                                                                               width: MediaQuery.of(context).size.width * .4,
                                                                               height: 40,
                                                                               child: Stack(
                                                                                 children: [
                                                                                   Center(
                                                                                     child: Row(
                                                                                       mainAxisAlignment: MainAxisAlignment.end,
                                                                                       children: [
                                                                                         Flexible(
                                                                                           child: Container(
                                                                                             width: 90,
                                                                                             child: Text(match.teams.home.name,
                                                                                               style: Theme.of(context).textTheme.bodySmall,
                                                                                               overflow: TextOverflow.clip,
                                                                                               textDirection: ui.TextDirection.ltr,
                                                                                             ),
                                                                                           ),
                                                                                         ),

                                                                                       ],
                                                                                     ),
                                                                                   ),
                                                                                   Positioned(
                                                                                       right: 4,
                                                                                       top: 7,
                                                                                       child: match.fixture.status.long == "Playing"
                                                                                           ? CircleAvatar(
                                                                                         minRadius: 13,
                                                                                         backgroundColor: Colors.green,
                                                                                         child: Padding(
                                                                                           padding: const EdgeInsets.all(4.0),
                                                                                           child: Padding(
                                                                                             padding: const EdgeInsets.all(2.0),
                                                                                             child: Text(match.fixture.status.elapsed,
                                                                                               style: TextStyle(fontFamily: 'Vazirmatn', fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                             ),
                                                                                           ),
                                                                                         ),
                                                                                       )
                                                                                           : match.fixture.status.long == 'Match Finished'
                                                                                           ? Container()
                                                                                           :  match.fixture.status.long == "Not Started"
                                                                                           ? Container()
                                                                                           : Container(
                                                                                           decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.all(Radius.circular(100))),
                                                                                           child: Padding(
                                                                                             padding: const EdgeInsets.all(4.0),
                                                                                             child: Icon(
                                                                                               Icons.date_range,
                                                                                               color: Colors.grey[500],
                                                                                               size: 20,
                                                                                             ),
                                                                                           ))),
                                                                                 ],
                                                                               )),
                                                                         ),
                                                                         Flexible(
                                                                           flex: 6,
                                                                           child: Container(
                                                                             height: 40,
                                                                             width: MediaQuery.of(context).size.width * .5,
                                                                             child: Row(
                                                                               mainAxisAlignment: MainAxisAlignment.center,
                                                                               children: [
                                                                                 Padding(
                                                                                   padding: const EdgeInsets.only(left: 13),
                                                                                   child:
                                                                                  // CircleAvatar(radius: 13,backgroundColor: Colors.grey,
                                                                                   Container(
                                                                                     width: 35,
                                                                                     height: 30,
                                                                                     child: CustomImage(imgUrl:"${Constants.teamImage}${match.teams.home.id}.png",)

                                                                                   ),
                                                                                 ),
                                                                                 match.fixture.status.long == "Not Started"
                                                                                     ? Text(DateConverter.isoStringToLocalTimeOnly(match.fixture.date),
                                                                                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                                                                                 )
                                                                                     :  match.fixture.status.long == 'Postponed'
                                                                                     ? Text('time',
                                                                                     style: Theme.of(context).textTheme.bodyMedium
                                                                                 )
                                                                                     : Padding(
                                                                                   padding: const EdgeInsets.only(top: 8),
                                                                                   child: Text("${match.score.fulltime.home} - ${match.score.fulltime.away}",
                                                                                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                                                                                   ),
                                                                                 ),
                                                                                 Padding(
                                                                                   padding: const EdgeInsets.only(right: 13),
                                                                                   child: Container(
                                                                                     width: 30,
                                                                                     height: 30,
                                                                                     child:CustomImage(imgUrl: "${Constants.teamImage}${match.teams.away.id}.png",)
                                                                                     ),
                                                                                 ),
                                                                               ],
                                                                             ),
                                                                           ),
                                                                         ),
                                                                         Flexible(
                                                                           flex: 5,
                                                                           child: Container(
                                                                             height: 40,
                                                                             width: MediaQuery.of(context).size.width *.39,
                                                                             child: Row(
                                                                               mainAxisAlignment:
                                                                               MainAxisAlignment
                                                                                   .start,
                                                                               children: [
                                                                                 Expanded(
                                                                                   child: Text(match.teams.away.name,
                                                                                     style: Theme.of(context).textTheme.bodySmall,
                                                                                     overflow: TextOverflow.clip,
                                                                                   ),
                                                                                 ),
                                                                               ],
                                                                             ),
                                                                           ),
                                                                         )
                                                                       ],
                                                                     ),

                                                                   ),
                                                                   match.fixture.status.long == 'Match Finished'
                                                                       ? Container(
                                                                     width: 48,
                                                                     height: 18,
                                                                     decoration: BoxDecoration(
                                                                       borderRadius: BorderRadius.circular(8),
                                                                       color: Color(0xFF862aa6),
                                                                     ),
                                                                     child: Center(child: FittedBox(child: Text('انتهت',style: TextStyle(color: Colors.white,fontSize: 12.5),))),
                                                                   )
                                                                       :Container(),
                                                                   matches.data![index].items.length-1 == innerIndex ? SizedBox(): Divider()
                                                                 ],
                                                               ),
                                                             );
                                                           },
                                                           padding:
                                                           EdgeInsets.symmetric(vertical: 5),
                                                         ),
                                                         // InkWell(
                                                         //     // onTap: (){
                                                         //     //   Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(builder: (context) => LeagueHome(leagueName: '',)));
                                                         //     // },
                                                         //     child: Text('الترتيب',style: TextStyle(color: Color(0xFF862aa6),fontWeight: FontWeight.bold),)
                                                         // ),
                                                         SizedBox(height: 5,)
                                                       ],
                                                     ),
                                                   ),
                                                 ),
                                               );
                                             }),
                                         onFailure: (state)=> Center(child: NoMatchesPN(context),),
                                       )
                                     ],
                                )
                                    // :Padding(
                                    //   padding: const EdgeInsets.only(top: 100),
                                    //   child: NoMatchesPN(context),
                                    // )

                              ],
                            ),
                          ),
                        ),
                      )
          ),
    );
  }

  addDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding:
                EdgeInsets.only(bottom: 290, top: 290, left: 90, right: 90),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("الفرق المفضلة",
                    style: TextStyle(
                        fontFamily: 'Vazirmatn',
                        color: Colors.green,
                        fontSize: 13)),
                Text(
                  "اضافة ريال مدريد",
                  style: TextStyle(fontFamily: 'Vazirmatn', fontSize: 13),
                ),
                Text(
                  "اضافة اتليتكو مدريد",
                  style: TextStyle(fontFamily: 'Vazirmatn', fontSize: 13),
                ),
                Text(
                  "تشغيل الاشعارات",
                  style: TextStyle(
                      fontFamily: 'Vazirmatn',
                      color: Colors.grey,
                      fontSize: 13),
                ),
                Text("اضافة الي تقويم",
                    style: TextStyle(
                        fontFamily: 'Vazirmatn',
                        color: Colors.grey,
                        fontSize: 13)),
              ],
            ),
          );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
