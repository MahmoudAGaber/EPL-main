
import 'package:epl/presentation/home/screens/Oops.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../fixture/screens/EndMatches/matchInfo_a.dart';
import '../../fixture/screens/InfoMain.dart';
import '../../fixture/screens/matchInfo.dart';


class matchesForLeague extends StatefulWidget {
  String? url;
  matchesForLeague({this.url});
  @override
  _matchesForLeagueState createState() => _matchesForLeagueState();
}

class _matchesForLeagueState extends State<matchesForLeague> {

  TextStyle content = TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 13.5,
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer(
        builder: (context, provider, child) {
          return  Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: Container(
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "data",
                                        style: content,
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        physics: ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 5,
                                        itemBuilder:
                                            (BuildContext context, indexx) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => "played" == "Played"
                                                          ? matchInfo_a(
                                                              url: "",
                                                            )
                                                          : "Fixture" == "Fixture"
                                                              ? MatchInfo(
                                                                  url: "",
                                                                )
                                                              : Oops()));
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
                                                      /*
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.timer,
                                    color: Colors.grey[500],
                                    size: 20,
                                  ),
                                )),

                             */
                                                      Flexible(
                                                        flex: 4,
                                                        child: Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .4,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Flexible(
                                                                child: Text(
                                                                  "homeName",
                                                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 5,
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .4,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 12),
                                                                child: Container(
                                                                  width: 33,
                                                                  height: 28,
                                                                  child:  Image.network("https://www.eplworld.com"),
                                                                ),
                                                              ),
                                                               Text(
                                                                   "4 - 5",
                                                                   style: (Theme.of(context).textTheme.bodyMedium)
                                                               ),


                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right: 12),
                                                                child: Container(
                                                                    width: 33,
                                                                    height: 28,
                                                                    child:  Image.network("https://www.eplworld.com")),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 4,
                                                        child: Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .4,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  "awayName",
                                                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
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
                                          );
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
        },
      ),
    );
  }
}
