import 'dart:math';


import 'package:epl/Data/StateModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../domain/Models/Formation.dart';
import '../provider/fixtureViewModel.dart';




class LineUps extends ConsumerStatefulWidget {
  String? url;
  String? matchID;

  LineUps({this.url, this.matchID});

  @override
  _LineUpsState createState() => _LineUpsState();
}

class _LineUpsState extends ConsumerState<LineUps> {
  int no = 1;


  RegExp? regExp;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      regExp = RegExp(r'^(\w+\s\w+)');
      if (mounted) {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lineUps = ref.watch(matchLineupsProvider);
    return lineUps.handelState(
        onLoading: (state) => Center(
          child: CircularProgressIndicator(),
        ),
        onSuccess: (state) => ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 38,
                  color: Color.fromRGBO(26, 158, 109, 1.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        children: <Widget>[
                          Text(lineUps.data!.formations.first.team.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white)),
                          SizedBox(
                            width: 15,
                          ),
                          Text(lineUps.data!.formations.first.formation,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 15, color: Colors.white70)),
                        ],
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    CustomPaint(
                      painter: ShapesPointer(),
                      child: Center(
                        child: Container(
                          height: 920,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 460,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                      GoalKeeper(lineUps.data!, "", 'home').length, (index) => GoalKeeper(
                                          lineUps.data!, "", 'home')[index])),
                              SingleChildScrollView(
                                child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: List.generate(
                                        Defender("", lineUps.data!, 'home').length, (index) => Flexible(
                                          child: Defender("", lineUps.data!, 'home')[index],
                                        ))),
                              ),
                              SingleChildScrollView(
                                child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: List.generate(
                                        CenterPlayer("", lineUps.data!, 'home')
                                            .length,
                                            (index) => Flexible(
                                            child: CenterPlayer("", lineUps.data!,
                                                'home')[index]))),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                      Attack("", lineUps.data!, 'home').length,
                                          (index) => Attack(
                                          "", lineUps.data!, 'home')[index])),
                              lineUps
                                  .data!.formations.first.formation
                                  .split('-')
                                  .length ==
                                  3
                                  ? Container()
                                  : Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: List.generate(
                                      AttackStricker("", lineUps.data!, 'home')
                                          .length,
                                          (index) => AttackStricker(
                                          "", lineUps.data!, 'home')[index])),
                            ],
                          )
                        /*
                          Stack(
                            children: [
                              Positioned(
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.4,
                                  top: 360,
                                  child: PlayerHome(0)),
                              Positioned(
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.01,
                                  bottom: 90,
                                  child: PlayerHome(1)),
                              Positioned(
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.26,
                                  bottom: 90,
                                  child: PlayerHome(2)),
                              Positioned(
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.53,
                                  bottom: 90,
                                  child: PlayerHome(3)),
                              Positioned(
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.76,
                                  bottom: 90,
                                  child: PlayerHome(4)),
                              Positioned(
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.25,
                                  bottom: 190,
                                  child: PlayerHome(5)),
                              Positioned(
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.55,
                                  bottom: 190,
                                  child: PlayerHome(6)),
                              Positioned(
                                right: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.05,
                                bottom: 280,
                                child: PlayerHome(7),
                              ),
                              Positioned(
                                right: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.4,
                                bottom: 280,
                                child: PlayerHome(8),
                              ),
                              Positioned(
                                right: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.75,
                                bottom: 280,
                                child: PlayerHome(9),
                              ),
                              Positioned(
                                right: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.4,
                                bottom: 365,
                                child: PlayerHome(10),
                              ),
                            ],
                          ),

                               */
                      ),
                    ),
                    Positioned(
                      top: 460,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 460,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                      Attack("", lineUps.data!, 'away').length, (index) => Attack(
                                      "", lineUps.data!, 'away')[index])),
                              lineUps.data!.formations.last.formation
                                  .split('-')
                                  .length ==
                                  3
                                  ? Container()
                                  : Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                      AttackStricker("", lineUps.data!, 'away')
                                          .length,
                                          (index) => AttackStricker(
                                          "", lineUps.data!, 'away')[index])),
                              SingleChildScrollView(
                                child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: List.generate(
                                        CenterPlayer("", lineUps.data!, 'away').length, (index) => Flexible(
                                            child: CenterPlayer("", lineUps.data!,
                                                'away')[index]))),
                              ),
                              SingleChildScrollView(
                                child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: List.generate(
                                        Defender("", lineUps.data!, 'away').length, (index) => Flexible(
                                          child: Defender("", lineUps.data!, 'away')[index],
                                        ))),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                      GoalKeeper(lineUps.data!, "", 'away').length, (index) => GoalKeeper(
                                          lineUps.data!, "", 'away')[index])),
                            ],
                          )
                        /*
                          Stack(
                            children: [
                              Positioned(
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.4,
                                  top: 360,
                                  child: PlayerHome(0)),
                              Positioned(
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.01,
                                  bottom: 90,
                                  child: PlayerHome(1)),
                              Positioned(
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.26,
                                  bottom: 90,
                                  child: PlayerHome(2)),
                              Positioned(
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.53,
                                  bottom: 90,
                                  child: PlayerHome(3)),
                              Positioned(
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.76,
                                  bottom: 90,
                                  child: PlayerHome(4)),
                              Positioned(
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.25,
                                  bottom: 190,
                                  child: PlayerHome(5)),
                              Positioned(
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.55,
                                  bottom: 190,
                                  child: PlayerHome(6)),
                              Positioned(
                                right: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.05,
                                bottom: 280,
                                child: PlayerHome(7),
                              ),
                              Positioned(
                                right: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.4,
                                bottom: 280,
                                child: PlayerHome(8),
                              ),
                              Positioned(
                                right: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.75,
                                bottom: 280,
                                child: PlayerHome(9),
                              ),
                              Positioned(
                                right: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.4,
                                bottom: 365,
                                child: PlayerHome(10),
                              ),
                            ],
                          ),

                               */
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 38,
                  color: Color.fromRGBO(26, 158, 109, 1.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: <Widget>[
                          Text(lineUps.data!.formations.last.team.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white)),
                          SizedBox(
                            width: 15,
                          ),
                          Text(lineUps.data!.formations.last.formation,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 15, color: Colors.white70))
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      Text("مدرب", style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                      border: Border.all(width: 1, color: Colors.grey)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                    child: CircleAvatar(backgroundColor: Colors.grey,),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    child: Center(
                                      child: Text(lineUps.data!.formations.first.coach.name??"Coach name",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 13),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                      border:
                                      Border.all(width: 1, color: Colors.grey)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                    child: CircleAvatar(backgroundColor: Colors.grey,),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    child: Center(
                                      child: Text(lineUps.data!.formations.last.coach.name??"Coach name",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 13),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      Text("مقاعد الاحتياط ",
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: List.generate(lineUps.data!.bench.first.length, (index){
                              var bench = lineUps.data!.bench.first[index];
                              return InkWell(
                                onTap: () => {},
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 110,
                                    width: 130,
                                    child: Stack(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Stack(
                                              children: List.of(playerInfield(bench.event,true))
                                          ),
                                        ),
                                        Positioned(
                                          top: 65,
                                          left: 0,
                                          right: 5,
                                          child: Container(
                                              height: 60,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    child: Container(
                                                      height: 60,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          FittedBox(
                                                            child: Text("${bench.shirtnumber} ",
                                                              style: TextStyle(
                                                                  fontFamily: 'Vazirmatn',
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 60,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Flexible(
                                                          child: Text(bench.person,
                                                            style: TextStyle(
                                                                fontFamily: 'Vazirmatn',
                                                                color: Colors.black,
                                                                fontSize: 13,
                                                                height: 1.1),
                                                            overflow: TextOverflow.clip,textAlign: TextAlign.center,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          ),
                          ),

                          Column(
                            children: List.generate(lineUps.data!.bench.last.length, (index){
                              var bench = lineUps.data!.bench.last[index];
                              return InkWell(
                                onTap: () => {},
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 110,
                                    width: 130,
                                    child: Stack(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Stack(
                                              children: List.of(playerInfield(bench.event,true))
                                          ),
                                        ),
                                        Positioned(
                                          top: 65,
                                          left: 0,
                                          right: 5,
                                          child: Container(
                                              height: 60,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    child: Container(
                                                      height: 60,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          FittedBox(
                                                            child: Text("${bench.shirtnumber} ",
                                                              style: TextStyle(
                                                                  fontFamily: 'Vazirmatn',
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 60,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Flexible(
                                                          child: Text(bench.person,
                                                            style: TextStyle(
                                                                fontFamily: 'Vazirmatn',
                                                                color: Colors.black,
                                                                fontSize: 13,
                                                                height: 1.1),
                                                            overflow: TextOverflow.clip,textAlign: TextAlign.center,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 260,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, right: 15, bottom: 30),
                    child: Row(
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(_icons.length, (index) {
                              return _collectionOfIcons(
                                  _icons[index], _textIcons[index]);
                            })),
                        SizedBox(
                          width: 80,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 22,
                                  width: 15,
                                  decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "بطاقة صفراء",
                                  style: TextStyle(
                                      fontFamily: 'Vazirmatn', fontSize: 13),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 22,
                                  width: 15,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "بطاقة حمراء",
                                  style: TextStyle(
                                      fontFamily: 'Vazirmatn', fontSize: 13),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  height: 25,
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        height: 22,
                                        width: 15,
                                        decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                      ),
                                      Positioned(
                                        top: 3,
                                        right: 3,
                                        child: Container(
                                          height: 22,
                                          width: 15,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "الاصفر الثاني",
                                  style: TextStyle(
                                      fontFamily: 'Vazirmatn', fontSize: 13),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.local_hospital,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "مصاب",
                                  style: TextStyle(
                                      fontFamily: 'Vazirmatn', fontSize: 13),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.public,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "الواجب الدولي ",
                                  style: TextStyle(
                                      fontFamily: 'Vazirmatn', fontSize: 13),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        onFailure: (state) => SizedBox());

  }

  List<Icon> _icons = [
    Icon(MdiIcons.handball),
    Icon(MdiIcons.footPrint,),
    Icon(MdiIcons.soccer, color: Colors.black,),
    Icon(MdiIcons.soccer, color: Colors.red,),
    Icon(MdiIcons.soccer),
  ];
  List<String> _textIcons = [
    'ضربات جزاء مبعدة',
    "صناعة اهداف",
    "هدف",
    "هدف في مرماة",
    "ضربة جزاء ضائعة"
  ];

  Widget _collectionOfIcons(_icons, _textIcons) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _icons,
            SizedBox(
              width: 10,
            ),
            Text(
              _textIcons,
              style: TextStyle(fontFamily: 'Vazirmatn', fontSize: 13),
            )
          ],
        ),
      ],
    );
  }
}

Widget PlayerHome(homeLineUp,index) {
  return Container(
    height: homeLineUp.formation.split('-').length == 3 ? 110 : 90,
    width: 85,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),

    child: Stack(
      children: <Widget>[
        Stack(
            children: List.of(playerInfield(homeLineUp.startXI[index].player.events,false))
        ),
        Positioned(
          top: 62,
          left: 0,
          right: 5,
          child: Container(
              height: 40,
              width: 115,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Container(
                      height: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Text("${homeLineUp.startXI[index].player.number} ",
                              style: TextStyle(
                                  fontFamily: 'Vazirmatn',
                                  color: Colors.white60,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(homeLineUp.startXI[index].player.name.split(" ").last,
                            style: TextStyle(
                                fontFamily: 'Vazirmatn',
                                color: Colors.white,
                                fontSize: 13,
                                height: 1.1),
                            overflow: TextOverflow.visible,textAlign: TextAlign.center,),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        )
      ],
    ),
  );
}

Widget PlayerAway(awayLineUp,index) {
  return InkWell(
    onTap: () => {},
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      height: awayLineUp.formation.split('-').length == 3 ? 110 : 90,
      width: 85,
      child: Stack(
        children: <Widget>[
          Stack(
              children: List.of(playerInfield(awayLineUp.startXI[index].player.events,false))
          ),
          Positioned(
            top: 62,
            left: 0,
            right: 5,
            child: Container(
                height: 40,
                width: 115,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Container(
                        height: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: Text("${awayLineUp.startXI[index].player.number} ",
                                style: TextStyle(
                                    fontFamily: 'Vazirmatn',
                                    color: Colors.white60,
                                    fontSize: 12,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(awayLineUp.startXI[index].player.name.toString().split(" ").last,
                                style: TextStyle(
                                    fontFamily: 'Vazirmatn',
                                    color: Colors.white,
                                    fontSize: 12.5,
                                    height: 1.1),
                                overflow: TextOverflow.visible),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    ),
  );
}



List<Widget> GoalKeeper(FormationsModel lineUps, String matchId, type) {
  List<Widget> goalKeeper = [];
  var homeLineUp = lineUps.formations.first;
  var awayLineUp = lineUps.formations.last;

  type == 'away'
      ? goalKeeper.add(PlayerAway(awayLineUp,0))
      : goalKeeper.add(PlayerHome(homeLineUp,0));
  return goalKeeper;
}

List<Widget> Defender(String matchId, FormationsModel lineUps, type) {
  List<Widget> defenders = [];
  var homeLineUp = lineUps.formations.first;
  var awayLineUp = lineUps.formations.last;

  if (type == "away") {
    int no = int.parse(awayLineUp.formation.split('-').first);
    for (int i = 1; i <= no; i++) {
      defenders.add(PlayerAway(awayLineUp,i));
    }
  } else {
    int no = int.parse(homeLineUp.formation.split('-').first);
    for (int i = 1; i <= no; i++) {
      defenders.add(PlayerHome(homeLineUp,i));
    }
  }

  return defenders;
}

List<Widget> CenterPlayer(String matchId, FormationsModel lineUps, type) {
  List<Widget> centerPlayers = [];
  var homeLineUp = lineUps.formations.first;
  var awayLineUp = lineUps.formations.last;

  if (type == 'away') {
    int start = int.parse(awayLineUp.formation.split('-').first);
    int no = int.parse(awayLineUp.formation.split('-')[1]);
    for (int i = start + 1; i <= no + start; i++) {
      centerPlayers.add(PlayerAway(awayLineUp,i));
    }
  } else {
    int start = int.parse(homeLineUp.formation.split('-').first);
    int no = int.parse(homeLineUp.formation.split('-')[1]);
    for (int i = start + 1; i <= no + start; i++) {
      centerPlayers.add(PlayerHome(homeLineUp,i));
    }
  }
  return centerPlayers;
}

List<Widget> Attack(String matchId, FormationsModel lineUps, type) {
  List<Widget> attackers = [];
  var homeLineUp = lineUps.formations.first;
  var awayLineUp = lineUps.formations.last;

  if (type == 'away') {
    int start = int.parse(awayLineUp.formation.split('-').first);
    int middle = int.parse(awayLineUp.formation.split('-')[1]);
    int no = int.parse(awayLineUp.formation.split('-')[2]);
    for (int i = start + middle + 1; i <= no + middle + start; i++) {
      attackers.add(PlayerAway(awayLineUp,i));
    }
  } else {
    int start = int.parse(homeLineUp.formation.split('-').first);
    int middle = int.parse(homeLineUp.formation.split('-')[1]);
    int no = int.parse(homeLineUp.formation.split('-')[2]);
    for (int i = start + middle + 1; i <= no + middle + start; i++) {
      attackers.add(PlayerHome(homeLineUp,i));
    }
  }

  return attackers;
}

List<Widget> AttackStricker(String matchId, FormationsModel lineUps, type) {
  List<Widget> test = [];
  var homeLineUp = lineUps.formations.first;
  var awayLineUp = lineUps.formations.last;

  if (type == 'away') {
    int start = int.parse(awayLineUp.formation.split('-').first);
    int middle = int.parse(awayLineUp.formation.split('-')[1]);
    int middle2 = int.parse(awayLineUp.formation.split('-')[2]);
    int no = int.parse(awayLineUp.formation.split('-')[3]);
    for (int i = start + middle + middle2 + 1; i <= no + middle + middle2 + start; i++) {
      test.add(PlayerAway(awayLineUp,i));
    }
  } else {
    int start = int.parse(homeLineUp.formation.split('-').first);
    int middle = int.parse(homeLineUp.formation.split('-')[1]);
    int middle2 = int.parse(homeLineUp.formation.split('-')[2]);
    int no = int.parse(homeLineUp.formation.split('-')[3]);
    for (int i = start + middle + middle2 + 1;
        i <= no + middle + middle2 + start;
        i++) {
      test.add(PlayerHome(homeLineUp,i));
    }
  }

  return test;
}



Widget playerAvatar(bool bench){
  return  Container(
    width: 95,
    height: 95,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
    child: Padding(
      padding: const EdgeInsets.only(
          left: 12, right: 12, top: 25, bottom: 25),
      child: Container(
        child: CircleAvatar(
          backgroundColor: bench? Colors.grey :Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
            //child: Image.network("https://www.eplworld.com"),
          ),
        ),
      ),
    ),
  );
}

Widget substitution(){
  return Positioned(
      top: 0,
      left: 14,
      child: Container(
        width: 20,
        child:  Column(
              children: [
                Text("5",
                  style: TextStyle(
                      fontFamily: 'Vazirmatn',
                      color: Colors.white),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4)),
                  child: Center(
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 16,
                      )),
                ),
              ],

      )
      )
  );
}

Widget rating(){
  return  Positioned(
      top: 20,
      right: 2,
      child: Container(
        width: 33,
        height: 23,
        child: Column(
          children: [
            Container(
              width: 30,
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                  child: Text('rating',
                      style: TextStyle(
                          fontFamily: 'Vazirmatn',
                          color: Colors.white,
                          fontSize: 12))),
            ),
          ],
        ),
      ));
}

Widget goal(int goals){
  return Positioned(
      bottom: 20,
      left: -5,
      child: Container(
        width: 40,
        height: 25,
        child:  Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(goals, (index) => Container(
                    width: 10,
                    child: Icon(
                      MdiIcons.soccer,
                      size: 20,
                      color: Colors.black,
                    )),)
              )
      ));

}

Widget yellowCard(int cards){
  return Positioned(
      bottom: 17,
      right: 12,
      child: Container(
        child: SizedBox(width: 25,height: 30,
          child: Stack(
                  children: List.generate(cards, (index) => Positioned(
                    right: index*8+2,
                    top: index*4+2,
                    child: Container(
                      width: 13,
                      height: 18,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius:
                          BorderRadius.circular(2)),
                    ),
                  ),)
            ),
        ),
      ));
}

Widget redCard(){
  return Positioned(
      bottom: 17,
      right: 15,
      child: Container(
        width: 16,
        height: 23,
        child: Column(
          children: [
            Container(
              width: 13,
              height: 18,
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius:
                  BorderRadius.circular(2)),
            ),
          ],
        ),
      ));
}


List<Widget> playerInfield(List<Event> eventsModel, bool bench){
  List<Widget> events = [];
  int goals = 0;
  int yellowCards = 0;

  events.add(playerAvatar(bench));

  for(var event in eventsModel){
    if(event.type == "subst"){
      events.add(substitution());
    }

    if(event.type == "G"){
      goals++;
      events.add(goal(goals));
    }

    if(event.type == "YC"){
      yellowCards++;
      events.add(yellowCard(yellowCards));
    }

    if(event.type == "RC"){
      events.add(redCard());
    }

  }


  return events;
}




class ShapesPointer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = Color.fromRGBO(0, 147, 92, 1.0);
    var rect = Rect.fromLTWH(0, 0, size.width, 950);
    canvas.drawRect(rect, paint);

    paint.color = Color.fromRGBO(26, 158, 109, 1.0);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    var rectbig = Rect.fromLTWH(size.width / 4.5, 0, 225, 100);
    canvas.drawRect(rectbig, paint);

    paint.color = Color.fromRGBO(26, 158, 109, 1.0);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    var rectsmall = Rect.fromLTWH(size.width / 2.77, 0, 112, 50);
    canvas.drawRect(rectsmall, paint);

    paint.color = Color.fromRGBO(26, 158, 109, 1.0);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    var rectbig1 = Rect.fromLTWH(size.width / 4.5, 820, 225, 100);
    canvas.drawRect(rectbig1, paint);

    paint.color = Color.fromRGBO(26, 158, 109, 1.0);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    var rectsmall1 = Rect.fromLTWH(size.width / 2.77, 870, 112, 50);
    canvas.drawRect(rectsmall1, paint);

    final rect3 = Rect.fromLTRB(150, 50, 260, 125);
    final startAngle = pi / 9;
    final sweepAngle = pi / 1.3;
    final useCenter = false;
    paint.color = Color.fromRGBO(26, 158, 109, 1.0);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    canvas.drawArc(rect3, startAngle, sweepAngle, useCenter, paint);

    final rect4 = Rect.fromLTRB(150, 795, 260, 870);
    final startAngle2 = -pi / 9;
    final sweepAngle2 = -pi / 1.3;
    final useCenter2 = false;
    paint.color = Color.fromRGBO(26, 158, 109, 1.0);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    canvas.drawArc(rect4, startAngle2, sweepAngle2, useCenter2, paint);

    paint.color = Color.fromRGBO(26, 158, 109, 1.0);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    var center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, 60.0, paint);

    paint.color = Color.fromRGBO(26, 158, 109, 1.0);
    var line1 = Offset(size.width, size.height / 2);
    var line2 = Offset(0, size.height / 2);
    canvas.drawLine(line1, line2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
