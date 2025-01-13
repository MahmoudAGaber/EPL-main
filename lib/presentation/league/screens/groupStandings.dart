import 'package:epl/Data/StateModel.dart';
import 'package:epl/presentation/fixture/provider/fixtureViewModel.dart';
import 'package:epl/shared/Views/custom/standingLabels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../shared/Views/custom/custom_loader.dart';
import '../../../shared/Views/custom/teamInStanding.dart';
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
    var groupStandings = ref.watch(matchTableProvider);
    var matchInfo = ref.watch(MatchInfoProvider);

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
                StandingLabels()
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
                              String homeId = matchInfo.data!.teams.home.id;
                              String awayId = matchInfo.data!.teams.away.id;
                              return TeamInStanding(
                                groupTeam:teams,
                                isMatchFixture:true,
                                isGroups: true,
                                awayId: awayId,
                                homeId: homeId,
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
            // ListView.builder(
            //     physics: BouncingScrollPhysics(),
            //     shrinkWrap: true,
            //     itemCount:5,
            //     itemBuilder: (context, indexx) {
            //       return Padding(
            //         padding: const EdgeInsets.only(
            //             right: 10, bottom: 5, left: 10, top: 5),
            //         child: Row(
            //           children: [
            //             Container(
            //               width: 12,
            //               height: 12,
            //               decoration: BoxDecoration(
            //                   borderRadius:
            //                   BorderRadius.circular(4),
            //                   color: Colors.green),
            //             ),
            //             SizedBox(
            //               width: 10,
            //             ),
            //             Text("text")
            //           ],
            //         ),
            //       );
            //     })
          ],

        ),
      ),
      onFailure: (state)=> Center(child: Text("FAILD"),),
    );

  }
}
