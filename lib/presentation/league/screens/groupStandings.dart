import 'package:epl/Data/StateModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../shared/Views/custom/custom_loader.dart';
import '../provider/LeagueViewModel.dart';
import '../../team/screens/teamHome.dart';



class MatchGPosition extends ConsumerStatefulWidget {
  String? url;
  String? homeId;
  String? awayId;
  MatchGPosition({this.url, this.homeId, this.awayId});
  @override
  _MatchGPositionState createState() => _MatchGPositionState();
}

class _MatchGPositionState extends ConsumerState<MatchGPosition> {
  TextStyle tapbar = TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 13,
  );
  TextStyle headline = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 11, fontWeight: FontWeight.w600);
  TextStyle titleMedium =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 13.5, color: Colors.grey);
  TextStyle content = TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 13.5,
  );
  @override
  List? dropList;
  String? selectedItem;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var groupStandings = ref.watch(LeagueGroupStandingProvider);

    return groupStandings.handelState(
      onLoading: (state)=> CustomLoader(),
      onSuccess: (state)=> Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            //  Card(
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20)),
            //   child: DropdownButtonFormField<String>(
            //     decoration: InputDecoration(
            //       enabledBorder: InputBorder.none,
            //     ),
            //     value: selectedItem,
            //     isExpanded: true,
            //     menuMaxHeight: 300,
            //     items: provider.dropsTableRows.map((String value) {
            //       return DropdownMenuItem<String>(
            //         onTap: () {
            //           provider.dropTableRowsList.forEach((element) {
            //             if (value == element.text) {
            //               provider.getTables(
            //                   widget.url, "tables/${element.value}");
            //             }
            //           });
            //         },
            //         value: value,
            //         child: Padding(
            //           padding:
            //           const EdgeInsets.only(right: 8, left: 8),
            //           child: Text(value,style: Theme.of(context).textTheme.bodyMedium),
            //         ),
            //       );
            //     }).toList(),
            //     onChanged: (value) {
            //       setState(() {
            //         selectedItem = value;
            //       });
            //     },
            //   ),
            // ),
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
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 16.0),
                  child: Container(
                    width:
                    MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.41,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Text("المركز", style: TextStyle(
                                    fontFamily:
                                    'Vazirmatn',
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(
                                left: 3, right: 15),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "ل".tr,
                                    style: titleMedium,
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Expanded(
                                    child: Text(
                                      "ف".tr,
                                      style: titleMedium,
                                    )),
                                SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                    child: Text(
                                      "ت".tr,
                                      style: titleMedium,
                                    )),
                                SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                    child: Text(
                                      "خ".tr,
                                      style: titleMedium,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context)
                              .size
                              .width *
                              0.22,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "-/+",
                                style: titleMedium,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "ن".tr,
                                style: titleMedium,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: groupStandings.data!.standings[0].length,
              itemBuilder: (BuildContext context, index) {
                var groups = groupStandings.data!.standings[0][index];

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
                                    Text(groups.groupTitle,
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
                            itemCount: groups.teams.length,
                            itemBuilder: (BuildContext context, innerIndex) {
                              var teams = groups.teams[innerIndex];

                              return Container(
                                height: 60,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 6,
                                      right: 1,
                                      left: 1,
                                      child: Container(
                                        height: 60,
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => HomeTeam(
                                                            teamName: "",
                                                            teamId: "",
                                                          )
                                                      )
                                                  );
                                                },
                                                child:  Padding(
                                                  padding: const EdgeInsets.only(right: 12,left: 12),
                                                  child: Container(
                                                    width:
                                                    MediaQuery.of(context).size.width*0.87,
                                                    height: 35,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text(teams.rank,
                                                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),),
                                                              ],
                                                            ),
                                                            SizedBox(width: 3,),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  child: Container(
                                                                      width: 35,
                                                                      height: 28,
                                                                      child: CircleAvatar()),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                          ],
                                                        ),
                                                        Flexible(
                                                            flex: 4,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                              children: [
                                                                Flexible(
                                                                  child: FittedBox(
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.only(left: 5,right: 5),
                                                                      child: Text(teams.team.name,
                                                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )),
                                                        Flexible(
                                                          flex: 6,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.center,
                                                                children: [
                                                                  Text(teams.all.played,
                                                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.center,
                                                                children: [
                                                                  Text(teams.all.win,
                                                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.center,
                                                                children: [
                                                                  Text(teams.all.draw,
                                                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.center,
                                                                children: [
                                                                  Text(teams.all.lose,
                                                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.center,
                                                                children: [
                                                                  Text("${int.parse(teams.all.goals.forGoals) - int.parse(teams.all.goals.againstGoals)}",
                                                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                                children: [
                                                                  Text(teams.all.points,
                                                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    Positioned(
                                        child: Divider(
                                          height: 7,
                                        )),
                                    Positioned(
                                      top: 8,
                                      bottom: 2,
                                      child: Container(
                                          width: 2,
                                          height: 40,
                                          color: Colors.green),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount:5,
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
                              color: Colors.green),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("text")
                      ],
                    ),
                  );
                })
          ],

        ),
      ),
      onFailure: (state)=> Center(child: Text("FAILD"),),
    );

  }
}
