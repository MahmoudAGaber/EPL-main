import 'package:arseli/EachTeam/Teampostions.dart';
import 'package:arseli/Provider/EachMatchViewModel.dart';
import 'package:arseli/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../Oops.dart';
import 'EndMatches/matchEvent_a.dart';
import 'EndMatches/matchInfo_a.dart';
import 'matchInfo.dart';
import 'dart:ui' as ui;

class PreConfront extends StatefulWidget {
  String url;
  PreConfront({this.url});
  @override
  _PreConfrontState createState() => _PreConfrontState();
}

class _PreConfrontState extends State<PreConfront> {
  EachMatchViewModel eachMatchViewModel;
  bool view = false;
  @override
  void initState() {
    WidgetsBinding.instance
      ..addPostFrameCallback((timeStamp) {
        eachMatchViewModel = Provider.of(context, listen: false);
        eachMatchViewModel.getHTHMatch(widget.url);
      });

    super.initState();
  }

//todo
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Consumer<EachMatchViewModel>(builder: (context, provider, child) {
        return provider.headToHeadModel == null
            ? Padding(
                padding: const EdgeInsets.only(top: 100),
                child: NoData(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 220.0,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                      width: 50,
                                      height: 50,
                                      child: Image.network(
                                          "https://www.eplworld.com${provider.msnModel.homeTeamLogo}")),
                                  Text(
                                    "المباريات السابقة".tr,
                                    style: TextStyle(
                                        fontFamily: 'Vazirmatn',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Container(
                                      width: 50,
                                      height: 50,
                                      child: Image.network(
                                          "https://www.eplworld.com${provider.msnModel.awayTeamLogo}")),
                                ],
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
                                            color: Colors.grey[100])),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                              child: Text(
                                            provider.headToHeadModel.header
                                                .homeTeamWins
                                                .toString(),
                                            style: TextStyle(
                                                fontFamily: 'Vazirmatn',
                                                color: provider
                                                            .headToHeadModel
                                                            .header
                                                            .homeTeamWins >
                                                        provider.headToHeadModel
                                                            .header.awayTeamWins
                                                    ? Colors.blue
                                                    : Colors.red,
                                                fontSize: 12),
                                          )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "انتصار",
                                            style: TextStyle(
                                              fontFamily: 'Vazirmatn',
                                              fontSize: 17,
                                              color: provider.headToHeadModel
                                                          .header.homeTeamWins >
                                                      provider.headToHeadModel
                                                          .header.awayTeamWins
                                                  ? Colors.blue
                                                  : Colors.red,
                                            ),
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
                                            color: Colors.grey[100])),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                              child: Text(
                                            provider
                                                .headToHeadModel.header.draws
                                                .toString(),
                                            style: TextStyle(
                                                fontFamily: 'Vazirmatn',
                                                color: Colors.grey,
                                                fontSize: 14),
                                          )),
/*
                                          SizedBox(
                                            height: 5,
                                          ),
*/
                                          Text(
                                            "تعادل",
                                            style: TextStyle(
                                                fontFamily: 'Vazirmatn',
                                                fontSize: 17,
                                                color: Colors.grey),
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
                                            color: Colors.grey[100])),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                              child: Text(
                                            provider.headToHeadModel.header
                                                .awayTeamWins
                                                .toString(),
                                            style: TextStyle(
                                                fontFamily: 'Vazirmatn',
                                                color: provider
                                                            .headToHeadModel
                                                            .header
                                                            .awayTeamWins >
                                                        provider.headToHeadModel
                                                            .header.homeTeamWins
                                                    ? Colors.blue
                                                    : Colors.red,
                                                fontSize: 14),
                                          )),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            'انتصار',
                                            style: TextStyle(
                                                fontFamily: 'Vazirmatn',
                                                fontSize: 17,
                                                color: provider
                                                            .headToHeadModel
                                                            .header
                                                            .awayTeamWins >
                                                        provider.headToHeadModel
                                                            .header.homeTeamWins
                                                    ? Colors.blue
                                                    : Colors.red),
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
                              itemCount:
                                  provider.headToHeadModel.rows.length <3
                                      ?  provider.headToHeadModel.rows.length
                                      :provider.headToHeadModel.rows.length > 3 && view
                                      ?provider.headToHeadModel.rows.length
                                      :3,

                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, index) {
                                return GestureDetector(
                                  onTap: () => MatchEvent_a,
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20,
                                              left: 20,
                                              top: 15,
                                              bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                provider.headToHeadModel.rows[index].date.tr,
                                                style: TextStyle(
                                                    fontFamily: 'Vazirmatn',
                                                    color: Colors.grey[700]),
                                              ),
                                              Row(
                                                children: [
                                                  CircleAvatar(radius: 8,),
                                                  SizedBox(width: 2,),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(12)),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 3, right: 3),
                                                      child: Text(
                                                        provider.headToHeadModel.rows[index].leagueName.tr,
                                                        style: TextStyle(
                                                            fontFamily: 'Vazirmatn',
                                                            fontSize: 10,
                                                            color: Colors.grey[700]),
                                                      ),
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
                                                    builder: (context) =>
                                                        matchInfo_a(
                                                          url: provider
                                                              .headToHeadModel
                                                              .rows[index]
                                                              .matchURL,
                                                        )));
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    bottom: 9,
                                                    top: 9),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Flexible(
                                                      flex: 5,
                                                      child: Container(width: MediaQuery.of(context).size.width * .4,
                                                          height: 40,
                                                          child: Stack(
                                                            children: [
                                                              Center(
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .end,
                                                                  children: [
                                                                    Flexible(
                                                                      child: Text(
                                                                        provider.headToHeadModel.rows[index].homeTeamName,
                                                                        textDirection: ui.TextDirection.ltr,
                                                                        style: TextStyle(
                                                                            fontFamily: 'Vazirmatn',
                                                                            fontSize: 13,
                                                                            fontWeight: FontWeight.w500),
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
                                                      flex: 6,
                                                      child: Container(
                                                        height: 40,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 16),
                                                              child: Container(
                                                                width: 35,
                                                                height: 30,
                                                                child: provider
                                                                    .headToHeadModel
                                                                    .rows[index]
                                                                    .homeTeamLogo
                                                                    .endsWith(
                                                                    'svg')
                                                                    ? SvgPicture.network(
                                                                    "https://www.eplworld.com${provider.headToHeadModel.rows[index].homeTeamLogo}",
                                                                    semanticsLabel:
                                                                    'Acme Logo')
                                                                    : Image.network(
                                                                    "https://www.eplworld.com${provider.headToHeadModel.rows[index].homeTeamLogo}"),
                                                              ),
                                                            ),
                                                            Text(
                                                              "${provider.headToHeadModel.rows[index].homeTeamScore} - ${provider.headToHeadModel.rows[index].awayTeamScore} ",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  'Vazirmatn',
                                                                  fontSize: 14,
                                                                  color:
                                                                  Colors.black),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 16),
                                                              child: Container(
                                                                width: 35,
                                                                height: 30,
                                                                child: Image.network(
                                                                    "https://www.eplworld.com${provider.headToHeadModel.rows[index].awayTeamLogo}"),
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
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            .4,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                provider
                                                                    .headToHeadModel
                                                                    .rows[index]
                                                                    .awayTeamName,
                                                                textDirection: ui.TextDirection.rtl,
                                                                style: TextStyle(
                                                                  fontFamily: 'Vazirmatn', fontSize: 13, fontWeight: FontWeight.w500,),
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
                            Padding(
                              padding: const EdgeInsets.only(top: 8,bottom: 8),
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    view = true;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8,left: 8),
                                  child: view
                                      ?Container()
                                      :Row(
                                    children: [
                                       Icon(Icons.arrow_back_ios,color: Theme.of(context).primaryColor,size: 14,),
                                      Text('مشاهدة الكل',style: TextStyle(color: Theme.of(context).primaryColor),),
                                    ],

                            ),
                                ),
                              )),
                          ],
                        ),
                      ),
                    ),
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
                                      Text('الموسم حتي الان',style: TextStyle(fontSize: 17),),
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
                                      style: TextStyle(
                                          fontFamily: 'Vazirmatn',
                                          fontWeight: FontWeight.w500),
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
                                                      style: TextStyle(
                                                          fontFamily:
                                                          'Vazirmatn',
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "اماكن الجدول",
                                                style: TextStyle(
                                                    fontFamily:
                                                    'Vazirmatn',
                                                    fontSize: 16,
                                                    color:
                                                    Colors.black54),
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
                                                      style: TextStyle(
                                                          fontFamily:
                                                          'Vazirmatn',
                                                          fontSize: 16),
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
                  ],
                ),
              );
      }),
    );
  }
}
