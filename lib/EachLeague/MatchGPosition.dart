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
            : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                  children: [
                    provider.dropsTableRows == null
                        ? Container()
                        : Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                        ),
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
                              const EdgeInsets.only(right: 8, left: 8),
                              child: Text(value,style: Theme.of(context).textTheme.bodyText1),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: <Widget>[
                        /*
                        Padding(
                            padding: const EdgeInsets.only(
                                right: 16,
                                left: 16,
                                top: 12,
                                bottom: 8),
                            child: Row(
                              children: [
                                // CircleAvatar(radius: 10,),
                                SizedBox(
                                  width: 5,
                                ),
                                /*
                                Text(provider.calName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2),

                                 */
                              ],
                            )),
                        Divider(),

                         */
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 16.0),
                          child: Container(
                            width:
                            MediaQuery.of(context).size.width,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.41,
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "المركز",
                                        style: TextStyle(
                                            fontFamily:
                                            'Vazirmatn',
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.3,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(
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
                                          width: 25,
                                        ),
                                        Expanded(
                                            child: Text(
                                              "ف".tr,
                                              style: headline2,
                                            )),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Expanded(
                                            child: Text(
                                              "ت".tr,
                                              style: headline2,
                                            )),
                                        SizedBox(
                                          width: 30,
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
                                      0.22,
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Text(
                                        "-/+",
                                        style: headline2,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "ن".tr,
                                        style: headline2,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider.tablesModelList[0].list.length,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                            padding: const EdgeInsets.only(top: 4,bottom: 4),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10, top: 8, bottom: 8),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              provider.tablesModelList[0].list[index].title,
                                              style: Theme.of(context).textTheme.headline1
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: provider.tablesModelList[0].list[index].tableModel.length,
                                    itemBuilder: (BuildContext context, indexx) {
                                      return Container(
                                        height: 60,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: 6,
                                              right: 1,
                                              left: 1,
                                              child: Container(
                                                height: 60,
                                                color: (provider.tablesModelList[0].list[index].tableModel[indexx].id == widget.awayId)
                                                    ||
                                                    (provider.tablesModelList[0].list[index].tableModel[indexx].id == widget.homeId)
                                                    ?Colors.grey[300]
                                                    :null,
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                                        url: provider.tablesModelList[0].list[index].tableModel[indexx].link,
                                                                        id: provider.tablesModelList[0].list[index].tableModel[indexx].id,
                                                                      )
                                                                  )
                                                              )
                                                          );
                                                        },
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              right: 12,
                                                              left: 12),
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .width *
                                                                0.87,
                                                            height: 35,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment.center,
                                                                      children: [
                                                                        Text(
                                                                          (provider.tablesModelList[0].list[index].tableModel[indexx].serial).toString(),
                                                                          style:
                                                                          Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                      3,
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
                                                                              child: Image.network('https://www.eplworld.com${provider.tablesModelList[0].list[index].tableModel[indexx].logo}')),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                      10,
                                                                    ),
                                                                  ],
                                                                ),
                                                                Flexible(
                                                                    flex: 4,
                                                                    child:
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment.start,
                                                                      children: [
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              provider.tablesModelList[0].list[index].tableModel[indexx].name,
                                                                              style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
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
                                                                            provider.tablesModelList[0].list[index].tableModel[indexx].colL.toString(),
                                                                            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            provider.tablesModelList[0].list[index].tableModel[indexx].colF.toString(),
                                                                            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            provider.tablesModelList[0].list[index].tableModel[indexx].colT.toString(),
                                                                            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            provider.tablesModelList[0].list[index].tableModel[indexx].colK.toString(),
                                                                            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            provider.tablesModelList[0].list[index].tableModel[indexx].colFA,
                                                                            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            provider.tablesModelList[0].list[index].tableModel[indexx].colN.toString(),
                                                                            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
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
                                            Positioned(
                                                child: Divider(
                                                  height: 7,
                                                )),
                                            Positioned(
                                              top: 8,
                                              bottom: 2,
                                              child: Container(
                                                  width: 2,
                                                  height: 40,
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
                                                      .tablesModelList[0]
                                                      .list[index]
                                                      .tableModel[indexx]
                                                      .tag ==
                                                      'yellow'
                                                      ? Colors
                                                      .yellow
                                                      : null),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                SizedBox(
                                  height: 10,
                                ),
                                ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: provider.tablesModelList[0].list[index].footermodel.length,
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
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
            );
      },
    );
  }
}
