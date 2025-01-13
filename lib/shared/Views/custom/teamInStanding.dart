

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/Models/GroupStandings.dart';
import '../../../domain/Models/Standing.dart';
import '../../../presentation/team/screens/teamHome.dart';
import '../../Utils/Constants.dart';
import '../../helper/colors.dart';
import 'custom_imageView.dart';

class TeamInStanding extends StatelessWidget {
  Standing? team;
  TeamStanding? groupTeam;
  bool? isMatchFixture;
  String? teamId;
  String? homeId;
  String? awayId;
  String? zoneColor;
  bool? isGroups;
   TeamInStanding({this.team, this.groupTeam, this.isMatchFixture = false,this.teamId,this.homeId,this.awayId,this.zoneColor,this.isGroups = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: !isGroups! ?Stack(
        children: [
          Positioned(
            top: 6,
            right: 1,left: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: isMatchFixture!
                    ?((team!.team.id == awayId) || (team!.team.id == homeId)
                    ? Theme.of(context).scaffoldBackgroundColor
                    : null)
                    :((team!.team.id == teamId)
                    ? Theme.of(context).scaffoldBackgroundColor
                    : null),
              ),
              height: 60,

              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeTeam(
                                      teamName: team!.team.name,
                                      teamId: team!.team.id,

                                    )));
                      },
                      child: Padding(
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
                                      SizedBox(
                                        width: 18,
                                        child: Center(
                                          child: Text(team!.rank,
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 3,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: SizedBox(
                                          width: 26,
                                          height: 26,
                                          child: CustomImage(imgUrl: "${Constants.teamImage}${team!.team.id}.png",)
                                        ),
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
                                            child: Text(team!.team.name,
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
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                      children: [
                                        Text(team!.all.played,
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                      children: [
                                        Text(team!.all.win,
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(team!.all.draw,
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(team!.all.lose,
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text("${int.parse(team!.all.goals.goalsFor) - int.parse(team!.all.goals.goalsAgainst)}",
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(team!.all.points,
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
          Positioned(child: Divider(height: 7,)),
          Positioned(
            top: 8,
            bottom: 2,
            child: Container(
              width: 2,
              height: 40,
              color: team!.all.zoneColor.isNotEmpty ?ColorConverter.hexToColor(team!.all.zoneColor):null
            ),
          ),
        ],
      ):Stack(
        children: [
          Positioned(
            top: 6,
            right: 1,left: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: isMatchFixture!
                    ?((groupTeam!.team.id == awayId) || (groupTeam!.team.id == homeId)
                    ? Theme.of(context).scaffoldBackgroundColor
                    : null)
                    :((groupTeam!.team.id == teamId)
                    ? Theme.of(context).scaffoldBackgroundColor
                    : null),
              ),
              height: 60,

              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeTeam(
                                      teamName: groupTeam!.team.name,
                                      teamId: groupTeam!.team.id,

                                    )));
                      },
                      child: Padding(
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
                                      SizedBox(
                                        width: 18,
                                        child: Center(
                                          child: Text(groupTeam!.rank,
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 3,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: SizedBox(
                                          width: 26,
                                          height: 26,

                                          child:CustomImage(imgUrl: "${Constants.teamImage}${groupTeam!.team.id}.png",)
                                        ),
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
                                            child: Text(groupTeam!.team.name,
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
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                      children: [
                                        Text(groupTeam!.all.played,
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                      children: [
                                        Text(groupTeam!.all.win,
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(groupTeam!.all.draw,
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(groupTeam!.all.lose,
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text("${int.parse(groupTeam!.all.goals.forGoals) - int.parse(groupTeam!.all.goals.againstGoals)}",
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(groupTeam!.all.points,
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
          Positioned(child: Divider(height: 7,)),
          Positioned(
            top: 8,
            bottom: 2,
            child: Container(
                width: 2,
                height: 40,
                color: groupTeam!.all.zoneColor.isNotEmpty ?ColorConverter.hexToColor(groupTeam!.all.zoneColor):null
            ),
          ),
        ],
      ),
    );
  }
}
