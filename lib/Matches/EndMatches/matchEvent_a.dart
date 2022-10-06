import 'package:arseli/EachTeam/eachTeam.dart';
import 'package:arseli/Provider/EachMatchViewModel.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:arseli/matches.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MatchEvent_a extends StatefulWidget {
  String homeId;
  String awayId;
  String comName;
  String url;
  MatchEvent_a({this.url,this.homeId,this.awayId});
  @override
  _MatchEvent_aState createState() => _MatchEvent_aState();
}

class _MatchEvent_aState extends State<MatchEvent_a> {
  TextStyle _textStyle = TextStyle(fontFamily: 'Vazirmatn', fontWeight: FontWeight.w800, fontSize: 16);
  TextStyle _textStyle1 = TextStyle(fontFamily: 'Vazirmatn', color: Colors.grey, fontSize: 13);
  TextStyle _textStyle2 = TextStyle(fontFamily: 'Vazirmatn', color: Colors.green);
  TextStyle _textStyle3 = TextStyle(fontFamily: 'Vazirmatn', color: Colors.red);

  TextStyle head = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 15, fontWeight: FontWeight.w500);
  TextStyle content = TextStyle(fontFamily: 'Vazirmatn', fontSize: 13.5);
  TextStyle content2 =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 13.5, color: Colors.grey);
  TextStyle content3 = TextStyle(fontFamily: 'Vazirmatn', fontSize: 12);
  TextStyle content4 =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 12, color: Colors.grey);
  TextStyle number = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 18, fontWeight: FontWeight.w400);
  TextStyle headline = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 11, fontWeight: FontWeight.w600);
  TextStyle headline2 =
  TextStyle(fontFamily: 'Vazirmatn', fontSize: 13.5, color: Colors.grey);


  EachMatchViewModel eachMatchViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eachMatchViewModel = Provider.of(context, listen: false);
      eachMatchViewModel.getMatchEndEvent(widget.url);
      var now = DateTime.now();
      //print(now);
    });
    super.initState();
  }

  bool test = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: EdgeInsets.only(bottom: 20),
        child:
            Consumer<EachMatchViewModel>(
                builder: (context, provider, child) {
                  print("hellllllo${provider.tablesModelList[0].list}");
          return provider.loadingEventsEnd || provider.matchDetailsModel == null
              ? Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(children: <Widget>[
                  /*
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: provider.eventsModel.length,
                        itemBuilder: (context, index) {
                          return provider.eventsModel[index] != null
                              ? Event(index, provider.eventsModel[index].details.name)
                              : Container();
                        },
                      ),
                    ),
                  ),

                   */
                  SizedBox(
                    height: 8,
                  ),
                  Column(children: <Widget>[
                    Container(
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
                              padding: const EdgeInsets.only(right: 16,left: 16,top: 12,bottom: 8),
                              child: Text(
                                  'تفاصيل المباراة',
                                  style: Theme.of(context).textTheme.headline2
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      // CircleAvatar(radius: 10,),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'المسابقة',
                                              style: Theme.of(context).textTheme.bodyText1
                                          ),
                                          SizedBox(width: 5,),
                                          Text(
                                            provider.matchDetailsModel.leagueName.tr,
                                            style: Theme.of(context).textTheme.bodyText2,
                                            maxLines: 2,
                                            softWrap: true,
                                          )

                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 22,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'ضربة البداية',
                                              style: Theme.of(context).textTheme.bodyText1
                                          ),
                                          Text(
                                            provider.matchDetailsModel.date.tr,
                                            style: Theme.of(context).textTheme.bodyText2,
                                            maxLines: 2,
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 22,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'ملعب المباراة',
                                              style: Theme.of(context).textTheme.bodyText1
                                          ),
                                          Text(
                                            provider.matchDetailsModel.groundName.tr,
                                            style: Theme.of(context).textTheme.bodyText2,
                                            maxLines: 2,
                                            softWrap: true,
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    provider.matchDetailsModel.teamFormModel.away.isBlank
                        ? Container()
                        : Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        height: 270,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 16,left: 16,top: 12,bottom: 8),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text("نتائج الفرق".tr,style: Theme.of(context).textTheme.headline2,)
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                    height: 170,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child:Container(
                                            height: 190,
                                            child: ListView.builder(
                                                physics: NeverScrollableScrollPhysics(),
                                                scrollDirection:
                                                Axis.vertical,
                                                itemCount: 4,
                                                itemBuilder:
                                                    (context, index) {
                                                  return Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        left: 3,
                                                        right: 25,
                                                        top: 8,
                                                        bottom: 8),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 25,
                                                          width: 26,
                                                          child: Image.network(
                                                              "https://www.eplworld.com${provider.msnModel.homeTeamLogo}"),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 21,
                                                          width: 21,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(6),
                                                              color: provider.teamFormModel.teamFormModel.home[index].status == 'W'
                                                                  ? Colors.green
                                                                  : provider.teamFormModel.teamFormModel.home[index].status == 'L'
                                                                  ? Colors.red
                                                                  : provider.teamFormModel.teamFormModel.home[index].status == 'D'
                                                                  ? Colors.black45
                                                                  : null),
                                                          child: Center(
                                                              child: Text(
                                                                provider
                                                                    .teamFormModel
                                                                    .teamFormModel
                                                                    .home[index]
                                                                    .status,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    'Vazirmatn',
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                    fontSize:
                                                                    16),
                                                              )),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 25,
                                                          width: 26,
                                                          child: Image.network(
                                                              "https://www.eplworld.com${provider.teamFormModel.teamFormModel.home[index].teamLogo}"),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ),
                                        Flexible(
                                          child: Container(
                                            height: 190,
                                            child: ListView.builder(
                                                scrollDirection:
                                                Axis.vertical,
                                                physics: NeverScrollableScrollPhysics(),
                                                itemCount: 4,
                                                itemBuilder:
                                                    (context, index) {
                                                  return Padding(
                                                    padding:
                                                    const EdgeInsets.only(left: 25, right: 3, top: 8, bottom: 8),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          height: 25,
                                                          width: 26,
                                                          child: Image.network(
                                                              "https://www.eplworld.com${provider.msnModel.awayTeamLogo}"),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 21,
                                                          width: 21,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(6),
                                                              color: provider.teamFormModel.teamFormModel.away[index].status == 'W'
                                                                  ? Colors.green
                                                                  : provider.teamFormModel.teamFormModel.away[index].status == 'L'
                                                                  ? Colors.red
                                                                  : provider.teamFormModel.teamFormModel.away[index].status == 'D'
                                                                  ? Colors.black45
                                                                  : null),
                                                          child: Center(
                                                              child: Text(
                                                                provider
                                                                    .teamFormModel
                                                                    .teamFormModel
                                                                    .away[index]
                                                                    .status,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    'Vazirmatn',
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                    fontSize:
                                                                    16),
                                                              )),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 25,
                                                          width: 26,
                                                          child: Image.network(
                                                              "https://www.eplworld.com${provider.teamFormModel.teamFormModel.away[index].teamLogo}"),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ]),
                  SizedBox(height: 8,),
                  provider.tablesModelList[0].list.isEmpty || provider.tablesModelList[0].list.length > 1
                      ?Container()
                      :Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
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
                                        width: MediaQuery.of(context).size.width * 0.4,
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
                                            0.29,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 3, right: 20),
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
                                        width:
                                        MediaQuery.of(context).size.width * 0.22,
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
                              itemCount: provider
                                  .tablesModelList[0].list[0].tableModel.length,
                              itemBuilder: (BuildContext context, index) {
                                return   widget.homeId == provider.tablesModelList[0].list[0].tableModel[index].id
                                    || widget.awayId == provider.tablesModelList[0].list[0].tableModel[index].id
                                    ?Container(
                                  height: 60,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 6,
                                        right: 1,left: 1,
                                        child: Container(
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
                                                                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),),
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
                                                                        height: 25,
                                                                        child: Image.network(
                                                                            'https://www.eplworld.com${provider.tablesModelList[0].list[0].tableModel[index].logo}')),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
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
                                                                        provider.tablesModelList[0].list[0].tableModel[index].name,
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
                                    ],
                                  ),
                                )
                                    :Container();
                              }),



                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  /*
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'افضل اللاعبين',
                              style: TextStyle(
                                  fontFamily: 'Vazirmatn',
                                  fontWeight: FontWeight.w500),
                            ),
                            Divider(),
                            Padding(
                                padding: const EdgeInsets.only(top: 10,bottom: 15),
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    Row(
                                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 15,),
                                        Container(
                                          width: MediaQuery.of(context).size.width*.42,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width*.35,
                                                child: ListView.builder(
                                                  physics: NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: 5,
                                                  itemBuilder: (context,index){
                                                    return  Padding(padding:
                                                      const EdgeInsets.all(10.0),
                                                      child: Container(
                                                        height: 68,
                                                        width: 123,
                                                        child: Stack(
                                                          children: <Widget>[
                                                            Positioned(
                                                              right: 15,
                                                              child: Container(
                                                                width: 60,
                                                                height: 60,
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: Colors.grey[100],
                                                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(6.0),
                                                                  child: ClipRRect(
                                                                    borderRadius: BorderRadius.all(Radius.circular(50),
                                                                    ),
                                                                    child: Image.asset("assets/Marcelo.jpg"),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                                bottom: 0,
                                                                right: 5,
                                                                child: Container(
                                                                  height: 25,
                                                                  width: 26,
                                                                  child: Image.network(
                                                                      "https://www.eplworld.com${provider.msnModel.homeTeamLogo}"),
                                                                )),
                                                            Positioned(
                                                                top: 0,
                                                                right: 5,
                                                                child: Container(
                                                                  height: 13,
                                                                  width: 25,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(8),
                                                                    color: Colors.green,
                                                                  ),

                                                                )),
                                                            Positioned(
                                                                left: 2,bottom: 0,
                                                                child:  Container(
                                                                  width: 50,
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(" مارسيلو ",overflow: TextOverflow.clip,softWrap: true,textDirection: TextDirection.rtl,style: TextStyle(height: 1),),
                                                                      Text('st',style: TextStyle(color: Colors.black54,fontSize: 12.5),)
                                                                    ],
                                                                  ),
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                        Container(
                                          width: MediaQuery.of(context).size.width*.42,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width*.35,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:Axis.vertical,
                                                  itemCount: 4,
                                                  itemBuilder: (context,index){
                                                    return  Padding(
                                                      padding:
                                                      const EdgeInsets.all(10.0),
                                                      child: Container(
                                                        height: 68,
                                                        width: 123,
                                                        child: Stack(
                                                          children: <Widget>[
                                                            Positioned(
                                                              left: 15,
                                                              child: Container(
                                                                width: 60,
                                                                height: 60,
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: Colors.grey[100],
                                                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(6.0),
                                                                  child: ClipRRect(
                                                                    borderRadius: BorderRadius.all(Radius.circular(50),
                                                                    ),
                                                                    child: Image.asset("assets/Marcelo.jpg"),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                                bottom: 0,
                                                                left: 5,
                                                                child: Container(
                                                                  height: 25,
                                                                  width: 26,
                                                                  child: Image.network(
                                                                      "https://www.eplworld.com${provider.msnModel.awayTeamLogo}"),
                                                                )),
                                                            Positioned(
                                                                top: 0,
                                                                left: 5,
                                                                child: Container(
                                                                  height: 13,
                                                                  width: 25,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(8),
                                                                    color: Colors.green,
                                                                  ),

                                                                )),
                                                            Positioned(
                                                                right: 2,bottom: 0,
                                                                child:  Container(
                                                                  width: 50,
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(" مارسيلو  ",overflow: TextOverflow.clip,softWrap: true,textDirection: TextDirection.rtl,style: TextStyle(height: 1),),
                                                                      Text('st',style: TextStyle(color: Colors.black54,fontSize: 12.5),)
                                                                    ],
                                                                  ),
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),


                                      ],
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                   */

                ]),
              );
        }));
  }

  Widget _goal(String name, index) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child:
            Consumer<EachMatchViewModel>(builder: (context, provider, child) {
          return Directionality(
            textDirection: provider.eventsModel[index].linkedTo == 'home'
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      provider.eventsModel[index].details.time.toString(),
                      style: Theme.of(context).textTheme.headline2
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    MdiIcons.soccer,
                    size: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(provider.eventsModel[index].details.belongsToName.tr,style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),)
                        ],
                      ),
                      provider.eventsModel[index].details.goalMakerName.isBlank
                          ? Container()
                          : Row(
                              children: <Widget>[
                                provider.eventsModel[index].linkedTo == 'home'
                                    ? Text(
                                        " صانع الهدف : ${provider.eventsModel[index].details.goalMakerName}"
                                            .tr,
                                    style:Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 13)
                                      )
                                    : Text(
                                        " ${provider.eventsModel[index].details.goalMakerName} صانع الهدف : "
                                            .tr,
                                        style:Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 13)
                                      )
                              ],
                            )
                    ],
                  )
                ],
              ),
            ),
          );
        }));
  }

  Widget _switch(String name, index) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Consumer<EachMatchViewModel>(builder: (contex, provider, child) {
          return Directionality(
            textDirection: provider.eventsModel[index].linkedTo == 'home'
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      provider.eventsModel[index].details.time.toString(),
                        style: Theme.of(context).textTheme.headline2
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: 20,
                        height: 16,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 20,
                        height: 16,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 15,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            provider.eventsModel[index].details.subOfName.tr,
                            style: _textStyle2,
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            provider.eventsModel[index].details.subWithName.tr,
                            style: _textStyle3,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }));
  }

  Widget _var(String name, index) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child:
            Consumer<EachMatchViewModel>(builder: (context, provider, child) {
          return Directionality(
            textDirection: provider.eventsModel[index].linkedTo == 'home'
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      provider.eventsModel[index].details.time.toString(),
                        style: Theme.of(context).textTheme.headline2
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    MdiIcons.television,
                    size: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(provider.eventsModel[index].details.belongsToName.tr,
                      style:Theme.of(context).textTheme.headline2.copyWith(fontSize: 13)),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "(${provider.eventsModel[index].details.outcome})".tr,
                      style:Theme.of(context).textTheme.subtitle2
                  )
                ],
              ),
            ),
          );
        }));
  }

  Widget _timerIntervals(String name, index) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child:
            Consumer<EachMatchViewModel>(builder: (context, provider, child) {
          return Directionality(
            textDirection: provider.eventsModel[index].linkedTo == 'home'
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: Container(
              child: Row(
                children: <Widget>[
                  Icon(
                    MdiIcons.timer,
                    size: 22,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("${provider.eventsModel[index].details.status}".tr,
                      style:Theme.of(context).textTheme.headline2),
                ],
              ),
            ),
          );
        }));
  }

  Widget _yellow(String name, index) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Consumer<EachMatchViewModel>(
          builder: (context, provider, child) {
            return Directionality(
              textDirection: provider.eventsModel[index].linkedTo == 'home'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        provider.eventsModel[index].details.time.toString(),
                          style: Theme.of(context).textTheme.headline2
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 23,
                      width: 15,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(provider.eventsModel[index].details.belongsToName.tr,
                        style:Theme.of(context).textTheme.headline2.copyWith(fontSize: 13))
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget _redCard(String name, index) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Consumer<EachMatchViewModel>(
          builder: (context, provider, child) {
            return Directionality(
              textDirection: provider.eventsModel[index].linkedTo == 'home'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        provider.eventsModel[index].details.time.toString(),
                          style: Theme.of(context).textTheme.headline2
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 23,
                      width: 15,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(provider.eventsModel[index].details.belongsToName.tr,
                        style:Theme.of(context).textTheme.headline2.copyWith(fontSize: 13))
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget Event(index, name) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Consumer<EachMatchViewModel>(
          builder: (context, provider, child) {
            return provider.eventsModel[index].linkedTo == "home"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          child: provider.eventsModel[index].details.name ==
                                  "goal"
                              ? _goal(name, index)
                              : provider.eventsModel[index].details.name ==
                                      "yellowCard"
                                  ? _yellow(name, index)
                                  : provider.eventsModel[index].details.name ==
                                          "redCard"
                                      ? _redCard(name, index)
                                      : provider.eventsModel[index].details
                                                  .name ==
                                              "substitute"
                                          ? _switch(name, index)
                                          : provider.eventsModel[index].details
                                                      .name ==
                                                  "VAR"
                                              ? _var(name, index)
                                              : Container()),
                    ],
                  )
                : provider.eventsModel[index].linkedTo == "away"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: provider.eventsModel[index].details.name ==
                                    "goal"
                                ? _goal(name, index)
                                : provider.eventsModel[index].details.name ==
                                        "yellowCard"
                                    ? _yellow(name, index)
                                    : provider.eventsModel[index].details
                                                .name ==
                                            "substitute"
                                        ? _switch(name, index)
                                        : Container(),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [_timerIntervals(name, index)],
                      );
          },
        ),
      ),
    );
  }
}
