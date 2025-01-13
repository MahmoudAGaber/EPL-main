import 'package:epl/Data/StateModel.dart';
import 'package:epl/domain/models/Teams/teamOverview.dart';
import 'package:epl/presentation/fixture/screens/matchInfo.dart';
import 'package:epl/shared/Views/custom/standingLabels.dart';
import 'package:epl/shared/Views/custom/teamInStanding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../../../shared/Utils/Constants.dart';
import '../../../shared/Utils/date_converter.dart';
import '../../../shared/Views/custom/custom_imageView.dart';
import '../../../shared/Views/custom/custom_loader.dart';
import '../../../webView.dart';
import '../../fixture/screens/EndMatches/matchInfo_a.dart';
import '../../playrers/screens/playerHome.dart';
import '../provider/TeamViewModel.dart';
import 'teamHome.dart';

class OverView extends ConsumerStatefulWidget {
  String? url;
  String? id;
  OverView({this.url, this.id});
  @override
  _OverViewState createState() => _OverViewState();
}

class _OverViewState extends ConsumerState<OverView> {

  TextStyle tapbar = TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 13,
  );
  TextStyle headline = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 11, fontWeight: FontWeight.w600);
  TextStyle titleMedium =
  TextStyle(fontFamily: 'Vazirmatn', fontSize: 14, color: Colors.grey);
  TextStyle content = TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 13.5,
  );
  List<String> icons = [
    'assets/matchsIcon.png',
    'assets/passesIcon.png',
    'assets/goalsIcon.png',
        'assets/goalsIcon.png'
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var teamOverview = ref.watch(teamOverviewProvider);
    return SafeArea(
      bottom: true,
      minimum: EdgeInsets.only(bottom: 10.0),
      child: teamOverview.handelState(
        onLoading: (state)=> CustomLoader(),
        onFailure: (state)=> Text("Shit"),
        onSuccess: (state)=> Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              teamOverview.data!.fixtures.isNotEmpty
                  ? Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 14, left: 14, top: 8, bottom: 8),
                          child: Text("المباره الاخيره".tr,
                              style: Theme.of(context).textTheme.titleMedium),
                        )
                      ],
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 110,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            physics: PageScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 1,
                            itemBuilder: (BuildContext context, index) {
                              int size  = teamOverview.data!.fixtures.where((element) => element.fixture.status.short == "FT").toList().length;
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics:PageScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: size,
                                  itemBuilder: (context, index) {
                                    var matches = teamOverview.data!.fixtures[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context, MaterialPageRoute(
                                                builder: (context) =>
                                                    MatchInfo(
                                                      url: "",
                                                    )));
                                      },
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * .83,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Text(matches.fixture.date != "" ? DateConverter.isoDayWithDateString(matches.fixture.date):"-",
                                                      style: Theme.of(context).textTheme.bodySmall),
                                                  Row(
                                                    children: [
                                                      //CircleAvatar(radius: 8,),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(matches.league.name, style: Theme.of(context).textTheme.bodySmall)
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Flexible(
                                                      flex: 5,
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width *.41,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Flexible(
                                                              child: Text(matches.teams.home.name,
                                                                style: Theme.of(context).textTheme.bodyMedium,
                                                                overflow: TextOverflow.clip, textDirection: TextDirection.ltr,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 7,
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width * .42,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 10),
                                                              child: Container(
                                                                width: 37,
                                                                height: 30,
                                                                child: CustomImage(imgUrl: "${Constants.teamImage}${matches.teams.home.id}.png")
                                                              ),
                                                            ),
                                                            Text("${matches.score.fulltime.home} - ${matches.score.fulltime.away}",
                                                                style: Theme.of(context).textTheme.bodyMedium
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(right: 10),
                                                              child: Container(
                                                                  width: 37,
                                                                  height: 30,
                                                                  child: CustomImage(imgUrl: "${Constants.teamImage}${matches.teams.away.id}.png",)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 5,
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width * .4,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Flexible(
                                                              child: Text(matches.teams.away.name,
                                                                style: Theme.of(context).textTheme.bodyMedium,
                                                                overflow: TextOverflow.clip,
                                                                textDirection: TextDirection.rtl,
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
                                      ),
                                    );
                                  });
                            }),
                      ),
                    )
                  ],
                ),
              )
                  :SizedBox(),
              SizedBox(height: 16,),
              Stack(children: <Widget>[
                Container(
                  height: 260,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                    ),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: teamOverview.data!.news.documents.length,
                        itemBuilder: (BuildContext context, index) {
                          var news = teamOverview.data!.news.documents[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Container(
                                height: 200,
                                width: 230,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> WebView(url:news.url)));

                                  },
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 100,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.only(topRight: Radius.circular(10),
                                                  topLeft: Radius.circular(10))
                                          ),
                                          child: ClipRRect(
                                            child: Image.network(news.urlToImage, fit: BoxFit.cover),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                topLeft: Radius.circular(10)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(news.title,
                                                    style: Theme.of(context).textTheme.bodyMedium
                                                    !.copyWith(),
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      children: <Widget>[
                                                        Text(news.channelTitle,
                                                          style: Theme.of(context).textTheme.bodyMedium
                                                          !.copyWith(fontSize: 13),
                                                          overflow: TextOverflow.visible,
                                                        ),
                                                        SizedBox(width: 8,),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Text(DateConverter.timeAgoSinceDate(news.publishedAt),
                                                            style: Theme.of(context).textTheme.bodySmall)
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )


                                      ],
                                    ),
                                  ),
                                )),
                          );
                        }),
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 8,
                    child: Row(
                      children: <Widget>[
                        Text("اخر الاخبار".tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium)
                      ],
                    )),
              ]),
              SizedBox(height: 8,),
              // Card(
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8)),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: <Widget>[
              //       Column(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           Padding(
              //               padding: const EdgeInsets.only(
              //                   right: 16, left: 16, top: 12, bottom: 8),
              //               child: Row(
              //                 children: [
              //                   // CircleAvatar(radius: 10,),
              //                   SizedBox(
              //                     width: 5,
              //                   ),
              //                   Text(teamOverview.data!.playersStatistics.competition.name,
              //                       style: Theme.of(context)
              //                           .textTheme
              //                           .titleMedium),
              //                 ],
              //               )),
              //           Divider(),
              //           StandingLabels(),
              //         ],
              //       ),
              //       ListView.builder(
              //           shrinkWrap: true,
              //           scrollDirection: Axis.vertical,
              //           physics: ClampingScrollPhysics(),
              //           itemCount: 5,
              //           itemBuilder: (BuildContext context, index) {
              //             return TeamInStanding();
              //           }),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 20,),
              checkPlayerStatsLength(teamOverview.data!).isNotEmpty
                  ?Stack(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Container(
                    height: 305,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: ClampingScrollPhysics(),
                        itemCount: checkPlayerStatsLength(teamOverview.data!).length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> stats = checkPlayerStatsLength(teamOverview.data!)[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Container(
                              height: 220,
                              width: 270,
                              child: Card(
                                elevation: 3.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(children: <Widget>[
                                        Container(
                                            height: 18,width: 18,
                                            child: Image.asset(icons[index],color: Theme.of(context).colorScheme.secondary,)
                                        ),
                                        SizedBox(width: 10,),
                                        Text(stats['type'],
                                            style: Theme.of(context).textTheme.titleSmall
                                        )
                                      ]),
                                    ),
                                    Column(
                                      children: List.generate(stats['person'].length > 3 ? 3:stats['person'].length, (innerIndex){
                                        TeamOverviewPersonModel person = stats['person'][innerIndex];

                                        if(innerIndex == 0){
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                            ),
                                            height: 95,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.symmetric(horizontal: 8),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(builder: (context) => Players())
                                                              );
                                                            },
                                                            child: Container(
                                                                height: 50,
                                                                width: 50,
                                                                child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(50),
                                                                    child: CustomImage(imgUrl: "${Constants.teamImage}${person.personId}.png",),
                                                                )
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(padding:
                                                      const EdgeInsets.symmetric(vertical: 4),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          SizedBox(height: 8,),
                                                          Text(person.name,
                                                              style: Theme.of(context).textTheme.bodyMedium
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Container(
                                                                height: 20,
                                                                width: 20,
                                                                child: CustomImage(imgUrl: "${Constants.teamImage}${person.teamId}.png",)
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              SizedBox(
                                                                width: 120,
                                                                child: Text(person.teamName,
                                                                    style: Theme.of(context).textTheme.bodySmall!,textAlign: TextAlign.start,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        Text(person.count,
                                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20)
                                                        ),
                                                      ],
                                                    ),
                                                  ]),
                                            ),
                                          );
                                        }else{
                                         return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                    children: <Widget>[
                                                      Text("${++innerIndex}",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16)),
                                                      SizedBox(
                                                        width: 12,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(builder: (context) => Players())
                                                          );
                                                        },
                                                        child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            child: ClipRRect(
                                                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                                                child:CustomImage(imgUrl: "${Constants.teamImage}${person.personId}.png",)
                                                            )
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          Text(
                                                            person.name,
                                                            style: Theme.of(context).textTheme.bodyMedium,
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                height: 14,
                                                                width: 14,
                                                                child: CustomImage(imgUrl:"${Constants.teamImage}${person.teamId}.png",)
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              SizedBox(
                                                                width: 120,
                                                                child: Text(person.teamName,
                                                                  style: Theme.of(context).textTheme.bodySmall,
                                                                ),
                                                              ),
                                                            ],
                                                          ),

                                                        ],
                                                      ),

                                                    ]),
                                                SizedBox(width: 25,),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context).primaryColor.withOpacity(.2),
                                                      borderRadius: BorderRadius.circular(4)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                                    child: Center(
                                                      child: Text(person.count,
                                                          style: Theme.of(context).textTheme.bodyMedium
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 8,
                    child: Row(
                      children: <Widget>[
                        Text(
                          "إحصائيات اللاعبين".tr,
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      ],
                    )),
              ])
                  :SizedBox(),

            ],
          ),
        ),
      )


    );
  }

  List<Map<String, dynamic>> checkPlayerStatsLength(TeamOverviewModel teamOverview) {
    List<Map<String, dynamic>> stats = [];
    var season = teamOverview.playersStatistics.competition.season;

    if (season.yellowCards != "") {
      stats.add({
        'type': 'yellowCards',
        'person': season.yellowCards.person,
      });
    }
    if (season.assists != "" ) {
      stats.add({
        'type': 'assists',
        'person': season.assists.person,
      });
    }
    if (season.redCards != "" ) {
      stats.add({
        'type': 'redCards',
        'person': season.redCards.person,
      });
    }
    if (season.goals != "" ) {
      stats.add({
        'type': 'goals',
        'person': season.goals.person,
      });
    }

    print("LENGTH OF STATS: ${stats.length}");

    return stats;
  }

}
