import 'package:epl/shared/Views/custom/standingLabels.dart';
import 'package:epl/shared/Views/custom/teamInStanding.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../team/screens/teamHome.dart';




class MatchGPosition extends StatefulWidget {
  String? url;
  String? homeId;
  String? awayId;
  MatchGPosition({this.url, this.homeId, this.awayId});
  @override
  _MatchGPositionState createState() => _MatchGPositionState();
}

class _MatchGPositionState extends State<MatchGPosition> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: <Widget>[
                  /*
                        Padding(
                            padding: const EdgeInsets.only(
                                right: 16,
                                left: 16,
                                top: 12,
                                bottom: 8),
                            child: Row(
                              children: [
                                // CircleAvatar(radius: 10,),
                                SizedBox(
                                  width: 5,
                                ),
                                /*
                                Text(provider.calName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),

                                 */
                              ],
                            )),
                        Divider(),

                         */
                  StandingLabels(),
                ],
              ),
              ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4,bottom: 4),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, left: 10, top: 8, bottom: 8),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                         'title',
                                          style: Theme.of(context).textTheme.titleSmall
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: ClampingScrollPhysics(),
                              itemCount:5,
                              itemBuilder: (BuildContext context, indexx) {
                                return TeamInStanding();
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, indexx) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, bottom: 5, left: 10, top: 5),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(4),
                                            color: Colors.yellow),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('text')
                                    ],
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
  }
}
