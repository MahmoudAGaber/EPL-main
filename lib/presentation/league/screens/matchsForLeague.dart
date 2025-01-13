
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epl/Data/StateModel.dart';
import 'package:epl/presentation/league/provider/LeagueViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/Utils/Constants.dart';
import '../../../shared/Utils/date_converter.dart';
import '../../../shared/Views/custom/custom_imageView.dart';
import '../../../shared/Views/custom/custom_loader.dart';
import '../../fixture/screens/matchInfo.dart';
import 'dart:ui' as ui;


class matchesForLeague extends ConsumerStatefulWidget {
  String? url;
  matchesForLeague({this.url});
  @override
  _matchesForLeagueState createState() => _matchesForLeagueState();
}

class _matchesForLeagueState extends ConsumerState<matchesForLeague> {

  ScrollController? con;
  double offest = 0.0;
  List? dropList;
  String? selectedItem;
  String? seasonId;

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
    var leagueSeason = ref.watch(leagueSeasonsProvider);
    var matches = ref.watch(leagueMatchesProvider);
    var table = ref.watch(leagueStandingProvider);

    if(table.data !=null){
      seasonId = table.data!.seasonId;
    }
    return leagueSeason.handelState(
        onLoading: (state) => CustomLoader(),
        onSuccess: (state) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child:DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                  ),
                  // Ensure the value matches exactly one item in the dropdown
                  value: selectedItem ?? leagueSeason.data!.competition.season.first.name,
                  isExpanded: true,
                  menuMaxHeight: 300,
                  items: leagueSeason.data!.competition.season.map((e) => e.name).toSet().map((name) => DropdownMenuItem<String>(
                    value: name,
                    onTap: () {
                      final season = leagueSeason.data!.competition.season.firstWhere((e) => e.name == name);
                      seasonId = season.seasonId;
                      ref.read(leagueMatchesProvider.notifier).getMatches(season.seasonId,);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      child: Text(
                        name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedItem = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),

              matches.handelState(
                  onLoading: (state)=> CustomLoader(),
                  onSuccess: (state)=> Card(
                    child: Column(
                      children: <Widget>[
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: matches.data!.length,
                            itemBuilder: (context, index) {
                              var match = matches.data![index];
                              return  GestureDetector(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(match.fixture.date != "" ? DateConverter.isoDayWithDateString(match.fixture.date):"-",
                                            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12),
                                          ),
                                          Row(
                                            children: [
                                              //CircleAvatar(radius: 8,),
                                              SizedBox(width: 2,),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(12)),
                                                ),
                                                child: Text(match.league.name,
                                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12.5),
                                                ),
                                              )
                                            ],
                                          )

                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MatchInfo(fixtureId: match.fixture.id,seasonId: match.league.season,homeId: match.teams.home.id,awayId:  match.teams.away.id,)));
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                flex: 4,
                                                child: Container(width: MediaQuery.of(context).size.width * .4,
                                                    height: 40,
                                                    child: Stack(
                                                      children: [
                                                        Center(
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Flexible(
                                                                child: Text(match.teams.home.name,
                                                                  textDirection: ui.TextDirection.ltr,
                                                                  style: Theme.of(context).textTheme.bodyMedium,
                                                                  overflow: TextOverflow.clip,
                                                                ),
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
                                                      ],)),
                                              ),
                                              Flexible(
                                                flex: 5,
                                                child: Container(
                                                  height: 40,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(left: 14),
                                                        child:  SizedBox(
                                                          width: 28,
                                                          height: 28,
                                                          child:CustomImage(imgUrl:"${Constants.teamImage}${match.teams.home.id}.png",)
                                                        ),
                                                      ),
                                                      match.fixture.status.long == "Not Started"
                                                          ? Text(DateConverter.isoStringToLocalTimeOnly(match.fixture.date),
                                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                                                      )
                                                          :  match.fixture.status.long == 'Postponed'
                                                          ? Text('time',
                                                          style: Theme.of(context).textTheme.bodyMedium
                                                      )
                                                          : Padding(
                                                        padding: const EdgeInsets.only(top: 8),
                                                        child: Text("${match.score.fulltime.home} - ${match.score.fulltime.away}",
                                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(right: 14),
                                                        child:  SizedBox(
                                                          width: 28,
                                                          height: 28,
                                                          child: CustomImage(imgUrl:"${Constants.teamImage}${match.teams.away.id}.png",)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 4,
                                                child: Container(
                                                  height: 40,
                                                  width:
                                                  MediaQuery.of(context).size.width * .4,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        child: Text(match.teams.away.name,
                                                          textDirection: ui.TextDirection.rtl,
                                                          style: Theme.of(context).textTheme.bodyMedium,
                                                          overflow: TextOverflow.clip,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    Divider(
                                      height: 2.0,
                                    )
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                  onFailure: (state)=> Text("Shit")
              )


            ],
          ),
        ),
        onFailure: (state) => Text("Shit")
    );
  }
}
