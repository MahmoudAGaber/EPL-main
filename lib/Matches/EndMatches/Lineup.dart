import 'dart:math';

import 'package:arseli/Matches/EndMatches/PlayerInfo.dart';
import 'package:arseli/Provider/EachMatchViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'matchInfo_a.dart';

class Lineup extends StatefulWidget {
  String url;
  String matchID;

  Lineup({this.url, this.matchID});

  @override
  _LineupState createState() => _LineupState();
}

class _LineupState extends State<Lineup> {
  int no = 1;
  TextStyle _textStyle =
      TextStyle(fontFamily: 'Vazirmatn', color: Colors.grey[500], fontSize: 13);
  TextStyle _textStyle1 = TextStyle(fontFamily: 'Vazirmatn', fontSize: 17);
  TextStyle _textStyle2 =
      TextStyle(fontFamily: 'Vazirmatn', color: Colors.grey[500], fontSize: 15);
  TextStyle _textStyle3 = TextStyle(
      fontFamily: 'Vazirmatn',
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 20);
  TextStyle _textStyle4 = TextStyle(
      fontFamily: 'Vazirmatn',
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 15);
  TextStyle content = TextStyle(fontFamily: 'Vazirmatn', fontSize: 13.5);
  TextStyle content2 =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 13.5, color: Colors.grey);
  TextStyle content3 = TextStyle(fontFamily: 'Vazirmatn', fontSize: 12);
  TextStyle content4 =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 12, color: Colors.grey);
  TextStyle number = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 18, fontWeight: FontWeight.w400);

  EachMatchViewModel eachMatchViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        eachMatchViewModel = Provider.of(context, listen: false);
        eachMatchViewModel.getMatchLineups(widget.url);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EachMatchViewModel>(
      builder: (context, provider, child) {
        return provider.lineupsModel == null
            ? Container()
            : ListView(
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
                                Text(
                                  provider.lineupsModel.home.teamName,
                                    style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.white)
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(provider.lineupsModel.home.formation,
                                    style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 15,color: Colors.white70)
                                ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                            GoalKeeper(provider,widget.matchID, 'home').length,
                                            (index) => GoalKeeper(provider,widget.matchID, 'home')[index])),
                                    SingleChildScrollView(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: List.generate(
                                              Defender(widget.matchID, provider, 'home').length,
                                              (index) => Flexible(
                                                    child: Defender(
                                                        widget.matchID, provider, 'home')[index],
                                                  ))),
                                    ),
                                    SingleChildScrollView(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: List.generate(
                                              CenterPlayer(widget.matchID, provider, 'home').length,
                                              (index) => Flexible(
                                                  child: CenterPlayer(widget.matchID, provider, 'home')[index]))),
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: List.generate(
                                            Attack(widget.matchID, provider, 'home').length,
                                            (index) => Attack(widget.matchID, provider, 'home')[index])),
                                    provider.lineupsModel.home.formation.split('-').length == 3
                                        ? Container()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: List.generate(
                                                AttackStricker(widget.matchID, provider, 'home').length,
                                                (index) => AttackStricker(widget.matchID, provider, 'home')[index])),
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
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: List.generate(
                                            Attack(widget.matchID, provider, 'away').length,
                                                (index) => Attack(widget.matchID,
                                                provider, 'away')[index])),
                                    provider.lineupsModel.away.formation.split('-').length == 3
                                        ? Container()
                                        : Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: List.generate(
                                            AttackStricker(widget.matchID, provider, 'away').length,
                                                (index) => AttackStricker(widget.matchID, provider, 'away')[index])),
                                    SingleChildScrollView(
                                      child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: List.generate(
                                              CenterPlayer(widget.matchID, provider, 'away').length, (index) => Flexible(
                                                  child: CenterPlayer(widget.matchID, provider, 'away')[index]))),
                                    ),
                                    SingleChildScrollView(
                                      child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: List.generate(
                                              Defender(widget.matchID, provider, 'away').length, (index) => Flexible(
                                                child: Defender(widget.matchID, provider, 'away')[index],
                                              ))),
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: List.generate(
                                            GoalKeeper(provider,widget.matchID, 'away').length,
                                                (index) => GoalKeeper(provider,widget.matchID, 'away')[index])),



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
                                Text(
                                  provider.lineupsModel.away.teamName,
                                  style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.white)
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(provider.lineupsModel.away.formation,
                                  style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 15,color: Colors.white70))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "مدرب",
                              style: Theme.of(context).textTheme.headline2
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100)),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey)),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(100),
                                            ),
                                            child: Image.network(
                                                "https://www.eplworld.com${provider.lineupsModel.home.players.coach.img}"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            child: Center(
                                          child: Text(
                                            provider.lineupsModel.home.players.coach.name,
                                            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                                            overflow: TextOverflow.visible,
                                          ),
                                        ))
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                        child: Image.network(
                                            "https://www.eplworld.com${provider.lineupsModel.away.players.coach.img}"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        child: Center(
                                      child: Text(
                                        provider.lineupsModel.away.players.coach
                                            .name,
                                        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "مقاعد الاحتياط ",
                              style: Theme.of(context).textTheme.headline2
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 25,
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      ListView.builder(
                                          physics: ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: provider.lineupsModel.home.players.outField.length,
                                          itemBuilder: (BuildContext context, index) {
                                            return InkWell(
                                              onTap: () => {
                                                eachMatchViewModel.getPlayerInfo(widget.matchID, provider.lineupsModel.home.players.outField[index].id)
                                                    .then((value) => {
                                                          if (value != null)
                                                            showPlayerInfo(context, value,provider.msnModel.homeTeamLogo)
                                                        })
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Container(
                                                  height: 115,
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Positioned(
                                                        top: 20,
                                                        right: 30,
                                                        child: Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(50)),
                                                          ),
                                                          child: ClipRRect(borderRadius: BorderRadius.all(
                                                            Radius.circular(50),
                                                              ),
                                                              child: Image.network(
                                                            "https://www.eplworld.com${provider.lineupsModel.home.players.outField[index].img}",height: 20,width: 20,),
                                                            ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                          top: 0,
                                                          left: 10,
                                                          child:
                                                          Container(
                                                            width: 40,
                                                            height: 50,
                                                            child: ListView.builder(
                                                              physics: NeverScrollableScrollPhysics(),
                                                              itemCount: provider.lineupsModel.home.players.outField[index].events == null
                                                                  ? 0
                                                                  : provider.lineupsModel.home.players.outField[index].events.length,
                                                              itemBuilder: (context, indexx) {
                                                                return provider.lineupsModel.home.players.outField[index].events[indexx].type ==
                                                                    'substitute'
                                                                    ? Column(
                                                                  children: [
                                                                    Text(
                                                                      provider.lineupsModel.home.players.outField[index].events[indexx].time.toString(),
                                                                      style: TextStyle(fontFamily: 'Vazirmatn', color: Colors.green),
                                                                    ),
                                                                    Container(
                                                                      height: 20,
                                                                      decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(6)),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.only(left: 4, right: 4),
                                                                        child: Icon(
                                                                          Icons.arrow_right_alt_outlined,
                                                                          color: Colors.white,
                                                                          size: 20,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                                    : Container();
                                                              },
                                                            ),
                                                          )),
                                                      provider.lineupsModel.home.players.outField[index].rating != null
                                                          ? Positioned(
                                                          top: 15,
                                                          left: 20,
                                                          child:
                                                          Container(
                                                            width: 33,
                                                            height:
                                                            23,
                                                            child:
                                                            Column(
                                                              children: [
                                                                Container(
                                                                  width:
                                                                  33,
                                                                  height:
                                                                  23,
                                                                  decoration:
                                                                  BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)),
                                                                  child:
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(left: 3, right: 3),
                                                                    child: Center(child: Text(provider.lineupsModel.home.players.outField[index].rating, style: TextStyle(fontFamily: 'Vazirmatn', color: Colors.white))),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ))
                                                          : Container(
                                                        width: 33,
                                                        height: 23,
                                                      ),
                                                      Positioned(
                                                          bottom: 35,
                                                          right:15,
                                                          child:
                                                          Container(
                                                            width: 60,
                                                            height: 25,
                                                            child: ListView.builder(
                                                              scrollDirection: Axis.horizontal,
                                                                physics: NeverScrollableScrollPhysics(),
                                                                itemCount: provider.lineupsModel.home.players.outField[index].events == null
                                                                    ? 0
                                                                    : provider.lineupsModel.home.players.outField[index].events.length,
                                                                itemBuilder: (context, indexx) {
                                                                  return provider.lineupsModel.home.players.outField[index].events[indexx].type == 'goal'
                                                                      ? Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    children: [
                                                                      Container(
                                                                          width: 10,
                                                                          child: Icon(
                                                                            MdiIcons.soccer,
                                                                            size: 20,
                                                                            color: Colors.white,
                                                                          )),
                                                                    ],
                                                                  )
                                                                      : Container();
                                                                }),
                                                          )),
                                                      Positioned(
                                                          bottom: 35,
                                                          left: 25,
                                                          child:
                                                          Container(
                                                            width: 16,
                                                            height: 23,
                                                            child: ListView
                                                                .builder(
                                                                physics:
                                                                NeverScrollableScrollPhysics(),
                                                                itemCount: provider.lineupsModel.home.players.outField[index].events == null
                                                                    ? 0
                                                                    : provider.lineupsModel.home.players.outField[index].events.length,
                                                                itemBuilder: (context, indexx) {
                                                                  return provider.lineupsModel.home.players.outField[index].events[indexx].type != 'yellowCard'
                                                                      ? Column(
                                                                    children: [
                                                                      Container(
                                                                        width: 16,
                                                                        height: 23,
                                                                        decoration: BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.circular(4)),
                                                                      ),
                                                                    ],
                                                                  )
                                                                      : Container();
                                                                }),
                                                          )),
                                                      Positioned(
                                                        bottom: 0,
                                                        right: 0,
                                                        child: Container(
                                                            width: 110,
                                                            child: Center(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  Center(
                                                                    child: Text(
                                                                      provider
                                                                          .lineupsModel
                                                                          .home
                                                                          .players
                                                                          .outField[
                                                                              index]
                                                                          .number
                                                                          .toString(),
                                                                      style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                                                                    ),
                                                                  ),
                                                                  FittedBox(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Center(
                                                                          child:
                                                                              Text(
                                                                            provider.lineupsModel.home.players.outField[index].name,
                                                                                style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                                                                            overflow:
                                                                                TextOverflow.clip,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 70,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      ListView.builder(
                                          physics: ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: provider.lineupsModel.away
                                              .players.outField.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return InkWell(
                                              onTap: () => {
                                                eachMatchViewModel.getPlayerInfo(widget.matchID, provider.lineupsModel.away.players.outField[index].id)
                                                    .then((value) => {
                                                          if (value != null)
                                                            showPlayerInfo(context, value,provider.msnModel.awayTeamLogo)
                                                        })
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Container(
                                                  height: 115,
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Positioned(
                                                        top: 20,
                                                        right: 30,
                                                        child: Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(50)),
                                                          ),
                                                          child: ClipRRect(borderRadius: BorderRadius.all(
                                                            Radius.circular(50),
                                                          ),
                                                            child: Image.network(
                                                              "https://www.eplworld.com${provider.lineupsModel.away.players.outField[index].img}",height: 20,width: 20,),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                          top: 0,
                                                          left: 10,
                                                          child:
                                                          Container(
                                                            width: 40,
                                                            height: 50,
                                                            child: ListView.builder(
                                                              physics: NeverScrollableScrollPhysics(),
                                                              itemCount: provider.lineupsModel.away.players.outField[index].events == null
                                                                  ? 0
                                                                  : provider.lineupsModel.away.players.outField[index].events.length,
                                                              itemBuilder: (context, indexx) {
                                                                return provider.lineupsModel.away.players.outField[index].events[indexx].type ==
                                                                    'substitute'
                                                                    ? Column(
                                                                  children: [
                                                                    Text(
                                                                      provider.lineupsModel.away.players.outField[index].events[indexx].time.toString(),
                                                                      style: TextStyle(fontFamily: 'Vazirmatn', color: Colors.green),
                                                                    ),
                                                                    Container(
                                                                      height: 20,
                                                                      decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(6)),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.only(left: 4, right: 4),
                                                                        child: Icon(
                                                                          Icons.arrow_right_alt_outlined,
                                                                          color: Colors.white,
                                                                          size: 20,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                                    : Container();
                                                              },
                                                            ),
                                                          )),
                                                      provider.lineupsModel.away.players.outField[index].rating != null
                                                          ? Positioned(
                                                          top: 15,
                                                          left: 20,
                                                          child:
                                                          Container(
                                                            width: 33,
                                                            height:
                                                            23,
                                                            child:
                                                            Column(
                                                              children: [
                                                                Container(
                                                                  width:
                                                                  33,
                                                                  height:
                                                                  23,
                                                                  decoration:
                                                                  BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)),
                                                                  child:
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(left: 3, right: 3),
                                                                    child: Center(child: Text(provider.lineupsModel.away.players.outField[index].rating, style: TextStyle(fontFamily: 'Vazirmatn', color: Colors.white))),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ))
                                                          : Container(
                                                        width: 33,
                                                        height: 23,
                                                      ),
                                                      Positioned(
                                                          bottom: 35,
                                                          right:15,
                                                          child:
                                                          Container(
                                                            width: 60,
                                                            height: 25,
                                                            child: ListView.builder(
                                                                scrollDirection: Axis.horizontal,
                                                                physics: NeverScrollableScrollPhysics(),
                                                                itemCount: provider.lineupsModel.away.players.outField[index].events == null
                                                                    ? 0
                                                                    : provider.lineupsModel.away.players.outField[index].events.length,
                                                                itemBuilder: (context, indexx) {
                                                                  return provider.lineupsModel.away.players.outField[index].events[indexx].type == 'goal'
                                                                      ? Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    children: [
                                                                      Container(
                                                                          width: 10,
                                                                          child: Icon(
                                                                            MdiIcons.soccer,
                                                                            size: 20,
                                                                            color: Colors.white,
                                                                          )),
                                                                    ],
                                                                  )
                                                                      : Container();
                                                                }),
                                                          )),
                                                      Positioned(
                                                          bottom: 35,
                                                          left: 25,
                                                          child:
                                                          Container(
                                                            width: 16,
                                                            height: 23,
                                                            child: ListView
                                                                .builder(
                                                                physics:
                                                                NeverScrollableScrollPhysics(),
                                                                itemCount: provider.lineupsModel.away.players.outField[index].events == null
                                                                    ? 0
                                                                    : provider.lineupsModel.away.players.outField[index].events.length,
                                                                itemBuilder: (context, indexx) {
                                                                  return provider.lineupsModel.away.players.outField[index].events[indexx].type != 'yellowCard'
                                                                      ? Column(
                                                                    children: [
                                                                      Container(
                                                                        width: 16,
                                                                        height: 23,
                                                                        decoration: BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.circular(4)),
                                                                      ),
                                                                    ],
                                                                  )
                                                                      : Container();
                                                                }),
                                                          )),
                                                      Positioned(
                                                        bottom: 0,
                                                        right: 0,
                                                        child: Container(
                                                            width: 110,
                                                            child: Center(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                                children: <
                                                                    Widget>[
                                                                  Center(
                                                                    child: Text(
                                                                      provider
                                                                          .lineupsModel
                                                                          .away
                                                                          .players
                                                                          .outField[
                                                                      index]
                                                                          .number
                                                                          .toString(),
                                                                      style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                                                                    ),
                                                                  ),
                                                                  FittedBox(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                      children: [
                                                                        Center(
                                                                          child:
                                                                          Text(
                                                                            provider.lineupsModel.away.players.outField[index].name,
                                                                            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                                                                            overflow:
                                                                            TextOverflow.clip,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
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
                          padding: const EdgeInsets.only(
                              top: 20, right: 15, bottom: 30),
                          child: Row(
                            children: <Widget>[
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children:
                                      List.generate(_icons.length, (index) {
                                    return _collectionOfIcons(
                                        _icons[index], _textIcons[index]);
                                  })),
                              SizedBox(
                                width: 80,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: 22,
                                        width: 15,
                                        decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "بطاقة صفراء",
                                        style: TextStyle(
                                            fontFamily: 'Vazirmatn',
                                            fontSize: 13),
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "بطاقة حمراء",
                                        style: TextStyle(
                                            fontFamily: 'Vazirmatn',
                                            fontSize: 13),
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
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4))),
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
                                            fontFamily: 'Vazirmatn',
                                            fontSize: 13),
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
                                            fontFamily: 'Vazirmatn',
                                            fontSize: 13),
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
                                            fontFamily: 'Vazirmatn',
                                            fontSize: 13),
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
              );
      },
    );
  }

  List<Icon> _icons = [
    Icon(MdiIcons.hand),
    Icon(
      MdiIcons.footPrint,
    ),
    Icon(
      MdiIcons.soccer,
      color: Colors.black,
    ),
    Icon(
      MdiIcons.soccer,
      color: Colors.red,
    ),
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

List<Widget> GoalKeeper( EachMatchViewModel provider,String matchId, type) {
  List<Widget> test = [];
  type == 'away'
      ? test.add(PlayerAway(matchId, 0,provider.msnModel.awayTeamLogo))
      : test.add(PlayerHome(matchId, 0,provider.msnModel.homeTeamLogo));
  return test;
}

List<Widget> Defender(String matchId, EachMatchViewModel provider, type) {
  List<Widget> test = [];
  if (type == "away") {
    int no = int.parse(provider.lineupsModel.away.formation.split('-').first);
    for (int i = 1; i <= no; i++) {
      test.add(PlayerAway(matchId, i,provider.msnModel.awayTeamLogo));
    }
  } else {
    int no = int.parse(provider.lineupsModel.home.formation.split('-').first);
    for (int i = 1; i <= no; i++) {
      test.add(PlayerHome(matchId, i,provider.msnModel.homeTeamLogo));
    }
  }

  return test;
}

List<Widget> CenterPlayer(String matchId, EachMatchViewModel provider, type) {
  List<Widget> test = [];
  if (type == 'away') {
    int start =
        int.parse(provider.lineupsModel.away.formation.split('-').first);
    int no = int.parse(provider.lineupsModel.away.formation.split('-')[1]);
    for (int i = start + 1; i <= no + start; i++) {
      test.add(PlayerAway(matchId, i,provider.msnModel.awayTeamLogo));
    }
  } else {
    int start =
        int.parse(provider.lineupsModel.home.formation.split('-').first);
    int no = int.parse(provider.lineupsModel.home.formation.split('-')[1]);
    for (int i = start + 1; i <= no + start; i++) {
      test.add(PlayerHome(matchId, i,provider.msnModel.homeTeamLogo));
    }
  }
  return test;
}

List<Widget> Attack(String matchId, EachMatchViewModel provider, type) {
  List<Widget> test = [];
  if (type == 'away') {
    int start =
        int.parse(provider.lineupsModel.away.formation.split('-').first);
    int middle = int.parse(provider.lineupsModel.away.formation.split('-')[1]);
    int no = int.parse(provider.lineupsModel.away.formation.split('-')[2]);
    for (int i = start + middle + 1; i <= no + middle + start; i++) {
      test.add(PlayerAway(matchId, i,provider.msnModel.awayTeamLogo));
    }
  } else {
    int start =
        int.parse(provider.lineupsModel.home.formation.split('-').first);
    int middle = int.parse(provider.lineupsModel.home.formation.split('-')[1]);
    int no = int.parse(provider.lineupsModel.home.formation.split('-')[2]);
    for (int i = start + middle + 1; i <= no + middle + start; i++) {
      test.add(PlayerHome(matchId, i,provider.msnModel.homeTeamLogo));
    }
  }

  return test;
}

List<Widget> AttackStricker(String matchId, EachMatchViewModel provider, type) {
  List<Widget> test = [];
  if (type == 'away') {
    int start =
        int.parse(provider.lineupsModel.away.formation.split('-').first);
    int middle = int.parse(provider.lineupsModel.away.formation.split('-')[1]);
    int middle2 = int.parse(provider.lineupsModel.away.formation.split('-')[2]);
    int no = int.parse(provider.lineupsModel.away.formation.split('-')[3]);
    for (int i = start + middle + middle2 + 1;
        i <= no + middle + middle2 + start;
        i++) {
      test.add(PlayerAway(matchId, i,provider.msnModel.awayTeamLogo));
    }
  } else {
    int start =
        int.parse(provider.lineupsModel.home.formation.split('-').first);
    int middle = int.parse(provider.lineupsModel.home.formation.split('-')[1]);
    int middle2 = int.parse(provider.lineupsModel.home.formation.split('-')[2]);
    int no = int.parse(provider.lineupsModel.home.formation.split('-')[3]);
    for (int i = start + middle + middle2 + 1;
        i <= no + middle + middle2 + start;
        i++) {
      test.add(PlayerHome(matchId, i,provider.msnModel.homeTeamLogo));
    }
  }

  return test;
}

Widget PlayerHome(String matchId, index,teamImage) {
  return Consumer<EachMatchViewModel>(builder: (context, provider, child) {
    return InkWell(
      onTap: () => {
        provider.getPlayerInfo(matchId, provider.lineupsModel.home.players.inField[index].id).then((value){
           showPlayerInfo(context,value,teamImage);
        }),

            //.then((value) => {if (value != null) showPlayerInfo(context, value,teamImage)})
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        height: provider.lineupsModel.home.formation.split('-').length == 3
            ? 110
            : 90,
        width: 100,
        child: Stack(
          children: <Widget>[
            Stack(
              children: [
                Container(
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          child: Image.network(
                              "https://www.eplworld.com${provider.lineupsModel.home.players.inField[index].img}"),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 4,
                    left: 14,
                    child: Container(
                      width: 20,
                      height: 35,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: provider.lineupsModel.home.players
                                    .inField[index].events ==
                                null
                            ? 0
                            : provider.lineupsModel.home.players.inField[index]
                                .events.length,
                        itemBuilder: (context, indexx) {
                          return provider.lineupsModel.home.players
                                      .inField[index].events[indexx].type ==
                                  'substitute'
                              ? Column(
                                  children: [
                                    Text(
                                      provider.lineupsModel.home.players
                                          .inField[index].events[indexx].time
                                          .toString(),
                                      style: TextStyle(
                                          fontFamily: 'Vazirmatn',
                                          color: Colors.white),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Center(
                                          child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 20,
                                      )),
                                    ),
                                  ],
                                )
                              : Container();
                        },
                      ),
                    )),
                provider.lineupsModel.home.players.inField[index].rating
                        .isNotEmpty
                    ? Positioned(
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
                                    child: Text(
                                        provider.lineupsModel.home.players
                                            .inField[index].rating,
                                        style: TextStyle(
                                            fontFamily: 'Vazirmatn',
                                            color: Colors.white,
                                            fontSize: 12))),
                              ),
                            ],
                          ),
                        ))
                    : Container(
                        width: 33,
                        height: 23,
                      ),
                Positioned(
                    bottom: 18,
                    right: 52,
                    child: Container(
                      width: 40,
                      height: 25,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: provider.lineupsModel.home.players
                                      .inField[index].events ==
                                  null
                              ? 0
                              : provider.lineupsModel.home.players
                                  .inField[index].events.length,
                          itemBuilder: (context, indexx) {
                            return provider.lineupsModel.home.players
                                        .inField[index].events[indexx].type ==
                                    'goal'
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                          width: 10,
                                          child: Icon(
                                            MdiIcons.soccer,
                                            size: 20,
                                            color: Colors.white,
                                          )),
                                    ],
                                  )
                                : Container();
                          }),
                    )),
                Positioned(
                    bottom: 17,
                    right: 15,
                    child: Container(
                      width: 16,
                      height: 23,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: provider.lineupsModel.home.players
                                      .inField[index].events ==
                                  null
                              ? 0
                              : provider.lineupsModel.home.players
                                  .inField[index].events.length,
                          itemBuilder: (context, indexx) {
                            return provider.lineupsModel.home.players
                                        .inField[index].events[indexx].type ==
                                    'yellowCard'
                                ? Column(
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
                                  )
                                : Container();
                          }),
                    ))
              ],
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
                                child: Text(
                                  "${provider.lineupsModel.home.players.inField[index].number} ",
                                  style: TextStyle(
                                      fontFamily: 'Vazirmatn',
                                      color: Colors.white,fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                    "${provider.lineupsModel.home.players.inField[index].name} ",
                                    style: TextStyle(
                                        fontFamily: 'Vazirmatn',
                                        color: Colors.white,
                                        fontSize: 13,height: 1.1),
                                    overflow: TextOverflow.visible),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  });
}

Widget PlayerAway(matchId, index,teamImage) {
  return Consumer<EachMatchViewModel>(builder: (context, provider, child) {
    return InkWell(
      onTap: () => {
        provider.getPlayerInfo(matchId, provider.lineupsModel.away.players.inField[index].id)
            .then((value) => {if (value != null) showPlayerInfo(context, value,teamImage)})
      },
      child:  Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        height: provider.lineupsModel.away.formation.split('-').length == 3
            ? 110
            : 90,
        width: 100,
        child: Stack(
          children: <Widget>[
            Stack(
              children: [
                Container(
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          child: Image.network(
                              "https://www.eplworld.com${provider.lineupsModel.away.players.inField[index].img}"),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 4,
                    left: 14,
                    child: Container(
                      width: 20,
                      height: 35,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: provider.lineupsModel.away.players
                            .inField[index].events ==
                            null
                            ? 0
                            : provider.lineupsModel.away.players.inField[index]
                            .events.length,
                        itemBuilder: (context, indexx) {
                          return provider.lineupsModel.away.players
                              .inField[index].events[indexx].type ==
                              'substitute'
                              ? Column(
                            children: [
                              Text(
                                provider.lineupsModel.away.players
                                    .inField[index].events[indexx].time
                                    .toString(),
                                style: TextStyle(
                                    fontFamily: 'Vazirmatn',
                                    color: Colors.white),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                    BorderRadius.circular(4)),
                                child: Center(
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 20,
                                    )),
                              ),
                            ],
                          )
                              : Container();
                        },
                      ),
                    )),
                provider.lineupsModel.away.players.inField[index].rating
                    .isNotEmpty
                    ? Positioned(
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
                                child: Text(
                                    provider.lineupsModel.away.players
                                        .inField[index].rating,
                                    style: TextStyle(
                                        fontFamily: 'Vazirmatn',
                                        color: Colors.white,
                                        fontSize: 12))),
                          ),
                        ],
                      ),
                    ))
                    : Container(
                  width: 33,
                  height: 23,
                ),
                Positioned(
                    bottom: 18,
                    right: 52,
                    child: Container(
                      width: 40,
                      height: 25,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: provider.lineupsModel.away.players
                              .inField[index].events ==
                              null
                              ? 0
                              : provider.lineupsModel.away.players
                              .inField[index].events.length,
                          itemBuilder: (context, indexx) {
                            return provider.lineupsModel.away.players
                                .inField[index].events[indexx].type ==
                                'goal'
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    width: 10,
                                    child: Icon(
                                      MdiIcons.soccer,
                                      size: 20,
                                      color: Colors.white,
                                    )),
                              ],
                            )
                                : Container();
                          }),
                    )),
                Positioned(
                    bottom: 17,
                    right: 15,
                    child: Container(
                      width: 16,
                      height: 23,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: provider.lineupsModel.away.players
                              .inField[index].events ==
                              null
                              ? 0
                              : provider.lineupsModel.away.players
                              .inField[index].events.length,
                          itemBuilder: (context, indexx) {
                            return provider.lineupsModel.away.players
                                .inField[index].events[indexx].type ==
                                'yellowCard'
                                ? Column(
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
                            )
                                : Container();
                          }),
                    ))
              ],
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
                                child: Text(
                                  "${provider.lineupsModel.away.players.inField[index].number} ",
                                  style: TextStyle(
                                      fontFamily: 'Vazirmatn',
                                      color: Colors.white,fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                    "${provider.lineupsModel.away.players.inField[index].name} ",
                                    style: TextStyle(
                                        fontFamily: 'Vazirmatn',
                                        color: Colors.white,
                                        fontSize: 13,height: 1.1),
                                    overflow: TextOverflow.visible),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  });
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
