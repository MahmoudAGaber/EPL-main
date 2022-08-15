import 'package:arseli/EachTeam/Teampostions.dart';
import 'package:arseli/Provider/EachMatchViewModel.dart';
import 'package:arseli/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Oops.dart';
import 'EndMatches/matchEvent_a.dart';
import 'EndMatches/matchInfo_a.dart';
import 'matchInfo.dart';

class PreConfront extends StatefulWidget {
  String url;
  PreConfront({this.url});
  @override
  _PreConfrontState createState() => _PreConfrontState();
}

class _PreConfrontState extends State<PreConfront> {

  EachMatchViewModel eachMatchViewModel;
  @override
  void initState() {
    WidgetsBinding.instance..addPostFrameCallback((timeStamp) {
      eachMatchViewModel = Provider.of(context, listen: false);
      eachMatchViewModel.getHTHMatch(widget.url);

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Consumer<EachMatchViewModel>(
        builder:(context,provider,child){
          return provider.headToHeadModel ==null
              ? Padding(
                padding: const EdgeInsets.only(top: 100),
                child: NoData(),
              )
              : Column(
            children: <Widget>[
              Container(
                height: 120.0,
                margin: EdgeInsets.only(left: 5, right: 5, top: 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      /*
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                width: 40,
                                height: 40,
                                child: Image.asset("assets/530.jpg")),
                            Text("المباريات السابقة".tr),
                            Container(
                                width: 40,
                                height: 40,
                                child: Image.asset("assets/541.jpg")),
                          ],
                        ),
                      ),

                    Row(children: <Widget>[
                       Container(
                        child: LinearPercentIndicator(
                          width: 372.0,
                          padding: EdgeInsets.all( 20),
                          progressColor: Colors.blue,
                          percent: 0.5,
                          backgroundColor: Colors.grey[600],
                        ),
                      ),]
                    ),

                     */
                      Padding(
                        padding: const EdgeInsets.only(top: 25, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                                  child: Center(
                                      child: Text(
                                        provider.headToHeadModel.header.homeTeamWins.toString(),
                                        style: TextStyle(color: Colors.white, fontSize: 19),
                                      )),
                                ),
                                SizedBox(height: 5,),
                                Text("فوز",style: TextStyle(fontSize: 15),),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                                  child: Center(
                                      child: Text(
                                        provider.headToHeadModel.header.draws.toString(),
                                        style: TextStyle(color: Colors.white, fontSize: 19),
                                      )),
                                ),
                                SizedBox(height: 5,),
                                Text("تعادل",style: TextStyle(fontSize: 15),),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                                  child: Center(
                                      child: Text(
                                        provider.headToHeadModel.header.awayTeamWins.toString(),
                                        style: TextStyle(color: Colors.white, fontSize: 19),
                                      )),
                                ),
                                SizedBox(height: 5,),
                                Text('فوز',style: TextStyle(fontSize: 15),),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: provider.headToHeadModel.rows.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        onTap: () => MatchEvent_a,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 20, left: 20, top: 15, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      provider.headToHeadModel.rows[index].date.tr,
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                        color: Colors.grey[200],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3, right: 3),
                                        child: Text(
                                          provider.headToHeadModel.rows[index].leagueName.tr,
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey[700]),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context)=>matchInfo_a(url: provider.headToHeadModel.rows[index].matchURL,
                                        )
                                        ));

                                  },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5, bottom: 9, top: 9),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Flexible(
                                            flex: 5,
                                            child: Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width * .4,
                                                height: 40,
                                                child:
                                                Stack(
                                                  children: [
                                                    Center(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .end,
                                                        children: [
                                                          Text(
                                                            provider.headToHeadModel.rows[index].homeTeamName,
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight: FontWeight
                                                                    .w500),
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
                                                )
                                            ),
                                          ),
                                          Flexible(
                                            flex: 5,
                                            child: Container(
                                              height: 40,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * .44,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        left: 6),
                                                    child: Container(
                                                      width: 33,
                                                      height: 28,
                                                      child:
                                                      provider.headToHeadModel.rows[index].homeTeamLogo.endsWith(
                                                          'svg')
                                                          ? SvgPicture.network(
                                                          "https://www.eplworld.com${provider.headToHeadModel.rows[index].homeTeamLogo}",
                                                          semanticsLabel: 'Acme Logo')
                                                          : Image.network(
                                                          "https://www.eplworld.com${provider.headToHeadModel.rows[index].homeTeamLogo}"),
                                                    ),
                                                  ),

                                                      Text(
                                                    "${provider.headToHeadModel.rows[index].homeTeamScore} - ${provider.headToHeadModel.rows[index].awayTeamScore} ",
                                                    style: TextStyle(fontSize: 14,
                                                        color: Colors.black),),

                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 6),
                                                    child: Container(
                                                      width: 33,
                                                      height: 28,
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
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * .4,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    provider.headToHeadModel.rows[index].awayTeamName,
                                                    style: TextStyle(fontSize: 13,
                                                        fontWeight: FontWeight
                                                            .w500),
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
                ),
              )
            ],
          );
        }

      ),
    );
  }
}