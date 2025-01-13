import 'package:epl/Data/StateModel.dart';
import 'package:epl/presentation/team/provider/TeamViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get/get.dart';

import '../../../shared/Views/custom/custom_loader.dart';
import '../../playrers/screens/playerHome.dart';


class TeamSquad extends ConsumerStatefulWidget {
  String? url;
  TeamSquad({this.url});
  @override
  _TeamSquadState createState() => _TeamSquadState();
}

class _TeamSquadState extends ConsumerState<TeamSquad> {


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var squad = ref.watch(teamSquadProvider);
    return squad.handelState(
        onLoading: (state)=> CustomLoader(),
        onSuccess: (state)=> Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4,bottom: 4),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8,bottom: 6,left: 16,right: 16),
                      child: Row(
                        children: <Widget>[
                          Text(
                              "المدرب".tr,
                              style: Theme.of(context).textTheme.titleMedium
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Players(playerId: ref.read(teamSquadProvider.notifier).getCoach().first.personId,)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8,bottom: 8,left: 16,right: 16),
                          child: Row(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        border: Border.all(
                                            width: 1, color: Colors.grey)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(100),
                                      ),
                                      child: CircleAvatar()
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(ref.read(teamSquadProvider.notifier).getCoach().first.name,
                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                              overflow: TextOverflow.visible,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  maxRadius: 8,
                                                  child: CircleAvatar()
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(ref.read(teamSquadProvider.notifier).getCoach().first.nationality,
                                                    style: Theme.of(context).textTheme.bodySmall
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8,bottom: 6,left: 16,right: 16),
                        child: Row(
                          children: <Widget>[
                            Text(
                                "حراس المرمي".tr,
                                style: Theme.of(context).textTheme.titleMedium
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(right: 16,left: 16,bottom: 16,top: 12),
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: List.generate(ref.read(teamSquadProvider.notifier).getGoalKeepers().length, (index){
                                    var goalKeeper = ref.read(teamSquadProvider.notifier).getGoalKeepers()[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 8,bottom: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(builder: (context) => Players(playerId: goalKeeper.personId,)));
                                                  },
                                                  child: Container(
                                                    width: 45,
                                                    height: 45,
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100)),
                                                        border: Border.all(width: 1, color: Colors.grey)),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.all(
                                                        Radius.circular(100),),
                                                      child: CircleAvatar()
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Container(
                                                    child: Center(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          Text(goalKeeper.name,
                                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                                            overflow:
                                                            TextOverflow.visible,
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                            children: [
                                                              CircleAvatar(
                                                                maxRadius: 8,
                                                                child: CircleAvatar()
                                                              ),
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                              Text(goalKeeper.nationality,
                                                                  style: Theme.of(context).textTheme.bodySmall
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          );
                                        }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8,bottom: 6,left: 16,right: 16),
                        child: Row(
                          children: <Widget>[
                            Text(
                                "مدافعين".tr,
                                style: Theme.of(context).textTheme.titleMedium
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16,top: 12,bottom: 16),
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: List.generate(ref.read(teamSquadProvider.notifier).getDefenders().length, (index){
                                    var defender = ref.read(teamSquadProvider.notifier).getDefenders()[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8,bottom: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context) => Players(playerId: defender.personId,)));
                                            },
                                            child: Container(
                                              width: 45,
                                              height: 45,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100)),
                                                  border: Border.all(width: 1, color: Colors.grey)),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(100),),
                                                child: CircleAvatar(),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                              child: Center(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: <Widget>[
                                                    Text(defender.name,
                                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                                      overflow:
                                                      TextOverflow.visible,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        CircleAvatar(
                                                          maxRadius: 8,
                                                          child: CircleAvatar()
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(defender.nationality,
                                                            style: Theme.of(context).textTheme.bodySmall
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ))
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4, top: 4),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8,bottom: 6,left: 16,right: 16),
                        child: Row(
                          children: <Widget>[
                            Text(
                                "وسط".tr,
                                style: Theme.of(context).textTheme.titleMedium
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(top: 12,bottom: 16,left: 16,right: 16),
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: List.generate(ref.read(teamSquadProvider.notifier).getMidfielders().length, (index){
                                    var midfielder = ref.read(teamSquadProvider.notifier).getMidfielders()[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8,bottom: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context) => Players(playerId: midfielder.personId,)));
                                            },
                                            child: Container(
                                              width: 45,
                                              height: 45,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100)),
                                                  border: Border.all(width: 1, color: Colors.grey)),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(100),),
                                                child: CircleAvatar(),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                              child: Center(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: <Widget>[
                                                    Text(midfielder.name,
                                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                                      overflow:
                                                      TextOverflow.visible,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        CircleAvatar(
                                                          maxRadius: 8,
                                                          child: CircleAvatar()
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(midfielder.nationality,
                                                            style: Theme.of(context).textTheme.bodySmall
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ))
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4,bottom: 4),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8,bottom: 6,left: 16,right: 16),
                        child: Row(
                          children: <Widget>[
                            Text(
                                "هجوم".tr,
                                style: Theme.of(context).textTheme.titleMedium
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(top: 12,bottom: 16,right: 16,left: 16),
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: List.generate(ref.read(teamSquadProvider.notifier).getAttackers().length, (index){
                                    var attacker = ref.read(teamSquadProvider.notifier).getAttackers()[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8,bottom: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context) => Players(playerId: attacker.personId,)));
                                            },
                                            child: Container(
                                              width: 45,
                                              height: 45,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100)),
                                                  border: Border.all(width: 1, color: Colors.grey)),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(100),),
                                                child: CircleAvatar(),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                              child: Center(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(attacker.name,
                                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                                      overflow:
                                                      TextOverflow.visible,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        CircleAvatar(
                                                          maxRadius: 8,
                                                          child: CircleAvatar()
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(attacker.nationality,
                                                            style: Theme.of(context).textTheme.bodySmall
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ))
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onFailure: (state)=> Text("Shit"));


  }
}
