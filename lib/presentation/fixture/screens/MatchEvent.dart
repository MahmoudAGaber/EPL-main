import 'package:epl/Data/StateModel.dart';
import 'package:epl/domain/Models/Event.dart';
import 'package:epl/domain/Models/Standing.dart';
import '../../../shared/Utils/Constants.dart';
import '../../../shared/Utils/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../shared/Views/custom/custom_loader.dart';
import '../../../shared/Views/custom/standingLabels.dart';
import '../../../shared/Views/custom/teamInStanding.dart';
import '../provider/fixtureViewModel.dart';




class MatchEvents extends ConsumerStatefulWidget {
  String? fixture_id;
  String? homeId;
  String? awayId;
  MatchEvents({this.fixture_id,this.homeId, this.awayId});
  @override
  _MatchEventsState createState() => _MatchEventsState();
}

class _MatchEventsState extends ConsumerState<MatchEvents> {
  TextStyle _textStyle2 =
      TextStyle(fontFamily: 'Vazirmatn', color: Colors.green);
  TextStyle _textStyle3 = TextStyle(fontFamily: 'Vazirmatn', color: Colors.red);

  TextStyle headline = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 11, fontWeight: FontWeight.w600);
  TextStyle titleMedium =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 13.5, color: Colors.grey);
  TextStyle content = TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 13.5,
  );

  List<Standing>? table = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var matchInfo = ref.watch(MatchInfoProvider);
    var events = ref.watch(matchEventsProvider);
    var teamForm = ref.watch(matchTeamFormProvider);
    var table = ref.watch(matchTableProvider);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(children: <Widget>[
        matchInfo.handelState(
            onLoading: (state) => CustomLoader(),
            onSuccess: (state) => Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 16, left: 16, top: 12, bottom: 8),
                              child: Text('من تعتقد سيفوز',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ),
                            Divider(),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 10, bottom: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {},
                                          child: SizedBox(
                                            width: 35,
                                            height: 35,
                                            child: Image.network(
                                              "${Constants.teamImage}${widget.homeId}.png",
                                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                                return CircleAvatar(backgroundColor: Colors.grey,);
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.surface,
                                              borderRadius: BorderRadius.circular(50)),
                                          child: Icon(
                                            Icons.clear,
                                            size: 25,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: SizedBox(
                                            width: 35,
                                            height: 35,
                                            child: Image.network(
                                              "${Constants.teamImage}${widget.awayId}.png",
                                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                                return CircleAvatar(backgroundColor: Colors.grey,);
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            width: MediaQuery.of(context).size.width * .25,
                                            child: Center(child: Text(
                                              matchInfo.data!.teams.home.name!,
                                              style: Theme.of(context).textTheme.titleSmall,
                                            ))),
                                        Container(
                                            width: MediaQuery.of(context).size.width * .25,
                                            child: Center(child: Text('تعادل',
                                              style: Theme.of(context).textTheme.titleSmall,
                                            ))),
                                        Container(
                                            width: MediaQuery.of(context).size.width * .25,
                                            child: Center(
                                                child: Text(
                                              matchInfo.data!.teams.away.name!,
                                              style: Theme.of(context).textTheme.titleSmall,
                                            ))),
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 16, left: 16, top: 12, bottom: 8),
                              child: Text('تفاصيل المباراة',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      // CircleAvatar(radius: 10,),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('المسابقة',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            matchInfo.data!.league.name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                            maxLines: 2,
                                            softWrap: true,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 22,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('ضربة البداية',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                          Text(
                                            DateConverter.isoDayWithDateString(
                                                matchInfo.data!.fixture.date),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                            maxLines: 2,
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 22,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('ملعب المباراة',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                          Text(
                                            matchInfo
                                                .data!.fixture.venue!.name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                            maxLines: 2,
                                            softWrap: true,
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    events.handelState(
                        onLoading: (state) => Center(child: SizedBox(),),
                        onSuccess: (state) => Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: events.data!.length,
                              itemBuilder: (context, index) {
                                return Event(events.data![index]);
                              },
                            ),
                          ),
                        ),
                        onFailure: (state) => SizedBox()),
                    SizedBox(
                      height: 5,
                    ),
                    teamForm.handelState(
                        onLoading: (state) => Center(child: SizedBox(),),
                        onSuccess: (state) => Container(
                          //height: 270,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 16, left: 16, top: 12, bottom: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "نتائج الفرق".tr,
                                        style: Theme.of(context).textTheme.titleMedium,
                                      )
                                    ],
                                  ),
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          // height: 190,
                                          child: ListView.builder(
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                              teamForm.data!.teamForm1.length,
                                              itemBuilder: (context, index) {
                                                var home = teamForm.data!.teamForm1[index];
                                                return Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 3,
                                                      right: 25,
                                                      top: 8,
                                                      bottom: 8),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 25,
                                                        height: 25,
                                                        child: Image.network(
                                                          "${Constants.teamImage}${widget.homeId}.png",
                                                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                                            return CircleAvatar(backgroundColor: Colors.grey,);
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        height: 21,
                                                        width: 35,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                6),
                                                            color: home.teams.home
                                                                .winner ==
                                                                'team_A'
                                                                ? Colors.green
                                                                : home.teams.home
                                                                .winner ==
                                                                'team_B'
                                                                ? Colors.red
                                                                : home.teams.home
                                                                .winner ==
                                                                'draw'
                                                                ? Colors.black45
                                                                : null),
                                                        child: Center(
                                                            child: Text(
                                                              "${home.score.fulltime.home} - ${home.score.fulltime.away}",
                                                              style: TextStyle(
                                                                  fontFamily: 'Vazirmatn',
                                                                  color: Colors.white,
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 12),
                                                            )),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                       SizedBox(
                                                        width: 25,
                                                        height: 25,
                                                        child: Image.network(
                                                          "${Constants.teamImage}${widget.awayId}.png",
                                                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                                            return CircleAvatar(backgroundColor: Colors.grey,);
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                      Flexible(
                                        child: Container(
                                          // height: 190,
                                          child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                              teamForm.data!.teamForm2.length,
                                              itemBuilder: (context, index) {
                                                var away =
                                                teamForm.data!.teamForm2[index];
                                                return Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 25,
                                                      right: 3,
                                                      top: 8,
                                                      bottom: 8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    children: [
                                                      SizedBox(
                                                        width: 25,
                                                        height: 25,
                                                        child: Image.network(
                                                          "${Constants.teamImage}${widget.awayId}.png",
                                                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                                            return CircleAvatar(backgroundColor: Colors.grey,);
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        height: 21,
                                                        width: 35,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                6),
                                                            color: away.teams.home
                                                                .winner ==
                                                                'team_A'
                                                                ? Colors.green
                                                                : away.teams.home
                                                                .winner ==
                                                                'team_B'
                                                                ? Colors.red
                                                                : away.teams.home
                                                                .winner ==
                                                                'draw'
                                                                ? Colors.black45
                                                                : null),
                                                        child: Center(
                                                            child: Text(
                                                              "${away.score.fulltime.home} - ${away.score.fulltime.away}",
                                                              style: TextStyle(
                                                                  fontFamily: 'Vazirmatn',
                                                                  color: Colors.white,
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 12),
                                                            )),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 25,
                                                        height: 25,
                                                        child: Image.network(
                                                          "${Constants.teamImage}${widget.homeId}.png",
                                                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                                            return CircleAvatar(backgroundColor: Colors.grey,);
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onFailure: (state) => SizedBox()),
                    SizedBox(
                      height: 5,
                    ),
                    table.handelState(
                        onLoading: (state) => Center(child: SizedBox(),),
                        onSuccess: (state) => Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(padding: const EdgeInsets.only(right: 16, left: 16, top: 12, bottom: 8),
                                        child: Row(
                                          children: [
                                            // CircleAvatar(radius: 10,),
                                            SizedBox(width: 5,),
                                            if(matchInfo.data!=null)
                                              Text(matchInfo.data!.league.name!,
                                                  style: Theme.of(context).textTheme.titleMedium),
                                          ],
                                        )),
                                    Divider(),
                                    StandingLabels(),
                                  ],
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: table.data!.standings[0].length,
                                    itemBuilder: (BuildContext context, index) {
                                      var team = table.data!.standings[0][index];
                                      if(team.team.id == widget.homeId || team.team.id == widget.awayId){
                                        return TeamInStanding(team: team,);

                                      }else{
                                        return SizedBox();
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                        onFailure: (state) => SizedBox()),
                  ],
                ),
            onFailure: (state) => SizedBox()),



        /*
                  SizedBox(height: 5,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16,left: 16,top: 12,bottom: 8),
                            child: Text(
                              'افضل الهدافين',
                              style: Theme.of(context).textTheme.titleMedium
                            ),
                          ),
                          Divider(),
                          Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 68,
                                      width: 110,
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration:
                                            BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius: BorderRadius.all(Radius.circular(50)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(Radius.circular(50),
                                                ),
                                                child: Image.asset("assets/Marcelo.jpg"),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                              right: 0,
                                              child: Container(
                                            height: 25,
                                            width: 26,
                                            child: Image.network(
                                                "https://www.eplworld.com${provider.msnModel.homeTeamLogo}"),
                                          )),
                                          Positioned(
                                              top: 0,
                                              left: 35,
                                              child: Container(
                                                height: 13,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  color: Colors.green,
                                                ),

                                              )),
                                          Positioned(
                                            left: 2,bottom: 0,
                                              child:  Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("مارسيلو",style: Theme.of(context).textTheme.bodyMedium,),
                                              Text('مهاجم',style: Theme.of(context).textTheme.bodySmall,)
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 68,
                                      width: 120,
                                      child: Stack(
                                        textDirection: TextDirection.ltr,
                                        children: <Widget>[
                                          Positioned(
                                            left: 15,
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration:
                                              BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(6.0),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(50),
                                                  ),
                                                  child: Image.asset("assets/Marcelo.jpg"),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              bottom: 0,
                                              left:5 ,
                                              child: Container(
                                                height: 25,
                                                width: 26,
                                                child: Image.network(
                                                    "https://www.eplworld.com${provider.msnModel.awayTeamLogo}"),
                                              )),
                                          Positioned(
                                              top: 0,
                                              left: 0,
                                              child: Container(
                                                height: 13,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  color: Colors.green,
                                                ),

                                              )),
                                          Positioned(
                                              right: 0,
                                              bottom: 0,
                                              child:  Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("مارسيلو",style: Theme.of(context).textTheme.bodyMedium,),
                                                  Text('مهاجم',style: Theme.of(context).textTheme.bodySmall,)
                                                ],
                                              ))
                                        ],
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
                                  style: Theme.of(context).textTheme.bodyMedium.copyWith(fontSize: 14))
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
                                            "اهداف",
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

                   */
      ]),
    );
  }

  Widget _goal(String homeTeamId, EventModel eventModel) {
    if (eventModel != null) {
      return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Directionality(
            textDirection: homeTeamId == eventModel.team.id
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: Container(
              child: Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text("${eventModel.time.elapsed}'",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                      eventModel.time.extra != null
                          ? Text("${eventModel.time.extra}+",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold))
                          : SizedBox(),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    MdiIcons.soccer,
                    size: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            eventModel.player.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 13),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          homeTeamId == eventModel.team.id
                              ? Text(
                                  "صانع الهدف : ${eventModel.assist.name}".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.black45))
                              : Text(
                                  "صانع الهدف : ${eventModel.assist.name}".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.black45))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ));
    } else {
      return SizedBox();
    }
  }

  Widget _switch(String homeTeamId, EventModel eventModel) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Directionality(
          textDirection: homeTeamId == eventModel.team.id
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Container(
            child: Row(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text("${eventModel.time.elapsed}'",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    eventModel.time.extra != null
                        ? Text("${eventModel.time.extra}+",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold))
                        : SizedBox(),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: 20,
                      height: 16,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 20,
                      height: 16,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 15,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          eventModel.player.name,
                          style: _textStyle2,
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          eventModel.assist.name!,
                          style: _textStyle3,
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget _var(String homeTeamId, EventModel eventModel) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Directionality(
          textDirection: homeTeamId == eventModel.team.id
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Container(
            child: Row(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("${eventModel.time.elapsed}'",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    eventModel.time.extra!.isNotEmpty
                        ? Text("${eventModel.time.extra}+",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold))
                        : SizedBox(),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  MdiIcons.television,
                  size: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(eventModel.player.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 13)),
                SizedBox(
                  width: 5,
                ),
                Text("outcome", style: Theme.of(context).textTheme.bodyMedium)
              ],
            ),
          ),
        ));
  }

  Widget _timerIntervals(String homeTeamId, EventModel eventModel) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("status",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
              SizedBox(
                width: 5,
              ),
              Icon(
                MdiIcons.timer,
                size: 22,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ],
          ),
        ));
  }

  Widget _yellow(String homeTeamId, EventModel eventModel) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Directionality(
          textDirection: homeTeamId == eventModel.team.id
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Container(
            child: Row(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("${eventModel.time.elapsed}'",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    eventModel.time.extra != null
                        ? Text("${eventModel.time.extra}+",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold))
                        : SizedBox(),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 23,
                  width: 15,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(eventModel.player.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 13))
              ],
            ),
          ),
        ));
  }

  Widget _redCard(String homeTeamId, EventModel eventModel) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Directionality(
          textDirection: homeTeamId == eventModel.team.id
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Container(
            child: Row(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("${eventModel.time.elapsed}'",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    eventModel.time.extra !=null
                        ? Text("${eventModel.time.extra}+",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold))
                        : SizedBox(),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 23,
                  width: 15,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(eventModel.player.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 13))
              ],
            ),
          ),
        ));
  }

  Widget _penaltyShot(String homeTeamId, EventModel eventModel) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Directionality(
          textDirection: homeTeamId == eventModel.team.id
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("${eventModel.time.elapsed}'",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    eventModel.time.extra!.isNotEmpty
                        ? Text("${eventModel.time.extra}+",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold))
                        : SizedBox(),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Stack(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      child: Image.asset(
                        "assets/penalty1.png",
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Text(eventModel.player.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 13)),
                SizedBox(
                  width: 5,
                ),
                Text("homeScore - awayScore",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 13))
              ],
            ),
          ),
        ));
  }

  Widget Event(EventModel eventModel) {
    var matchInfo = ref.watch(MatchInfoProvider);
    if(matchInfo.data !=null) {
      var homeTeamId = matchInfo.data!.teams.home.id;
      return Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                homeTeamId == eventModel.team.id
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        child: eventModel.type == "G"
                            ? _goal(homeTeamId, eventModel)
                            : eventModel.type == "YC"
                            ? _yellow(homeTeamId, eventModel)
                            : eventModel.type == "RC"
                            ? _redCard(homeTeamId, eventModel)
                            : eventModel.type == "subst"
                            ? _switch(homeTeamId, eventModel)
                            : eventModel.type == "VAR"
                            ? _var(homeTeamId, eventModel)
                            : eventModel.type ==
                            "penaltyShot"
                            ? _penaltyShot(
                            homeTeamId, eventModel)
                            : Container()),
                  ],
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        child: eventModel.type == "G"
                            ? _goal(homeTeamId, eventModel)
                            : eventModel.type == "YC"
                            ? _yellow(homeTeamId, eventModel)
                            : eventModel.type == "RC"
                            ? _redCard(homeTeamId, eventModel)
                            : eventModel.type == "subst"
                            ? _switch(homeTeamId, eventModel)
                            : eventModel.type == "VAR"
                            ? _var(homeTeamId, eventModel)
                            : eventModel.type ==
                            "penaltyShot"
                            ? _penaltyShot(
                            homeTeamId, eventModel)
                            : Container()),
                  ],
                ),
              ],
            )),
      );
    }
      return SizedBox();

  }
}
