import 'package:arseli/EachTeam/eachTeam.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:arseli/Provider/EachLeagueViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../main.dart';

class MatchGPosition extends StatefulWidget {
  String url;
  String homeId;
  String awayId;
  MatchGPosition({this.url, this.homeId, this.awayId});
  @override
  _MatchGPositionState createState() => _MatchGPositionState();
}

class _MatchGPositionState extends State<MatchGPosition> {
  TextStyle tapbar = TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 13,
  );
  TextStyle headline = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 11, fontWeight: FontWeight.w600);
  TextStyle headline2 =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 13.5, color: Colors.grey);
  TextStyle content = TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 13.5,
  );
  @override
  EachLeagueViewModel oneLeagueViewModel;
  List dropList;
  String selectedItem;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      oneLeagueViewModel = Provider.of(context, listen: false);
      oneLeagueViewModel.getTables(
        widget.url,
        'tables',
      );
      dropList = oneLeagueViewModel.dropsTableRows;
      selectedItem = dropList[0];
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EachLeagueViewModel>(
      builder: (context, provider, child) {
        return provider.loadingPositions
            ? Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                children: [
                  provider.dropsTableRows == null
                      ? Container()
                      : DropdownButton<String>(
                          value: selectedItem,
                          isExpanded: true,
                          menuMaxHeight: 300,
                          items: provider.dropsTableRows.map((String value) {
                            return DropdownMenuItem<String>(
                              onTap: () {
                                provider.dropTableRowsList.forEach((element) {
                                  if (value == element.text) {
                                    provider.getTables(
                                        widget.url, "tables/${element.value}");
                                  }
                                });
                              },
                              value: value,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 4, left: 4),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedItem = value;
                            });
                          },
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
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
                                  style: TextStyle(
                                      fontFamily: 'Vazirmatn',
                                      color: Colors.grey),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  "فريق".tr,
                                  style: TextStyle(
                                      fontFamily: 'Vazirmatn',
                                      color: Colors.grey),
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
                                  Text(
                                    "ل".tr,
                                    style: headline2,
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    "ف".tr,
                                    style: headline2,
                                  ),
                                  SizedBox(
                                    width: 22,
                                  ),
                                  Text(
                                    "ت".tr,
                                    style: headline2,
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    "خ".tr,
                                    style: headline2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.24,
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 27,
                                ),
                                Text(
                                  "-/+",
                                  style: headline2,
                                ),
                                SizedBox(
                                  width: 25,
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
                  ),
                  ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: provider.tablesModelList[0].list.length,
                    itemBuilder: (BuildContext context, index) {
                      return Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, left: 10, top: 8, bottom: 8),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        provider.tablesModelList[0].list[index]
                                            .title,
                                        style: TextStyle(
                                            fontFamily: 'Vazirmatn',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: ClampingScrollPhysics(),
                              itemCount: provider.tablesModelList[0].list[index]
                                  .tableModel.length,
                              itemBuilder: (BuildContext context, indexx) {
                                return Stack(
                                  children: [
                                    Container(
                                      color: (provider
                                                      .tablesModelList[0]
                                                      .list[index]
                                                      .tableModel[indexx]
                                                      .id ==
                                                  widget.awayId) ||
                                              (provider
                                                      .tablesModelList[0]
                                                      .list[index]
                                                      .tableModel[indexx]
                                                      .id ==
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
                                                                  .tablesModelList[
                                                                      0]
                                                                  .list[index]
                                                                  .tableModel[
                                                                      indexx]
                                                                  .link,
                                                              id: provider
                                                                  .tablesModelList[
                                                                      0]
                                                                  .list[index]
                                                                  .tableModel[
                                                                      indexx]
                                                                  .id,
                                                            ))));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 35,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text((provider
                                                                  .tablesModelList[
                                                                      0]
                                                                  .list[index]
                                                                  .tableModel[
                                                                      indexx]
                                                                  .serial)
                                                              .toString()),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            child: Container(
                                                                width: 40,
                                                                height: 28,
                                                                child: Image
                                                                    .network(
                                                                        'https://www.eplworld.com${provider.tablesModelList[0].list[index].tableModel[indexx].logo}')),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Flexible(
                                                      flex: 4,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                provider
                                                                    .tablesModelList[
                                                                        0]
                                                                    .list[index]
                                                                    .tableModel[
                                                                        indexx]
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
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              provider
                                                                  .tablesModelList[
                                                                      0]
                                                                  .list[index]
                                                                  .tableModel[
                                                                      indexx]
                                                                  .colL
                                                                  .toString(),
                                                              style: content,
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              provider
                                                                  .tablesModelList[
                                                                      0]
                                                                  .list[index]
                                                                  .tableModel[
                                                                      indexx]
                                                                  .colF
                                                                  .toString(),
                                                              style: content,
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              provider
                                                                  .tablesModelList[
                                                                      0]
                                                                  .list[index]
                                                                  .tableModel[
                                                                      indexx]
                                                                  .colT
                                                                  .toString(),
                                                              style: content,
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              provider
                                                                  .tablesModelList[
                                                                      0]
                                                                  .list[index]
                                                                  .tableModel[
                                                                      indexx]
                                                                  .colK
                                                                  .toString(),
                                                              style: content,
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              provider
                                                                  .tablesModelList[
                                                                      0]
                                                                  .list[index]
                                                                  .tableModel[
                                                                      indexx]
                                                                  .colFA,
                                                              style: content,
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              provider
                                                                  .tablesModelList[
                                                                      0]
                                                                  .list[index]
                                                                  .tableModel[
                                                                      indexx]
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
                                        color: provider
                                                    .tablesModelList[0]
                                                    .list[index]
                                                    .tableModel[indexx]
                                                    .tag ==
                                                'green'
                                            ? Colors.green
                                            : provider
                                                        .tablesModelList[0]
                                                        .list[index]
                                                        .tableModel[indexx]
                                                        .tag ==
                                                    'blue'
                                                ? Colors.blue
                                                : provider
                                                            .tablesModelList[0]
                                                            .list[index]
                                                            .tableModel[indexx]
                                                            .tag ==
                                                        'red'
                                                    ? Colors.red
                                                    : provider
                                                                .tablesModelList[
                                                                    0]
                                                                .list[index]
                                                                .tableModel[
                                                                    indexx]
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
                              itemCount: provider.tablesModelList[0].list[index]
                                  .footermodel.length,
                              itemBuilder: (context, indexx) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, bottom: 5, left: 10, top: 5),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: provider
                                                        .tablesModelList[0]
                                                        .list[index]
                                                        .footermodel[indexx]
                                                        .color ==
                                                    'green'
                                                ? Colors.green
                                                : provider
                                                            .tablesModelList[0]
                                                            .list[index]
                                                            .footermodel[indexx]
                                                            .color ==
                                                        'blue'
                                                    ? Colors.blue
                                                    : provider
                                                                .tablesModelList[
                                                                    0]
                                                                .list[index]
                                                                .footermodel[
                                                                    indexx]
                                                                .color ==
                                                            'red'
                                                        ? Colors.red
                                                        : provider
                                                                    .tablesModelList[
                                                                        0]
                                                                    .list[index]
                                                                    .footermodel[
                                                                        indexx]
                                                                    .color ==
                                                                'yellow'
                                                            ? Colors.yellow
                                                            : null),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(provider.tablesModelList[0]
                                          .list[index].footermodel[indexx].text)
                                    ],
                                  ),
                                );
                              })
                        ],
                      );
                    },
                  ),
                ],
              );
      },
    );
  }
}
