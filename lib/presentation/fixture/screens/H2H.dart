import 'package:epl/Data/StateModel.dart';
import 'package:epl/presentation/fixture/screens/InfoMain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:ui' as ui;

import '../../../shared/Utils/Constants.dart';
import '../../../shared/Utils/date_converter.dart';
import '../../../shared/Views/custom/custom_loader.dart';
import '../provider/fixtureViewModel.dart';
import 'matchInfo.dart';

class H2H extends ConsumerStatefulWidget {
  String? url;
  H2H({this.url});
  @override
  _H2HState createState() => _H2HState();
}

class _H2HState extends ConsumerState<H2H> {
  bool view = false;
  double winPerH=0.0;
  double winPerA=0.0;
  double drawerPer=0.0;
  int? total;

  @override
  void initState() {
    WidgetsBinding.instance..addPostFrameCallback((timeStamp) {});

    super.initState();
  }


  void per(h2h){
    try {
      if (h2h.data.summary != null) {
        int homeWin = h2h.data.summary.firstTeam.wins;
        int awayWin = h2h.data.summary.secondTeam.wins;
        int drawer = h2h.data.summary.draws;
        total = homeWin + awayWin + drawer;
        winPerH = homeWin / total!.toDouble();
        winPerA = awayWin / total!.toDouble();
        drawerPer = drawer / total!.toDouble();
      }
    }catch(e){
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    var h2h = ref.watch(matchH2HProvider);

    per(h2h);

    return SafeArea(
      bottom: true,
      child: h2h.handelState(
            onLoading: (state) => Center(
              child: CustomLoader(),
            ),
            onSuccess: (state) => Padding(
              padding: const EdgeInsets.all(12.0),
              child: h2h.data!.h2h.isNotEmpty
                  ?Column(
                children: <Widget>[
                    Container(
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                     SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.network(
                                        "${Constants.teamImage}${h2h.data!.statisticsH2h.team1Id}.png",
                                        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                          return CircleAvatar(backgroundColor: Colors.grey,);
                                        },
                                      ),
                                    ),
                                    Text("المباريات السابقة",
                                      style: Theme.of(context).textTheme.bodyMedium
                                    ),
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.network(
                                        "${Constants.teamImage}${h2h.data!.statisticsH2h.team2Id}.png",
                                        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                          return CircleAvatar(backgroundColor: Colors.grey,);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SizedBox(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width*.9,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        height: 35,
                                        width: MediaQuery.of(context).size.width*winPerH-19,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8)),
                                          color: h2h.data!.summary.firstTeam.wins > h2h.data!.summary.secondTeam.wins
                                              ? Theme.of(context).primaryColor:Colors.red,
                                        ),
                                        child: Center(child: Text("${(winPerH*100).toStringAsFixed(1)}%",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),)),

                                      ),
                                      Container(
                                        height: 35,
                                        width: MediaQuery.of(context).size.width*drawerPer-19,
                                        color: Colors.grey,
                                        child: Center(child: Text("${(drawerPer*100).toStringAsFixed(1)}%",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),)),
                                      ),
                                      Container(
                                        height: 35,
                                        width: MediaQuery.of(context).size.width*winPerA-19,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)),
                                          color: h2h.data!.summary.secondTeam.wins > h2h.data!.summary.firstTeam.wins
                                              ? Theme.of(context).primaryColor:Colors.red,
                                        ),

                                        child: Center(child: Text("${(winPerA*100).toStringAsFixed(1)}%",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),)),

                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, right: 15,left: 15,bottom: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Theme.of(context).colorScheme.onSurface)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Center(
                                                child: Text(h2h.data!.summary.firstTeam.wins.toString(),
                                                    style: Theme.of(context).textTheme.bodyLarge
                                                )),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                                'انتصار',
                                                style: Theme.of(context).textTheme.bodyMedium
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Theme.of(context).colorScheme.onSurface)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                                child: Text(h2h.data!.summary.draws.toString(),
                                              style: Theme.of(context).textTheme.bodyLarge
                                            )),
                                            SizedBox(height: 5,),

                                            Text(
                                              "تعادل",
                                              style: Theme.of(context).textTheme.bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Theme.of(context).colorScheme.onSurface)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Center(
                                                child: Text(h2h.data!.summary.secondTeam.wins.toString(),
                                              style: Theme.of(context).textTheme.bodyLarge
                                            )),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              'انتصار',
                                              style: Theme.of(context).textTheme.bodyMedium
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(12))),
                      child: Column(
                        children: [
                          ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: h2h.data!.h2h.length,
                            scrollDirection: Axis.vertical,
                            reverse: true,
                            itemBuilder: (BuildContext context, index) {
                              var h2dItem = h2h.data!.h2h[index];
                              return GestureDetector(
                                //onTap: () => MatchEvent_a,
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(h2dItem.fixture.date != "" ? DateConverter.isoDayWithDateString(h2dItem.fixture.date):"-",
                                              style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12),
                                            ),
                                            Row(
                                              children: [
                                                //CircleAvatar(radius: 8,),
                                                SizedBox(width: 2,),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(12)),
                                                  ),
                                                  child: Text(h2dItem.league.name,
                                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12.5),
                                                  ),
                                                )
                                              ],
                                            )

                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MatchInfo(fixtureId: h2dItem.fixture.id,seasonId: h2dItem.league.season,homeId: h2dItem.teams.home.id,awayId:  h2dItem.teams.away.id,)));
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  flex: 4,
                                                  child: Container(width: MediaQuery.of(context).size.width * .4,
                                                      height: 40,
                                                      child: Stack(
                                                        children: [
                                                          Center(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                Flexible(
                                                                  child: Text(h2dItem.teams.home.name,
                                                                    textDirection: ui.TextDirection.ltr,
                                                                    style: Theme.of(context).textTheme.bodyMedium,
                                                                    overflow: TextOverflow.clip,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          /*
                                                        Positioned(
                                                          right: 10,
                                                          top: 7,
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey[300],
                                                                  borderRadius: BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          100))),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .all(4.0),
                                                                child: Icon(
                                                                  Icons.timer,
                                                                  color: Colors
                                                                      .grey[500],
                                                                  size: 20,),
                                                              )),
                                                        ),

                                                         */
                                                        ],
                                                      )),
                                                ),

                                                Flexible(
                                                  flex: 5,
                                                  child: Container(
                                                    height: 40,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(left: 14),
                                                          child:  SizedBox(
                                                            width: 30,
                                                            height: 28,
                                                            child: Image.network(
                                                              "${Constants.teamImage}${h2dItem.teams.home.id}.png",
                                                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                                                return CircleAvatar(backgroundColor: Colors.grey,);
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          "${h2dItem.score.fulltime.home} - ${h2dItem.score.fulltime.away}",
                                                          style: Theme.of(context).textTheme.bodyMedium,
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(right: 14),
                                                          child:  SizedBox(
                                                            width: 28,
                                                            height: 28,
                                                            child: Image.network(
                                                              "${Constants.teamImage}${h2dItem.teams.away.id}.png",
                                                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                                                return CircleAvatar(backgroundColor: Colors.grey,);
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                Flexible(
                                                  flex: 4,
                                                  child: Container(
                                                    height: 40,
                                                    width:
                                                    MediaQuery.of(context).size.width * .4,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        Flexible(
                                                          child: Text(h2dItem.teams.away.name,
                                                            textDirection: ui.TextDirection.rtl,
                                                            style: Theme.of(context).textTheme.bodyMedium,
                                                            overflow: TextOverflow.clip,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Divider(
                                        height: 2.0,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          // Padding(
                          //     padding: const EdgeInsets.only(top: 8,bottom: 8),
                          //     child: InkWell(
                          //       onTap: (){
                          //         setState(() {
                          //           view = true;
                          //         });
                          //       },
                          //       child: Padding(
                          //         padding: const EdgeInsets.only(right: 8,left: 8),
                          //         child: view
                          //             ?Container()
                          //             :Row(
                          //           children: [
                          //             Icon(Icons.arrow_back_ios,color: Theme.of(context).primaryColor,size: 14,),
                          //             Text('مشاهدة الكل',style: TextStyle(color: Color(0xFF862aa6)),),
                          //           ],
                          //
                          //         ),
                          //       ),
                          //     )),
                        ],
                      ),
                    ),
                  ),
                  /*
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(left: 8,right: 8,top: 10,bottom: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: 65,
                                        height: 65,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(50)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(50),
                                            ),
                                            child:Image.network(
                                                "https://www.eplworld.com${provider.msnModel.homeTeamLogo}"),
                                          ),
                                        ),
                                      ),
                                      Text('الموسم حتي الان',style: Theme.of(context).textTheme.bodyMedium,),
                                      Container(
                                        width: 65,
                                        height: 65,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(50)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(50),
                                            ),
                                            child:Image.network(
                                                "https://www.eplworld.com${provider.msnModel.awayTeamLogo}"),
                                          ),
                                        ),
                                      ),


                                    ],
                                  )
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 10,
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      provider.matchDetailsModel.leagueName,
                                      style: Theme.of(context).textTheme.bodyMedium.copyWith(fontSize: 14)
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ListView.builder(
                                    physics:
                                    NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: 8,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 50,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: 60,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 7,
                                                    right: 7,
                                                    top: 5,
                                                    bottom: 2),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        right: 6,
                                                        left: 6,
                                                        top: 3,
                                                        bottom: 3),
                                                    child: Text(
                                                      "8",
                                                       style:Theme.of(context).textTheme.bodyMedium.copyWith(fontSize: 16)
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "اماكن الجدول",
                                                  style:Theme.of(context).textTheme.bodySmall.copyWith(fontSize: 15)
                                              ),
                                            ),
                                            Container(
                                              width: 60,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 7,
                                                    right: 7,
                                                    top: 5,
                                                    bottom: 2),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        right: 6,
                                                        left: 6,
                                                        top: 3,
                                                        bottom: 3),
                                                    child: Text(
                                                      "6",
                                                      style:Theme.of(context).textTheme.bodyMedium.copyWith(fontSize: 16)
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                     */
                ],
              )
                  :SizedBox(),
            ),
            onFailure: (state) => SizedBox()),
    );
  }
}
