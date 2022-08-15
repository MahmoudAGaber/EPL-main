import 'package:arseli/EachTeam/eachTeam.dart';
import 'package:arseli/Models/Leagues/Tournaments.dart';
import 'package:arseli/Provider/EachMatchViewModel.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:arseli/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MatchPostions extends StatefulWidget {
  String url;
  String homeId;
  String awayId;

  MatchPostions({this.url, this.homeId, this.awayId});

  @override
  _MatchPostionsState createState() => _MatchPostionsState();
}

TextStyle tapbar = TextStyle(
  fontSize: 13,
);
TextStyle headline = TextStyle(fontSize: 11, fontWeight: FontWeight.w600);
TextStyle headline2 = TextStyle(fontSize: 13.5, color: Colors.grey);
TextStyle content = TextStyle(
  fontSize: 13.5,
);

class _MatchPostionsState extends State<MatchPostions> {
  EachMatchViewModel eachMatchViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eachMatchViewModel = Provider.of(context, listen: false);
      eachMatchViewModel.getTables(widget.url);
      // print(matchesViewModel.tablesModelList);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("hello  ${widget.tournaments.url}");
    return Consumer<EachMatchViewModel>(
      builder: (context, provider, child) {
        return provider.loadingPositions || provider.tablesModelList.isEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                )),
              )
            : Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.42,
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "#",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      "فريق".tr,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.34,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 3, right: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          "ل".tr,
                                          style: headline2,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                          child: Text(
                                        "ف".tr,
                                        style: headline2,
                                      )),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                          child: Text(
                                        "ت".tr,
                                        style: headline2,
                                      )),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Expanded(
                                          child: Text(
                                        "خ".tr,
                                        style: headline2,
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.24,
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "-/+",
                                      style: headline2,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "ف أ".tr,
                                      style: headline2,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      itemCount:
                          provider.tablesModelList[0].list[0].tableModel.length,
                      itemBuilder: (BuildContext context, index) {
                        return Stack(
                          children: [
                            Container(
                              color: (provider.tablesModelList[0].list[0]
                                              .tableModel[index].id ==
                                          widget.awayId) ||
                                      (provider.tablesModelList[0].list[0]
                                              .tableModel[index].id ==
                                          widget.homeId)
                                  ? Colors.grey[300]
                                  : null,
                              child: Column(children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChangeNotifierProvider<
                                                        EachTeamViewModel>(
                                                    create: (_) =>
                                                        EachTeamViewModel(),
                                                    child: EachTeam(
                                                      url: provider
                                                          .tablesModelList[0]
                                                          .list[0]
                                                          .tableModel[index]
                                                          .link,
                                                      id: provider
                                                          .tablesModelList[0]
                                                          .list[0]
                                                          .tableModel[index]
                                                          .id,
                                                    ))));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text((provider
                                                          .tablesModelList[0]
                                                          .list[0]
                                                          .tableModel[index]
                                                          .serial)
                                                      .toString()),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Container(
                                                        width: 40,
                                                        height: 28,
                                                        child: Image.network(
                                                            'https://www.eplworld.com${provider.tablesModelList[0].list[0].tableModel[index].logo}')),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Flexible(
                                              flex: 4,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        provider
                                                            .tablesModelList[0]
                                                            .list[0]
                                                            .tableModel[index]
                                                            .name,
                                                        style: content,
                                                      )
                                                    ],
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
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      provider
                                                          .tablesModelList[0]
                                                          .list[0]
                                                          .tableModel[index]
                                                          .colL
                                                          .toString(),
                                                      style: content,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      provider
                                                          .tablesModelList[0]
                                                          .list[0]
                                                          .tableModel[index]
                                                          .colF
                                                          .toString(),
                                                      style: content,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      provider
                                                          .tablesModelList[0]
                                                          .list[0]
                                                          .tableModel[index]
                                                          .colT
                                                          .toString(),
                                                      style: content,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      provider
                                                          .tablesModelList[0]
                                                          .list[0]
                                                          .tableModel[index]
                                                          .colK
                                                          .toString(),
                                                      style: content,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      provider
                                                          .tablesModelList[0]
                                                          .list[0]
                                                          .tableModel[index]
                                                          .colFA,
                                                      style: content,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      provider
                                                          .tablesModelList[0]
                                                          .list[0]
                                                          .tableModel[index]
                                                          .colN
                                                          .toString(),
                                                      style: content,
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
                                Divider(
                                  height: 2.0,
                                  color: Colors.grey,
                                )
                              ]),
                            ),
                            Container(
                                width: 4,
                                height: 35,
                                color: provider.tablesModelList[0].list[0]
                                            .tableModel[index].tag ==
                                        'green'
                                    ? Colors.green
                                    : provider.tablesModelList[0].list[0]
                                                .tableModel[index].tag ==
                                            'blue'
                                        ? Colors.blue
                                        : provider.tablesModelList[0].list[0]
                                                    .tableModel[index].tag ==
                                                'red'
                                            ? Colors.red
                                            : provider
                                                        .tablesModelList[0]
                                                        .list[0]
                                                        .tableModel[index]
                                                        .tag ==
                                                    'yellow'
                                                ? Colors.yellow
                                                : null),
                          ],
                        );
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider
                          .tablesModelList[0].list[0].footermodel.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              right: 10, bottom: 15, left: 10, top: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: provider.tablesModelList[0].list[0]
                                                .footermodel[index].color ==
                                            'green'
                                        ? Colors.green
                                        : provider.tablesModelList[0].list[0]
                                                    .footermodel[index].color ==
                                                'blue'
                                            ? Colors.blue
                                            : provider
                                                        .tablesModelList[0]
                                                        .list[0]
                                                        .footermodel[index]
                                                        .color ==
                                                    'red'
                                                ? Colors.red
                                                : provider
                                                            .tablesModelList[0]
                                                            .list[0]
                                                            .footermodel[index]
                                                            .color ==
                                                        'yellow'
                                                    ? Colors.yellow
                                                    : null),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(provider.tablesModelList[0].list[0]
                                  .footermodel[index].text)
                            ],
                          ),
                        );
                      })
                ],
              );
      },
    );
  }
}
