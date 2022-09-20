import 'package:arseli/Playrers/players.dart';
import 'package:arseli/Provider/EachPlayerViewModel.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../trendingData.dart';

class teamTeam extends StatefulWidget {
  String url;
  teamTeam({this.url});
  @override
  _teamTeamState createState() => _teamTeamState();
}

class _teamTeamState extends State<teamTeam> {
  EachTeamViewModel eachTeamViewModel;
  TextStyle _textStyle =
      TextStyle(fontFamily: 'Vazirmatn', color: Colors.grey[500], fontSize: 13);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eachTeamViewModel = Provider.of(context, listen: false);
      eachTeamViewModel.getSquads("${widget.url}/squad");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EachTeamViewModel>(
      builder: (context, provider, child) {
        return provider.loadingSquad
            ? Padding(
                padding: EdgeInsets.only(top: 35),
                child: Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor),
                ))
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "المدرب".tr,
                                  style: TextStyle(
                                      fontFamily: 'Vazirmatn', fontSize: 17),
                                ),
                              ],
                            ),
                            Divider(),
                            SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider<
                                                EachplayerViewModel>(
                                              create: (_) =>
                                                  EachplayerViewModel(),
                                              child: EachPlayer(
                                                url: provider
                                                    .squadsModel.coach[0].link,
                                                teamImg: provider
                                                    .headerProfileModel.logo,
                                              ),
                                            )));
                              },
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
                                          child: Image.network(
                                              "https://www.eplworld.com${provider.squadsModel.coach[0].IMGAlt}"),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                          child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              provider
                                                  .squadsModel.coach[0].name.tr,
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
                                                  child: provider
                                                          .squadsModel
                                                          .coach[0]
                                                          .belongsToLogoAlt
                                                          .endsWith('svg')
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          child: SvgPicture.network(
                                                              "https://www.eplworld.com${provider.squadsModel.coach[0].belongsToLogoAlt}",
                                                              semanticsLabel:
                                                                  'Acme Logo'))
                                                      : Image.network(
                                                          "https://www.eplworld.com${provider.squadsModel.coach[0].belongsToLogoAlt}"),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  provider.squadsModel.coach[0]
                                                      .belongsToName.tr,
                                                  style: _textStyle,
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
                          ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  Text(
                                    "حراس المرمي".tr,
                                    style: TextStyle(
                                        fontFamily: 'Vazirmatn', fontSize: 17),
                                  ),
                                ],
                              ),
                              Divider(),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          ListView.builder(
                                              physics: ClampingScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: provider.squadsModel
                                                  .Goalkeeper.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6, bottom: 6),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ChangeNotifierProvider<
                                                                          EachplayerViewModel>(
                                                                        create: (_) =>
                                                                            EachplayerViewModel(),
                                                                        child:
                                                                            EachPlayer(
                                                                          url: provider
                                                                              .squadsModel
                                                                              .Goalkeeper[index]
                                                                              .link,
                                                                          teamImg: provider
                                                                              .headerProfileModel
                                                                              .logo,
                                                                        ),
                                                                      )));
                                                        },
                                                        child: Container(
                                                          width: 45,
                                                          height: 45,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          100)),
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .grey)),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  100),
                                                            ),
                                                            child: Image.network(
                                                                "https://www.eplworld.com${provider.squadsModel.Goalkeeper[index].IMGAlt}"),
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
                                                            Text(
                                                              provider
                                                                  .squadsModel
                                                                  .Goalkeeper[
                                                                      index]
                                                                  .name
                                                                  .tr,
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                CircleAvatar(
                                                                  maxRadius: 8,
                                                                  child: provider
                                                                          .squadsModel
                                                                          .Goalkeeper[
                                                                              index]
                                                                          .belongsToLogoAlt
                                                                          .endsWith(
                                                                              'svg')
                                                                      ? ClipRRect(
                                                                          borderRadius: BorderRadius.circular(
                                                                              50),
                                                                          child: SvgPicture.network(
                                                                              "https://www.eplworld.com${provider.squadsModel.Goalkeeper[index].belongsToLogoAlt}",
                                                                              semanticsLabel:
                                                                                  'Acme Logo'))
                                                                      : Image.network(
                                                                          "https://www.eplworld.com${provider.squadsModel.Goalkeeper[index].belongsToLogoAlt}"),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  provider
                                                                      .squadsModel
                                                                      .Goalkeeper[
                                                                          index]
                                                                      .belongsToName
                                                                      .tr,
                                                                  style:
                                                                      _textStyle,
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  Text(
                                    "مدافعين".tr,
                                    style: TextStyle(
                                        fontFamily: 'Vazirmatn', fontSize: 17),
                                  ),
                                ],
                              ),
                              Divider(),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          ListView.builder(
                                              physics: ClampingScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: provider
                                                  .squadsModel.Defender.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6, bottom: 6),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ChangeNotifierProvider<
                                                                          EachplayerViewModel>(
                                                                        create: (_) =>
                                                                            EachplayerViewModel(),
                                                                        child:
                                                                            EachPlayer(
                                                                          url: provider
                                                                              .squadsModel
                                                                              .Defender[index]
                                                                              .link,
                                                                          teamImg: provider
                                                                              .headerProfileModel
                                                                              .logo,
                                                                        ),
                                                                      )));
                                                        },
                                                        child: Container(
                                                          width: 45,
                                                          height: 45,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          100)),
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .grey)),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  100),
                                                            ),
                                                            child: Image.network(
                                                                "https://www.eplworld.com${provider.squadsModel.Defender[index].IMGAlt}"),
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
                                                            Text(
                                                              provider
                                                                  .squadsModel
                                                                  .Defender[
                                                                      index]
                                                                  .name
                                                                  .tr,
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                CircleAvatar(
                                                                  maxRadius: 8,
                                                                  child: provider
                                                                          .squadsModel
                                                                          .Defender[
                                                                              index]
                                                                          .belongsToLogoAlt
                                                                          .endsWith(
                                                                              'svg')
                                                                      ? ClipRRect(
                                                                          borderRadius: BorderRadius.circular(
                                                                              50),
                                                                          child: SvgPicture.network(
                                                                              "https://www.eplworld.com${provider.squadsModel.Defender[index].belongsToLogoAlt}",
                                                                              semanticsLabel:
                                                                                  'Acme Logo'))
                                                                      : Image.network(
                                                                          "https://www.eplworld.com${provider.squadsModel.Defender[index].belongsToLogoAlt}"),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  provider
                                                                      .squadsModel
                                                                      .Defender[
                                                                          index]
                                                                      .belongsToName
                                                                      .tr,
                                                                  style:
                                                                      _textStyle,
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4, top: 4),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  Text(
                                    "وسط".tr,
                                    style: TextStyle(
                                        fontFamily: 'Vazirmatn', fontSize: 17),
                                  ),
                                ],
                              ),
                              Divider(),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          ListView.builder(
                                              physics: ClampingScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: provider.squadsModel
                                                  .Midfielder.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6, bottom: 6),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ChangeNotifierProvider<
                                                                          EachplayerViewModel>(
                                                                        create: (_) =>
                                                                            EachplayerViewModel(),
                                                                        child:
                                                                            EachPlayer(
                                                                          url: provider
                                                                              .squadsModel
                                                                              .Midfielder[index]
                                                                              .link,
                                                                          teamImg: provider
                                                                              .headerProfileModel
                                                                              .logo,
                                                                        ),
                                                                      )));
                                                        },
                                                        child: Container(
                                                          width: 45,
                                                          height: 45,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          100)),
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .grey)),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  100),
                                                            ),
                                                            child: Image.network(
                                                                "https://www.eplworld.com${provider.squadsModel.Midfielder[index].IMGAlt}"),
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
                                                            Text(
                                                              provider
                                                                  .squadsModel
                                                                  .Midfielder[
                                                                      index]
                                                                  .name
                                                                  .tr,
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                CircleAvatar(
                                                                  maxRadius: 8,
                                                                  child: provider
                                                                          .squadsModel
                                                                          .Midfielder[
                                                                              index]
                                                                          .belongsToLogoAlt
                                                                          .endsWith(
                                                                              'svg')
                                                                      ? ClipRRect(
                                                                          borderRadius: BorderRadius.circular(
                                                                              50),
                                                                          child: SvgPicture.network(
                                                                              "https://www.eplworld.com${provider.squadsModel.Midfielder[index].belongsToLogoAlt}",
                                                                              semanticsLabel:
                                                                                  'Acme Logo'))
                                                                      : Image.network(
                                                                          "https://www.eplworld.com${provider.squadsModel.Midfielder[index].belongsToLogoAlt}"),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  provider
                                                                      .squadsModel
                                                                      .Midfielder[
                                                                          index]
                                                                      .belongsToName
                                                                      .tr,
                                                                  style:
                                                                      _textStyle,
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                                Text(
                                  "هجوم".tr,
                                  style: TextStyle(
                                      fontFamily: 'Vazirmatn', fontSize: 17),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        ListView.builder(
                                            physics: ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: provider
                                                .squadsModel.Attacker.length,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6, bottom: 6),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ChangeNotifierProvider<
                                                                        EachplayerViewModel>(
                                                                      create: (_) =>
                                                                          EachplayerViewModel(),
                                                                      child:
                                                                          EachPlayer(
                                                                        url: provider
                                                                            .squadsModel
                                                                            .Attacker[index]
                                                                            .link,
                                                                        teamImg: provider
                                                                            .headerProfileModel
                                                                            .logo,
                                                                      ),
                                                                    )));
                                                      },
                                                      child: Container(
                                                        width: 45,
                                                        height: 45,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            100)),
                                                            border: Border.all(
                                                                width: 1,
                                                                color: Colors
                                                                    .grey)),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                100),
                                                          ),
                                                          child: Image.network(
                                                              "https://www.eplworld.com${provider.squadsModel.Attacker[index].IMGAlt}"),
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
                                                          Text(
                                                            provider
                                                                .squadsModel
                                                                .Attacker[index]
                                                                .name
                                                                .tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CircleAvatar(
                                                                maxRadius: 8,
                                                                child: provider
                                                                        .squadsModel
                                                                        .Attacker[
                                                                            index]
                                                                        .belongsToLogoAlt
                                                                        .endsWith(
                                                                            'svg')
                                                                    ? ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                50),
                                                                        child: SvgPicture.network(
                                                                            "https://www.eplworld.com${provider.squadsModel.Attacker[index].belongsToLogoAlt}",
                                                                            semanticsLabel:
                                                                                'Acme Logo'))
                                                                    : Image.network(
                                                                        "https://www.eplworld.com${provider.squadsModel.Attacker[index].belongsToLogoAlt}"),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                provider
                                                                    .squadsModel
                                                                    .Attacker[
                                                                        index]
                                                                    .belongsToName
                                                                    .tr,
                                                                style:
                                                                    _textStyle,
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
