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
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 14, color: Colors.grey);
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
      //print("jjhkjhjk${eachTeamViewModel.calName2}");
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
                  padding: const EdgeInsets.all(12),
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
                      SizedBox(
                        height: 8,
                      ),
                      Column(
                        children: [
                          /*
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white
                        ),
                        child: Center(child: Text('الكل',style: TextStyle(fontSize: 16,color: Theme.of(context).primaryColor,fontWeight: FontWeight.w500),)),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white
                        ),
                        child: Center(child: Text('ذهاب',style: TextStyle(fontSize: 16,color: Colors.black45,fontWeight: FontWeight.w500),)),
                      ),
                      Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white
                        ),
                        child: Center(child: Text('اياب',style: TextStyle(fontSize: 16,color: Colors.black45,fontWeight: FontWeight.w500),)),
                      ),
                      ],
                    ),
                    SizedBox(height: 8,),

                     */
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
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
                                           provider.calName==null
                                               ?Container()
                                               : Text(provider.calName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2),
                                          ],
                                        )),
                                    Divider(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, bottom: 15.0),
                                      child: Container(
                                        width:
                                        MediaQuery.of(context).size.width,
                                        child:  Row(
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
                                                  0.29,
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
                                                      width: 26,
                                                    ),
                                                    Expanded(
                                                        child: Text(
                                                          "ت".tr,
                                                          style: headline2,
                                                        )),
                                                    SizedBox(
                                                      width: 22,
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
                                                  0.19,
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
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: provider.tablesModelList[0]
                                        .list[0].tableModel.length,
                                    itemBuilder:
                                        (BuildContext context, index) {
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
                                                child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
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
                                                                        id: provider
                                                                            .tablesModelList[0]
                                                                            .list[0]
                                                                            .tableModel[index]
                                                                            .id,
                                                                      ))));
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
                                                                          (provider.tablesModelList[0].list[0].tableModel[index].serial).toString(),
                                                                          style:
                                                                          Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
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
                                                                              height: 28,
                                                                              child: Image.network('https://www.eplworld.com${provider.tablesModelList[0].list[0].tableModel[index].logo}')),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                      5,
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
                                                                        Flexible(
                                                                          child: FittedBox(
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.only(left: 5,right: 5),
                                                                              child: Text(
                                                                                provider.tablesModelList[0].list[0].tableModel[index].name,
                                                                                style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
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
                                                                        MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            provider.tablesModelList[0].list[0].tableModel[index].colL.toString(),
                                                                            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            provider.tablesModelList[0].list[0].tableModel[index].colF.toString(),
                                                                            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            provider.tablesModelList[0].list[0].tableModel[index].colT.toString(),
                                                                            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            provider.tablesModelList[0].list[0].tableModel[index].colK.toString(),
                                                                            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            provider.tablesModelList[0].list[0].tableModel[index].colFA,
                                                                            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            provider.tablesModelList[0].list[0].tableModel[index].colN.toString(),
                                                                            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
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
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: provider.tablesModelList[0].list[0]
                                    .footermodel.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10,
                                        bottom: 10,
                                        left: 10,
                                        top: 10),
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
                                                  .list[0]
                                                  .footermodel[index]
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
                                                  .list[0]
                                                  .footermodel[
                                              index]
                                                  .color ==
                                                  'red'
                                                  ? Colors.red
                                                  : provider
                                                  .tablesModelList[
                                              0]
                                                  .list[0]
                                                  .footermodel[
                                              index]
                                                  .color ==
                                                  'yellow'
                                                  ? Colors.yellow
                                                  : null),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          provider.tablesModelList[0].list[0]
                                              .footermodel[index].text,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .copyWith(fontSize: 13.5),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
