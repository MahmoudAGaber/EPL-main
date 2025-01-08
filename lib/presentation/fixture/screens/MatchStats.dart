
import 'package:epl/Data/StateModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/fixtureViewModel.dart';

class MatchStats extends ConsumerStatefulWidget {
  String? url;
  MatchStats({this.url});
  @override
  _MatchStatsState createState() => _MatchStatsState();
}

class _MatchStatsState extends ConsumerState<MatchStats> {
  bool chContaier = false;

  AnimationController? animationController;
  Animation<double>? _animation;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var matchStatistics = ref.watch(matchStatsProvider);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: matchStatistics.handelState(
          onLoading: (state) => Center(
            child: CircularProgressIndicator(),
          ),
          onSuccess: (state) =>  Column(
            children: <Widget>[
              /*
            Column(
              children: [
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10.0, right: 11.0),
                      width: 180,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: Colors.grey[300])),
                      child: Center(
                        child: Text("فريق",
                            style: TextStyle(                      fontFamily: 'Vazirmatn',
                                fontWeight: FontWeight.w600, fontSize: 12.5)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, right: 10.0),
                      width: 180,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: Colors.grey[300])),
                      child: Center(
                        child: Text("لاعب",
                            style: TextStyle(                      fontFamily: 'Vazirmatn',
                                fontWeight: FontWeight.w600, fontSize: 12.5)),
                      ),
                    ),

                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("احصائيات الصدارة", style: content),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 5, right: 15, left: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("السيطرة علي الكرة", style: content),
                ],
              ),
            ),

             */
              // Padding(
              //   padding: const EdgeInsets.only(
              //       right: 10, left: 10, top: 15, bottom: 15),
              //   child: Stack(
              //     children: <Widget>[
              //       /*
              //     LinearPercentIndicator(
              //       width: MediaQuery.of(context).size.width*0.9,
              //       percent: 0.1,
              //       progressColor: Colors.green[600],
              //       isRTL: true,
              //       lineHeight: 35,
              //       backgroundColor: Colors.grey[600],
              //
              //
              //     ),
              //
              //      */
              //       Container(
              //         child: Row(
              //           children: [
              //             Container(
              //               height: 40,
              //               width: MediaQuery.of(context).size.width * (((double.parse('50')) / 100) - 0.039),
              //               decoration: BoxDecoration(
              //                   color: Theme.of(context).primaryColor,
              //                   borderRadius: BorderRadius.only(
              //                     topLeft: Radius.circular(6),
              //                     bottomLeft: Radius.circular(6),
              //                   )),
              //             ),
              //             SizedBox(width: 4,),
              //             Container(
              //               height: 40,
              //               width: MediaQuery.of(context).size.width * (((double.parse('50')) / 100) - 0.025),
              //               decoration: BoxDecoration(
              //                   color: Theme.of(context).primaryColor,
              //                   borderRadius: BorderRadius.only(
              //                     topRight: Radius.circular(6),
              //                     bottomRight: Radius.circular(6),
              //                   )),
              //             )
              //           ],
              //         ),
              //       ),
              //       Positioned(
              //           right: 10,
              //           top: 9,
              //           child: Text(
              //             "home %",
              //             style: Theme.of(context).textTheme.titleLarge,
              //           )),
              //       Positioned(
              //           left: 10,
              //           top: 9,
              //           child: Text(
              //             "away %",
              //             style: Theme.of(context).textTheme.titleLarge,
              //           )),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'عام',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
                        ),
                        SizedBox(height: 10,),
                        ListView.builder(
                            physics:
                            NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: matchStatistics.data![0].statistics.length,
                            itemBuilder: (context, index) {
                              var homeStatistics = matchStatistics.data![0].statistics[index];
                              var awayStatistics = matchStatistics.data![1].statistics[index];
                              return Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 60,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 7, right: 7, top: 5, bottom: 2),
                                        child: Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                color: homeStatistics.value > awayStatistics.value
                                                    ? Theme.of(context).primaryColor
                                                    : null
                                            ),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.only(right: 6, left: 6, top: 3, bottom: 3),
                                              child: Text(homeStatistics.value.toString(),
                                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: homeStatistics.value > awayStatistics.value ?Colors.white:null)
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                          homeStatistics.type,
                                          style: Theme.of(context).textTheme.bodyMedium
                                      ),
                                    ),
                                    Container(
                                      width: 60,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(left: 7, right: 7, top: 5, bottom: 2),
                                        child: Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                color: awayStatistics.value > homeStatistics.value
                                                    ? Theme.of(context).primaryColor
                                                    : null),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.only(right: 6, left: 6, top: 3, bottom: 3),
                                              child: Text(awayStatistics.value.toString(),
                                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: awayStatistics.value > homeStatistics.value ?Colors.white:null)
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          onFailure: (state) => SizedBox()),

    );
  }
}
