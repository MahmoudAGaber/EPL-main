import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/homeMatchesProvider.dart';



class YesterdayMatch extends ConsumerStatefulWidget {
  String date;
  YesterdayMatch({required this.date});
  @override
  _YesterdayMatchState createState() => _YesterdayMatchState();
}

class _YesterdayMatchState extends ConsumerState<YesterdayMatch> {
  TextStyle tapbar = TextStyle(
      fontFamily: 'Vazirmatn',
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Colors.black);
  TextStyle headline = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 15, fontWeight: FontWeight.w400);
  TextStyle content = TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 14,
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(MatchesProvider.notifier).getMatches(widget.date);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var matches = ref.watch(MatchesProvider);
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: matches.data!.length,
            itemBuilder: (widget, index) {
              return Padding(
                  padding: const EdgeInsets.only(
                      left: 4, right: 4, top: 2, bottom: 2),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 2,
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        title: GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Container(
                                  width: 35,
                                  height: 30,
                                  child: Image.network(
                                      "https://www.eplworld.com")),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "comName",
                                style: headline,
                              ),
                            ],
                          ),
                        ),
                        children: [
                          ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: 2,
                            itemBuilder: (widget, indexx) {
                              return GestureDetector(
                                onLongPress: () {
                                  addDialog();
                                },
                                onTap: () {},
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5, bottom: 9, top: 9),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            flex: 5,
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .4,
                                                height: 40,
                                                child: Stack(
                                                  children: [
                                                    Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            "homeName",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Vazirmatn',
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Positioned(
                                                      right: 10,
                                                      top: 7,
                                                      child: "Played" ==
                                                              "Played"
                                                          ? Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              100))),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        4.0),
                                                                child: Icon(
                                                                  Icons.timer,
                                                                  color: Colors
                                                                          .grey[
                                                                      500],
                                                                  size: 20,
                                                                ),
                                                              ))
                                                          : Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              100))),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        4.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .date_range,
                                                                  color: Colors
                                                                          .grey[
                                                                      500],
                                                                  size: 20,
                                                                ),
                                                              )),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          Flexible(
                                            flex: 5,
                                            child: Container(
                                              height: 40,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .44,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 6),
                                                    child: Container(
                                                      width: 33,
                                                      height: 28,
                                                      child: Image.network(
                                                          "https://www.eplworld.com"),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      "Played" == 'Played'
                                                          ? Text(
                                                              "homeScore - awayScore",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Vazirmatn',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black45),
                                                            )
                                                          : 'Postponed' ==
                                                                  'Postponed'
                                                              ? Text(
                                                                  "time",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Vazirmatn',
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .black45,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .lineThrough),
                                                                )
                                                              : Container()
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 6),
                                                    child: Container(
                                                      width: 33,
                                                      height: 28,
                                                      child: Image.network(
                                                          "https://www.eplworld.com"),
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .4,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "awayName",
                                                    style: TextStyle(
                                                        fontFamily: 'Vazirmatn',
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500),
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
                            },
                            padding: EdgeInsets.symmetric(vertical: 5),
                          )
                        ],
                      ),
                    ),
                  ));
            }));
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
}
