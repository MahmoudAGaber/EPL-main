import 'package:epl/Data/StateModel.dart';
import 'package:epl/shared/helper/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/Views/custom/custom_loader.dart';
import '../../../shared/Views/custom/standingLabels.dart';
import '../../../shared/Views/custom/teamInStanding.dart';
import '../../team/provider/TeamViewModel.dart';
import '../provider/fixtureViewModel.dart';


class MatchStanding extends ConsumerStatefulWidget {
  String? url;
  String? homeId;
  String? awayId;
  String? seasonId;

  MatchStanding({this.url, this.homeId, this.awayId, this.seasonId});

  @override
  _MatchPostionsState createState() => _MatchPostionsState();
}



class _MatchPostionsState extends ConsumerState<MatchStanding> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var table = ref.watch(matchTableProvider);
    var matchInfo = ref.watch(MatchInfoProvider);
    var standingType = ref.watch(StandingTypeProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 16),
                child: table.handelState(
                    onLoading: (state) => Center(
                      child: CustomLoader(),
                    ),
                  onSuccess: (state)=> Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap:(){
                              ref.read(matchTableProvider.notifier).fetchMatchTable(matchInfo.data!.league.season!,'total');
                              ref.read(StandingTypeProvider.notifier).state = StandingType.All;
                            },
                            child: Container(
                              width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: standingType == StandingType.All ? Theme.of(context).primaryColor :Colors.white
                              ),
                              child: Center(child: Text('الكل',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: standingType == StandingType.All? Colors.white : null),)),
                            ),
                          ),
                          SizedBox(width: 20,),
                          InkWell(
                            onTap: (){
                              ref.read(matchTableProvider.notifier).fetchMatchTable(matchInfo.data!.league.season!,'home');
                              ref.read(StandingTypeProvider.notifier).state = StandingType.Home;
                            },
                            child: Container(
                              width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: standingType == StandingType.Home ? Theme.of(context).primaryColor :Colors.white
                              ),
                              child: Center(child: Text('ذهاب',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: standingType == StandingType.Home? Colors.white : null),)),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              ref.read(matchTableProvider.notifier).fetchMatchTable(matchInfo.data!.league.season!,'away');
                              ref.read(StandingTypeProvider.notifier).state = StandingType.Away;
                            },
                            child: Container(
                              width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: standingType == StandingType.Away ? Theme.of(context).primaryColor :Colors.white
                              ),
                              child: Center(child: Text('اياب',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: standingType == StandingType.Away? Colors.white : null),)),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 8,),

                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(right: 16,left: 16,top: 12,bottom: 8),
                                    child: Row(
                                      children: [
                                        // CircleAvatar(radius: 10,),
                                        SizedBox(width: 5,),
                                        Text(table.data!.name,
                                            style: Theme.of(context).textTheme.titleMedium
                                        ),
                                      ],
                                    )
                                ),
                                Divider(),
                                StandingLabels()
                              ],
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: ClampingScrollPhysics(),
                                itemCount: table.data!.standings![0].length,
                                itemBuilder: (BuildContext context, index) {
                                  var team = table.data!.standings![0][index];
                                  String homeId = matchInfo.data!.teams.home.id;
                                  String awayId = matchInfo.data!.teams.away.id;

                                  return TeamInStanding(team:team,homeId:homeId,awayId:awayId,isMatchFixture:true);
                                }),



                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Card(
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(8)),
                      //   child: ListView.builder(
                      //       physics: BouncingScrollPhysics(),
                      //       shrinkWrap: true,
                      //       itemCount: ref.watch(TableProvider.notifier).getLeagueZones().length,
                      //       itemBuilder: (context, index) {
                      //         var zone = ref.watch(TableProvider.notifier).getLeagueZones()[index];
                      //         return Padding(
                      //           padding: const EdgeInsets.only(
                      //               right: 10, bottom: 10, left: 10, top: 10),
                      //           child: Row(
                      //             children: [
                      //               Container(
                      //                 width: 12,
                      //                 height: 12,
                      //                 decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.circular(4),
                      //                     color: ColorConverter.hexToColor(zone.zoneColor)),
                      //               ),
                      //               SizedBox(
                      //                 width: 10,
                      //               ),
                      //               Text(zone.zoneStart,style:Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13.5),)
                      //             ],
                      //           ),
                      //         );
                      //       }),
                      // )
                    ],),
                    onFailure: (state) => SizedBox()),
              );
  }
}
