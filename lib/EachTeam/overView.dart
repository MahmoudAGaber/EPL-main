import 'package:arseli/Matches/EndMatches/matchInfo_a.dart';
import 'package:arseli/Playrers/players.dart';
import 'package:arseli/webView.dart';
import 'package:arseli/Provider/EachPlayerViewModel.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/util.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';

import '../main.dart';
import 'eachTeam.dart';

class OverView extends StatefulWidget {
  String url;
  String id;
  OverView({this.url,this.id});
  @override
  _OverViewState createState() => _OverViewState();
}

class _OverViewState extends State<OverView> {
  TextStyle head = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 15, fontWeight: FontWeight.w500);
  TextStyle content = TextStyle(fontFamily: 'Vazirmatn', fontSize: 14);
  TextStyle content2 = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 13, color: Colors.black45);
  TextStyle content3 = TextStyle(fontFamily: 'Vazirmatn', fontSize: 12);
  TextStyle content4 =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 12, color: Colors.grey);
  TextStyle number = TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 20,
  );

  TextStyle tapbar = TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 13,
  );
  TextStyle headline = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 11, fontWeight: FontWeight.w600);
  TextStyle headline2 =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 13.5, color: Colors.grey);

  EachTeamViewModel eachTeamViewModel;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eachTeamViewModel = Provider.of(context, listen: false);
      eachTeamViewModel.getOverView("${widget.url}/overview");
      print(widget.id);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      minimum: EdgeInsets.only(bottom: 10.0),
      child: Consumer<EachTeamViewModel>(
        builder: (context, provider, child) {
          return provider.loadingOverView || provider.tablesModelList == null
              ? Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  )),
                )
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 5, left: 5),
                                    child: Text("المباره الاخيره".tr,
                                        style: head),
                                  )
                                ],
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      physics: ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 1,
                                      itemBuilder: (BuildContext context, index) {
                                        return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            physics:NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: 1,
                                            itemBuilder: (contex, indexx) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              matchInfo_a(
                                                                url:
                                                                    provider.recentMatcheBox[index].matchInBoxModel[indexx].matchURL,
                                                              )));
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width*.83,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Text(
                                                            provider.recentMatcheBox[index].matchInBoxModel[indexx].matchDate.tr,style: TextStyle(fontSize: 13.5,color: Colors.black54)
                                                          ),
                                                          Row(
                                                            children: [
                                                              CircleAvatar(radius: 8,),
                                                              SizedBox(width: 2,),
                                                              Text(provider.recentMatcheBox[index].matchInBoxModel[indexx].belongsTo,style: TextStyle(fontSize: 13.5,color: Colors.black54),)
                                                            ],
                                                          )

                                                        ],
                                                      ),
                                                      SizedBox(height: 20,),
                                                      Container(
                                                          child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Flexible(
                                                          flex: 5,
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width * .41,
                                                            child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                Flexible(
                                                                  child: Text(
                                                                    provider.recentMatcheBox[index].matchInBoxModel[indexx].homeTeamName,
                                                                    style: TextStyle(fontFamily: 'Vazirmatn', fontSize: 15, fontWeight: FontWeight.w500),overflow: TextOverflow.clip,textDirection: TextDirection.ltr,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          flex: 7,
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width * .42,
                                                            child:
                                                                Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 10),
                                                                  child: Container(
                                                                    width: 37,
                                                                    height: 30,
                                                                    child: provider.recentMatcheBox[index].matchInBoxModel[indexx].homeTeamLogo.endsWith('svg') ? SvgPicture.network("https://www.eplworld.com${provider.recentMatcheBox[index].matchInBoxModel[indexx].homeTeamLogo}", semanticsLabel: 'Acme Logo') : Image.network("https://www.eplworld.com${provider.recentMatcheBox[index].matchInBoxModel[indexx].homeTeamLogo}"),
                                                                  ),
                                                                ),
                                                                provider.recentMatcheBox[index].matchInBoxModel[indexx].periodId != null
                                                                    ? Text(
                                                                        provider.recentMatcheBox[index].matchInBoxModel[indexx].status == 'Fixture'
                                                                            ? provider.recentMatcheBox[index].matchInBoxModel[indexx].matchTime
                                                                            : "${provider.recentMatcheBox[index].matchInBoxModel[indexx].homeTeamScore}"
                                                                                " - "
                                                                                "${provider.recentMatcheBox[index].matchInBoxModel[indexx].awayTeamScore}",
                                                                        style: (provider.recentMatcheBox[index].matchInBoxModel[indexx].status == "Fixture") ? TextStyle(fontFamily: 'Vazirmatn', fontSize: 16, color: Colors.black) : TextStyle(fontFamily: 'Vazirmatn', fontSize: 16, color: Colors.black54),
                                                                      )
                                                                    : Text('__'),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(right: 10),
                                                                  child: Container(width: 37, height: 30, child: provider.recentMatcheBox[index].matchInBoxModel[indexx].awayTeamLogo.endsWith('svg') ? SvgPicture.network("https://www.eplworld.com${provider.recentMatcheBox[index].matchInBoxModel[indexx].awayTeamLogo}", semanticsLabel: 'Acme Logo') : Image.network("https://www.eplworld.com${provider.recentMatcheBox[index].matchInBoxModel[indexx].awayTeamLogo}")),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          flex:
                                                              5,
                                                          child:
                                                              Container(
                                                            width: MediaQuery.of(context).size.width * .4,
                                                            child:
                                                                Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Flexible(
                                                                  child: Text(
                                                                    provider.recentMatcheBox[index].matchInBoxModel[indexx].awayTeamName,
                                                                    style: TextStyle(fontFamily: 'Vazirmatn', fontSize: 15, fontWeight: FontWeight.w500),overflow: TextOverflow.clip,textDirection: TextDirection.rtl,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      }),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    provider.newsModelList == null
                        ? Container()
                        : Stack(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 8,bottom: 12,right: 12),
                            child: Container(
                              height: 260,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 30,),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: provider.newsModelList.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return Container(
                                          height: 200,
                                          width: 230,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          webView(
                                                            url:
                                                                "https://www.eplworld.com${provider.newsModelList[index].url}",
                                                          )));
                                            },
                                            child: Card(
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10))),
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    height: 100,
                                                    width: MediaQuery.of(
                                                            context)
                                                        .size
                                                        .width,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(
                                                                    10),
                                                            topLeft: Radius
                                                                .circular(
                                                                    10))),
                                                    child: ClipRRect(
                                                      child: Image.network(
                                                          provider
                                                              .newsModelList[
                                                                  index]
                                                              .imageJPG,
                                                          fit: BoxFit.fill),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      10),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      10)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets
                                                            .all(8.0),
                                                    child: Container(
                                                      height: 55,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                              child: Text(
                                                            provider
                                                                .newsModelList[
                                                                    index]
                                                                .title
                                                                .tr,
                                                            style: content3,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                          ))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets
                                                                .only(
                                                            top: 10,
                                                            right: 15),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(
                                                          "${provider.newsModelList[index].date} - ${provider.newsModelList[index].time}"
                                                              .tr,
                                                          style: content4,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ));
                                    }),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 8,
                              right: 18,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "اخر الاخبار".tr,
                                    style: head,
                                  )
                                ],
                              )),
                        ]),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 10,
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      provider.tablesModelList[0].list[0].title,
                                      style: TextStyle(
                                          fontFamily: 'Vazirmatn',
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),

                              Divider(),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.38,
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
                                              width: MediaQuery.of(context).size.width * 0.29,
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
                                                      width: 33,
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
                                                  0.21,
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
                                                    width: 15,
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
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: provider.tablesModelList[0].list[0].tableModel.length,
                                      itemBuilder: (BuildContext context, index) {
                                        return Container(
                                          color: widget.id == provider.tablesModelList[0].list[0].tableModel[index].id?Colors.grey[100]:null,
                                            child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 10),
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width,
                                                      height: 40,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Container(
                                                            width: 20,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Text((provider.tablesModelList[0].list[0].tableModel[index].serial)
                                                                    .toString()),
                                                              ],
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Container(
                                                                child: Container(
                                                                    width: 35,
                                                                    height: 25,
                                                                    child: Image.network('https://www.eplworld.com${provider.tablesModelList[0].list[0].tableModel[index].logo}')),
                                                              ),
                                                            ],
                                                          ),
                                                          Flexible(
                                                              flex: 3,
                                                              child:
                                                              Container(
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                                                ),
                                                              )),
                                                          Flexible(
                                                            flex: 5,
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
                                                  Divider(height: 5,)
                                                ]),
                                        );
                                      })
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Stack(children: <Widget>[
                      Container (
                        height: 350,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 50, bottom: 20, right: 12, left: 12),
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: ClampingScrollPhysics(),
                              itemCount: provider.statsModel.playersModel.length ?? 0,
                              itemBuilder: (BuildContext context, index) {
                                return Container(
                                  height: 220,
                                  width: 250,
                                  child: Card(
                                    elevation: 3.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(children: <Widget>[
                                            Text(
                                              provider.statsModel.playersModel[index].title.tr,
                                              style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                                            )
                                          ]),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                          ),
                                          height: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(right: 10,left: 10),
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
                                                                    builder: (context) =>
                                                                        ChangeNotifierProvider<
                                                                            EachplayerViewModel>(
                                                                          create: (_) =>
                                                                              EachplayerViewModel(),
                                                                          child:
                                                                          EachPlayer(
                                                                            url: provider.statsModel.playersModel[index].firstModel.URL,
                                                                            teamImg: provider.statsModel.playersModel[index].firstModel.teamLogo,
                                                                          ),
                                                                        )));
                                                          },
                                                          child: Container(
                                                              height: 60,
                                                              width: 60,
                                                              child: ClipRRect(
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      50),
                                                                  child: Image
                                                                      .network(
                                                                      "https://www.eplworld.com${provider.statsModel.playersModel[index].firstModel.IMG}"))
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8,bottom: 12),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Text(
                                                          provider.statsModel.playersModel[index].firstModel.name.tr,
                                                          style: content,
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 20,
                                                              width: 20,
                                                              child: Image.network("https://www.eplworld.com${provider.statsModel.playersModel[index].firstModel.teamLogo}"),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              provider
                                                                  .statsModel
                                                                  .playersModel[
                                                                      index]
                                                                  .firstModel
                                                                  .teamName
                                                                  .tr,
                                                              style: content2,
                                                            ),
                                                          ],
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 10,),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        provider
                                                            .statsModel
                                                            .playersModel[
                                                        index]
                                                            .firstModel
                                                            .number,
                                                        style: TextStyle(color: Colors.black26,fontSize: 22,fontWeight: FontWeight.w600),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 20,
                                              bottom: 8),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('2',style: TextStyle(fontSize: 18,color: Colors.black38),),
                                              Row(
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
                                                                        .statsModel
                                                                        .playersModel[index]
                                                                        .secondModel
                                                                        .URL,
                                                                    teamImg: provider
                                                                        .statsModel
                                                                        .playersModel[index]
                                                                        .secondModel
                                                                        .teamLogo,
                                                                  ),
                                                                )));
                                                  },
                                                  child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: ClipRRect(
                                                          borderRadius: BorderRadius
                                                              .all(Radius
                                                                  .circular(
                                                                      100)),
                                                          child:
                                                              Image.network(
                                                            "https://www.eplworld.com${provider.statsModel.playersModel[index].secondModel.IMG}",
                                                          ))),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(provider
                                                    .statsModel
                                                    .playersModel[index]
                                                    .secondModel
                                                    .name)
                                              ]),
                                              SizedBox(width: 25,),
                                              Text(
                                                provider
                                                    .statsModel
                                                    .playersModel[index]
                                                    .secondModel
                                                    .number,
                                                style: TextStyle(
                                                    fontFamily: 'Vazirmatn',
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 20,
                                              bottom: 8),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('3',style: TextStyle(fontSize: 18,color: Colors.black38),),
                                              Row(
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
                                                                            .statsModel
                                                                            .playersModel[index]
                                                                            .thirdModel
                                                                            .URL,
                                                                        teamImg: provider
                                                                            .statsModel
                                                                            .playersModel[index]
                                                                            .thirdModel
                                                                            .teamLogo,
                                                                      ),
                                                                    )));
                                                      },
                                                      child: Container(
                                                          height: 30,
                                                          width: 30,
                                                          child: ClipRRect(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                  .circular(
                                                                  100)),
                                                              child:
                                                              Image.network(
                                                                "https://www.eplworld.com${provider.statsModel.playersModel[index].thirdModel.IMG}",
                                                              ))),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(provider
                                                        .statsModel
                                                        .playersModel[index]
                                                        .thirdModel
                                                        .name)
                                                  ]),
                                              SizedBox(width: 25,),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[100],
                                                    borderRadius: BorderRadius.circular(4)
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: Text(
                                                    provider
                                                        .statsModel
                                                        .playersModel[index]
                                                        .thirdModel
                                                        .number,
                                                    style: TextStyle(
                                                        fontFamily: 'Vazirmatn',
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                      Positioned(
                          top: 10,
                          right: 20,
                          child: Row(
                            children: <Widget>[
                              Text(
                                "إحصائيات اللاعبين".tr,
                                style: head,
                              )
                            ],
                          )),
                    ]),
                    /*
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Stack(children: <Widget>[
                        Container(
                          height: 320,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 50, bottom: 20, right: 12, left: 12),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: ClampingScrollPhysics(),
                                  itemCount:
                                      provider.statsModel.teamsModel.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return Container(
                                      height: 298,
                                      width: 280,
                                      child: Card(
                                        elevation: 3.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.grey[100],
                                              ),
                                              height: 130,
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5,
                                                              right: 15),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Row(children: <
                                                              Widget>[
                                                            Text(
                                                              provider
                                                                  .statsModel
                                                                  .teamsModel[
                                                                      index]
                                                                  .title,
                                                              style: head,
                                                            )
                                                          ]),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Text(
                                                              provider
                                                                  .statsModel
                                                                  .teamsModel[
                                                                      index]
                                                                  .firstModel
                                                                  .name,
                                                              style: content),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Text(
                                                                provider
                                                                    .statsModel
                                                                    .teamsModel[
                                                                        index]
                                                                    .firstModel
                                                                    .number,
                                                                style: number,
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              bottom: 20),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
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
                                                                            url:
                                                                                provider.statsModel.teamsModel[index].firstModel.URL,
                                                                          ))));
                                                            },
                                                            child: Container(
                                                                height: 65,
                                                                width: 65,
                                                                child: Image
                                                                    .network(
                                                                        "https://www.eplworld.com${provider.statsModel.teamsModel[index].firstModel.IMG}")),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  top: 20,
                                                  bottom: 13),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Row(children: <Widget>[
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
                                                                          .statsModel
                                                                          .teamsModel[
                                                                              index]
                                                                          .secondModel
                                                                          .URL,
                                                                    ))));
                                                      },
                                                      child: Container(
                                                        height: 25,
                                                        width: 25,
                                                        child: Image.network(
                                                            "https://www.eplworld.com${provider.statsModel.teamsModel[index].secondModel.IMG}"),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(provider
                                                        .statsModel
                                                        .teamsModel[index]
                                                        .secondModel
                                                        .name)
                                                  ]),
                                                  Text(
                                                    provider
                                                        .statsModel
                                                        .teamsModel[index]
                                                        .secondModel
                                                        .number,
                                                    style: TextStyle(
                                                        fontFamily: 'Vazirmatn',
                                                        fontSize: 17),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Row(children: <Widget>[
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
                                                                          .statsModel
                                                                          .teamsModel[
                                                                              index]
                                                                          .thirdModel
                                                                          .URL,
                                                                    ))));
                                                      },
                                                      child: Container(
                                                        height: 25,
                                                        width: 25,
                                                        child: Image.network(
                                                            "https://www.eplworld.com${provider.statsModel.teamsModel[index].thirdModel.IMG}"),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(provider
                                                        .statsModel
                                                        .teamsModel[index]
                                                        .thirdModel
                                                        .name)
                                                  ]),
                                                  Text(
                                                    provider
                                                        .statsModel
                                                        .teamsModel[index]
                                                        .thirdModel
                                                        .number,
                                                    style: TextStyle(
                                                        fontFamily: 'Vazirmatn',
                                                        fontSize: 17),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 20,
                            right: 20,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "إحصائيات الفرق".tr,
                                  style: head,
                                )
                              ],
                            )),
                      ]),
                    ),

                     */
                    /*
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  "الكؤوس".tr,
                                  style: head,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset("assets/541.jpg")),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset("assets/541.jpg")),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 55),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "اخر فوز 2014".tr,
                                  style: content4,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "اخر فوز 2016/2017".tr,
                                  style: content4,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "CAF Super Cup",
                                  style: content,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "كأس".tr,
                                  style: content,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25, right: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "6",
                                  style: TextStyle(                      fontFamily: 'Vazirmatn',
                                      fontSize: 20, fontWeight: FontWeight.w300),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text("37",
                                    style: TextStyle(                      fontFamily: 'Vazirmatn',
                                        fontSize: 20, fontWeight: FontWeight.w300)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Container(
                  height: 210,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "الملعب".tr,
                                  style: head,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(MdiIcons.scoreboard),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Camp Nou".tr,
                                      style: content,
                                    ),
                                    Text(
                                      "Barcelona,اسبانيا".tr,
                                      style: TextStyle(                      fontFamily: 'Vazirmatn',color: Colors.grey),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Card(
                                    color: Colors.grey[200],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(100))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(
                                        MdiIcons.googleMaps,
                                        color: Colors.green[700],
                                        size: 22,
                                      ),
                                    ))
                              ],
                            ),
                            Divider(
                              height: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30, right: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        "عشب".tr,
                                        style: content,
                                      ),
                                      Text("سطح الملعب".tr,
                                          style: TextStyle(                      fontFamily: 'Vazirmatn',color: Colors.grey)),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        "99.787",
                                        style: content,
                                      ),
                                      Text("السعة".tr,
                                          style: TextStyle(                      fontFamily: 'Vazirmatn',color: Colors.grey)),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        "1957",
                                        style: content,
                                      ),
                                      Text(
                                        "افتح".tr,
                                        style: TextStyle(                      fontFamily: 'Vazirmatn',color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ),

               */
                  ],
                );
        },
      ),
    );
  }
}
