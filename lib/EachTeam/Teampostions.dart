import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'eachTeam.dart';

class TeamPosition extends StatefulWidget {
  String url;
  String id;
  TeamPosition({this.url, this.id});

  @override
  _TeamPositionState createState() => _TeamPositionState();
}

var indexx = 2;

class _TeamPositionState extends State<TeamPosition> {
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

  EachTeamViewModel eachTeamViewModel;
  List dropList;
  String selectedItem;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eachTeamViewModel = Provider.of(context, listen: false);
      eachTeamViewModel.getTables(widget.url, "tables");
      dropList = eachTeamViewModel.dropsTableRows2;
      selectedItem = dropList[0];
      print("jjhkjhjk${eachTeamViewModel.calName2}");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<EachTeamViewModel>(
        builder: (context, provider, child) {
          return provider.loadingPositions
              ? Padding(
                  padding: EdgeInsets.only(top: 35),
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ))
              : Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 16, bottom: 16),
                  child: Column(
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                          ),
                          value: selectedItem,
                          isExpanded: true,
                          menuMaxHeight: 300,
                          items: provider.dropsTableRows2.map((String value) {
                            return DropdownMenuItem<String>(
                              onTap: () {
                                provider.dropTableRows2List.forEach((element) {
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
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 8, bottom: 4),
                                  child: Text(
                                    provider.calName ?? '',
                                    style: TextStyle(
                                        fontFamily: 'Vazirmatn',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, bottom: 5.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.42,
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "المركز",
                                                style: TextStyle(
                                                    fontFamily: 'Vazirmatn',
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.31,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 3, right: 15),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    "ل".tr,
                                                    style: headline2,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  "ف".tr,
                                                  style: headline2,
                                                )),
                                                SizedBox(
                                                  width: 35,
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  "ت".tr,
                                                  style: headline2,
                                                )),
                                                SizedBox(
                                                  width: 35,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
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
                            Divider(),
                            if (provider.tablesModelList[0].list.length == 1) Column(
                                    children: [
                                      ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          physics: ClampingScrollPhysics(),
                                          itemCount: provider.tablesModelList[0]
                                              .list[0].tableModel.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Stack(
                                              children: [
                                                Container(
                                                  color: widget.id ==
                                                          provider
                                                              .tablesModelList[
                                                                  0]
                                                              .list[0]
                                                              .tableModel[index]
                                                              .id
                                                      ? Colors.grey[300]
                                                      : null,
                                                  child: Column(
                                                      children: <Widget>[
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => ChangeNotifierProvider<
                                                                            EachTeamViewModel>(
                                                                        create: (_) =>
                                                                            EachTeamViewModel(),
                                                                        child:
                                                                            EachTeam(
                                                                          url: provider
                                                                              .tablesModelList[0]
                                                                              .list[0]
                                                                              .tableModel[index]
                                                                              .link,
                                                                        ))));
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 6,
                                                                    bottom: 6,
                                                                    left: 10,
                                                                    right: 10),
                                                            child: Container(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              height: 40,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: <
                                                                    Widget>[
                                                                  Row(
                                                                    children: [
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text((provider.tablesModelList[0].list[0].tableModel[index].serial)
                                                                              .toString()),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            child: Container(
                                                                                width: 35,
                                                                                height: 25,
                                                                                child: Image.network('https://www.eplworld.com${provider.tablesModelList[0].list[0].tableModel[index].logo}')),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Flexible(
                                                                      flex: 4,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Flexible(
                                                                            child: Column(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.center,
                                                                              children: [
                                                                                Flexible(
                                                                                  child: Text(
                                                                                    provider.tablesModelList[0].list[0].tableModel[index].name,
                                                                                    overflow: TextOverflow.clip,
                                                                                    style: content,
                                                                                  ),
                                                                                )
                                                                              ],
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
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              provider.tablesModelList[0].list[0].tableModel[index].colL.toString(),
                                                                              style: content,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              provider.tablesModelList[0].list[0].tableModel[index].colF.toString(),
                                                                              style: content,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              provider.tablesModelList[0].list[0].tableModel[index].colT.toString(),
                                                                              style: content,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              provider.tablesModelList[0].list[0].tableModel[index].colK.toString(),
                                                                              style: content,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              provider.tablesModelList[0].list[0].tableModel[index].colFA,
                                                                              style: content,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              provider.tablesModelList[0].list[0].tableModel[index].colN.toString(),
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
                                                    height: 45,
                                                    color: provider
                                                                .tablesModelList[
                                                                    0]
                                                                .list[0]
                                                                .tableModel[
                                                                    index]
                                                                .tag ==
                                                            'green'
                                                        ? Colors.green
                                                        : provider
                                                                    .tablesModelList[
                                                                        0]
                                                                    .list[0]
                                                                    .tableModel[
                                                                        index]
                                                                    .tag ==
                                                                'blue'
                                                            ? Colors.blue
                                                            : provider
                                                                        .tablesModelList[
                                                                            0]
                                                                        .list[0]
                                                                        .tableModel[
                                                                            index]
                                                                        .tag ==
                                                                    'red'
                                                                ? Colors.red
                                                                : provider
                                                                            .tablesModelList[
                                                                                0]
                                                                            .list[
                                                                                0]
                                                                            .tableModel[
                                                                                index]
                                                                            .tag ==
                                                                        'yellow'
                                                                    ? Colors
                                                                        .yellow
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
                                          itemCount: provider.tablesModelList[0]
                                              .list[0].footermodel.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10,
                                                  bottom: 15,
                                                  left: 10,
                                                  top: 10),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 12,
                                                    height: 12,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color: provider
                                                                    .tablesModelList[
                                                                        0]
                                                                    .list[0]
                                                                    .footermodel[
                                                                        index]
                                                                    .color ==
                                                                'green'
                                                            ? Colors.green
                                                            : provider
                                                                        .tablesModelList[
                                                                            0]
                                                                        .list[0]
                                                                        .footermodel[
                                                                            index]
                                                                        .color ==
                                                                    'blue'
                                                                ? Colors.blue
                                                                : provider
                                                                            .tablesModelList[
                                                                                0]
                                                                            .list[
                                                                                0]
                                                                            .footermodel[
                                                                                index]
                                                                            .color ==
                                                                        'red'
                                                                    ? Colors.red
                                                                    : provider.tablesModelList[0].list[0].footermodel[index].color ==
                                                                            'yellow'
                                                                        ? Colors
                                                                            .yellow
                                                                        : null),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(provider
                                                      .tablesModelList[0]
                                                      .list[0]
                                                      .footermodel[index]
                                                      .text)
                                                ],
                                              ),
                                            );
                                          })
                                    ],
                                  ) else ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        provider.tablesModelList[0].list.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return Column(
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10,
                                                    left: 10,
                                                    top: 8,
                                                    bottom: 8),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        provider
                                                            .tablesModelList[0]
                                                            .list[index]
                                                            .title,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Vazirmatn',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ]),
                                              ),
                                            ],
                                          ),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              physics: ClampingScrollPhysics(),
                                              itemCount: provider
                                                  .tablesModelList[0]
                                                  .list[index]
                                                  .tableModel
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      indexx) {
                                                return Stack(
                                                  children: [
                                                    Column(children: <Widget>[
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => ChangeNotifierProvider<
                                                                          EachTeamViewModel>(
                                                                      create: (_) =>
                                                                          EachTeamViewModel(),
                                                                      child:
                                                                          EachTeam(
                                                                        url: provider
                                                                            .tablesModelList[0]
                                                                            .list[index]
                                                                            .tableModel[indexx]
                                                                            .link,
                                                                        id: provider
                                                                            .tablesModelList[0]
                                                                            .list[index]
                                                                            .tableModel[indexx]
                                                                            .id,
                                                                      ))));
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  right: 10),
                                                          child: Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height: 40,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                Row(
                                                                  children: [
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text((provider.tablesModelList[0].list[index].tableModel[indexx].serial)
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
                                                                              child: Image.network('https://www.eplworld.com${provider.tablesModelList[0].list[index].tableModel[indexx].logo}')),
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
                                                                        Flexible(
                                                                          child: Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Flexible(
                                                                                child: Text(
                                                                                  provider.tablesModelList[0].list[index].tableModel[indexx].name,
                                                                                  overflow: TextOverflow.clip,
                                                                                  style: content,
                                                                                ),
                                                                              )
                                                                            ],
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
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            provider.tablesModelList[0].list[index].tableModel[indexx].colL.toString(),
                                                                            style:
                                                                                content,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            provider.tablesModelList[0].list[index].tableModel[indexx].colF.toString(),
                                                                            style:
                                                                                content,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            provider.tablesModelList[0].list[index].tableModel[indexx].colT.toString(),
                                                                            style:
                                                                                content,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            provider.tablesModelList[0].list[index].tableModel[indexx].colK.toString(),
                                                                            style:
                                                                                content,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            provider.tablesModelList[0].list[index].tableModel[indexx].colFA,
                                                                            style:
                                                                                content,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            provider.tablesModelList[0].list[index].tableModel[indexx].colN.toString(),
                                                                            style:
                                                                                content,
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
                                                    Container(
                                                        width: 4,
                                                        height: 35,
                                                        color: provider
                                                                    .tablesModelList[
                                                                        0]
                                                                    .list[index]
                                                                    .tableModel[
                                                                        indexx]
                                                                    .tag ==
                                                                'green'
                                                            ? Colors.green
                                                            : provider
                                                                        .tablesModelList[
                                                                            0]
                                                                        .list[
                                                                            index]
                                                                        .tableModel[
                                                                            indexx]
                                                                        .tag ==
                                                                    'blue'
                                                                ? Colors.blue
                                                                : provider
                                                                            .tablesModelList[
                                                                                0]
                                                                            .list[
                                                                                index]
                                                                            .tableModel[
                                                                                indexx]
                                                                            .tag ==
                                                                        'red'
                                                                    ? Colors.red
                                                                    : provider.tablesModelList[0].list[index].tableModel[indexx].tag ==
                                                                            'yellow'
                                                                        ? Colors
                                                                            .yellow
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
                                                  .tablesModelList[0]
                                                  .list[index]
                                                  .footermodel
                                                  .length,
                                              itemBuilder: (context, indexx) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10,
                                                          bottom: 5,
                                                          left: 10,
                                                          top: 5),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 12,
                                                        height: 12,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                                color: provider
                                                                            .tablesModelList[
                                                                                0]
                                                                            .list[
                                                                                index]
                                                                            .footermodel[
                                                                                indexx]
                                                                            .color ==
                                                                        'green'
                                                                    ? Colors
                                                                        .green
                                                                    : provider.tablesModelList[0].list[index].footermodel[indexx].color ==
                                                                            'blue'
                                                                        ? Colors
                                                                            .blue
                                                                        : provider.tablesModelList[0].list[index].footermodel[indexx].color ==
                                                                                'red'
                                                                            ? Colors.red
                                                                            : provider.tablesModelList[0].list[index].footermodel[indexx].color == 'yellow'
                                                                                ? Colors.yellow
                                                                                : null),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(provider
                                                          .tablesModelList[0]
                                                          .list[index]
                                                          .footermodel[indexx]
                                                          .text)
                                                    ],
                                                  ),
                                                );
                                              })
                                        ],
                                      );
                                    },
                                  )
                          ],
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
