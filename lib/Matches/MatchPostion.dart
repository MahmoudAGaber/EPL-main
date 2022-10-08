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
    // return SizedBox();
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
            : Padding(
                padding: const EdgeInsets.only(
                    right: 12, left: 12, top: 16, bottom: 16),
                child: Column(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(right: 16,left: 16,top: 12,bottom: 8),
                                  child: Row(
                                    children: [
                                     // CircleAvatar(radius: 10,),
                                      SizedBox(width: 5,),
                                      Text(
                                        provider.matchDetailsModel.leagueName.tr,
                                        style: Theme.of(context).textTheme.headline2
                                      ),
                                    ],
                                  )
                              ),
                              Divider(),
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 5.0, bottom: 15.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.41,
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
                                        width: MediaQuery.of(context).size.width *
                                            0.27,
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
                                                width: 25,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                    "ف".tr,
                                                    style: headline2,
                                                  )),
                                              SizedBox(
                                                width: 25,
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
                                        width:
                                        MediaQuery.of(context).size.width * 0.23,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Text(
                                              "-/+",
                                              style: headline2,
                                            ),
                                            SizedBox(
                                              width: 23,
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
                              itemCount: provider
                                  .tablesModelList[0].list[0].tableModel.length,
                              itemBuilder: (BuildContext context, index) {
                                return Container(
                                  height: 60,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 6,
                                        right: 1,left: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(0),
                                            color: (provider.tablesModelList[0].list[0]
                                                .tableModel[index].id ==
                                                widget.awayId) ||
                                                (provider.tablesModelList[0].list[0]
                                                    .tableModel[index].id ==
                                                    widget.homeId)
                                                ? Theme.of(context).colorScheme.surface
                                                : null,
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
                                                            ChangeNotifierProvider<
                                                                EachTeamViewModel>(
                                                                create: (_) =>
                                                                    EachTeamViewModel(),
                                                                child: EachTeam(
                                                                  url: provider
                                                                      .tablesModelList[
                                                                  0]
                                                                      .list[0]
                                                                      .tableModel[index]
                                                                      .link,
                                                                  id: provider
                                                                      .tablesModelList[
                                                                  0]
                                                                      .list[0]
                                                                      .tableModel[index]
                                                                      .id,
                                                                ))));
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 12,left: 12),
                                                child: Container(
                                                  width:
                                                  MediaQuery.of(context).size.width*0.87,
                                                  height: 35,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                            children: [
                                                              Text((provider.tablesModelList[0].list[0].tableModel[index].serial).toString(),
                                                                style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),),
                                                            ],
                                                          ),
                                                          SizedBox(width: 3,),
                                                          Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            children: [
                                                              Container(
                                                                child: Container(
                                                                    width: 35,
                                                                    height: 28,
                                                                    child: Image.network(
                                                                        'https://www.eplworld.com${provider.tablesModelList[0].list[0].tableModel[index].logo}')),
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
                                                                    child: Text(
                                                                      provider.tablesModelList[0].list[0].tableModel[index].name,
                                                                      style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
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
                                                                Text(
                                                                  provider
                                                                      .tablesModelList[
                                                                  0]
                                                                      .list[0]
                                                                      .tableModel[index]
                                                                      .colL
                                                                      .toString(),
                                                                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
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
                                                                      .list[0]
                                                                      .tableModel[index]
                                                                      .colF
                                                                      .toString(),
                                                                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
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
                                                                      .list[0]
                                                                      .tableModel[index]
                                                                      .colT
                                                                      .toString(),
                                                                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
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
                                                                      .list[0]
                                                                      .tableModel[index]
                                                                      .colK
                                                                      .toString(),
                                                                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
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
                                                                      .list[0]
                                                                      .tableModel[index]
                                                                      .colFA,
                                                                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
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
                                                                      .list[0]
                                                                      .tableModel[index]
                                                                      .colN
                                                                      .toString(),
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
                                      Positioned(child: Divider(height: 7,)),
                                      Positioned(
                                        top: 8,
                                        bottom: 2,
                                        child: Container(
                                            width: 2,
                                            height: 40,
                                            color: provider.tablesModelList[0].list[0]
                                                .tableModel[index].tag ==
                                                'green'
                                                ? Colors.green
                                                : provider.tablesModelList[0].list[0]
                                                .tableModel[index].tag ==
                                                'blue'
                                                ? Colors.blue
                                                : provider
                                                .tablesModelList[0]
                                                .list[0]
                                                .tableModel[index]
                                                .tag ==
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
                          itemCount: provider
                              .tablesModelList[0].list[0].footermodel.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  right: 10, bottom: 10, left: 10, top: 10),
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
                                      .footermodel[index].text,style:Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 13.5),)
                                ],
                              ),
                            );
                          }),
                    )
                  ],
                ),
              );
      },
    );
  }
}
