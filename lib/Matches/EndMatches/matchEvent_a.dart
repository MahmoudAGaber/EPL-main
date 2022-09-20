import 'package:arseli/Provider/EachMatchViewModel.dart';
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
  TextStyle _textStyle = TextStyle(
      fontFamily: 'Vazirmatn', fontWeight: FontWeight.w800, fontSize: 16);
  TextStyle _textStyle1 =
      TextStyle(fontFamily: 'Vazirmatn', color: Colors.grey, fontSize: 13);
  TextStyle _textStyle2 =
      TextStyle(fontFamily: 'Vazirmatn', color: Colors.green);
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
                padding: const EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
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
                              ? Event(index,
                              provider.eventsModel[index].details.name)
                              : Container();
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(children: <Widget>[
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
                                'تفاصيل المباراة',
                                style: TextStyle(
                                    fontFamily: 'Vazirmatn',
                                    fontWeight: FontWeight.w500),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(radius: 10,),
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
                                              style: TextStyle(
                                                  fontFamily: 'Vazirmatn',
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),
                                            Text(
                                              provider.matchDetailsModel
                                                  .leagueName.tr,
                                              style: TextStyle(color: Colors.black54),
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
                                              style: TextStyle(
                                                  fontFamily: 'Vazirmatn',
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),
                                            Text(
                                              provider
                                                  .matchDetailsModel.date.tr,
                                              style: TextStyle(color: Colors.black54),
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
                                              style: TextStyle(
                                                  fontFamily: 'Vazirmatn',
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),
                                            Text(
                                              provider.matchDetailsModel.groundName.tr,
                                              style: TextStyle(color: Colors.black54),
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
                    ),
                    provider.matchDetailsModel.teamFormModel.away.isBlank
                        ? Container()
                        : Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        height: 175,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0))),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, right: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text("المواجهات السابقة".tr,
                                        style: TextStyle(
                                            fontFamily: 'Vazirmatn',
                                            fontWeight:
                                            FontWeight.w600))
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 85,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Container(
                                            height: 85,
                                            child: ListView.builder(
                                                scrollDirection:
                                                Axis.horizontal,
                                                itemCount: provider
                                                    .teamFormModel
                                                    .teamFormModel
                                                    .home
                                                    .length,
                                                itemBuilder:
                                                    (context, index) {
                                                  return Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        left: 3,
                                                        right: 3,
                                                        top: 8,
                                                        bottom: 8),
                                                    child: Column(
                                                      children: [
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
                                                              child:
                                                              Text(
                                                                provider
                                                                    .teamFormModel
                                                                    .teamFormModel
                                                                    .home[
                                                                index]
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
                                                          height: 5,
                                                        ),
                                                        index == 0
                                                            ? Container(
                                                          height:
                                                          2,
                                                          width:
                                                          23,
                                                          color: Colors
                                                              .green,
                                                        )
                                                            : Container(),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          height: 25,
                                                          width: 26,
                                                          child: Image
                                                              .network(
                                                              "https://www.eplworld.com${provider.teamFormModel.teamFormModel.home[index].teamLogo}"),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Container(
                                            height: 85,
                                            child: ListView.builder(
                                                scrollDirection:
                                                Axis.horizontal,
                                                itemCount: provider
                                                    .teamFormModel
                                                    .teamFormModel
                                                    .away
                                                    .length,
                                                itemBuilder:
                                                    (context, index) {
                                                  return Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        left: 3,
                                                        right: 3,
                                                        top: 8,
                                                        bottom: 8),
                                                    child: Column(
                                                      children: [
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
                                                              child:
                                                              Text(
                                                                provider
                                                                    .teamFormModel
                                                                    .teamFormModel
                                                                    .away[
                                                                index]
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
                                                          height: 5,
                                                        ),
                                                        index == 0
                                                            ? Container(
                                                          height:
                                                          2,
                                                          width:
                                                          23,
                                                          color: Colors
                                                              .green,
                                                        )
                                                            : Container(),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          height: 25,
                                                          width: 26,
                                                          child: Image
                                                              .network(
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
                  SizedBox(height: 5,),
                  provider.tablesModelList == null || provider.tablesModelList[0].list.length > 1
                      ?Container()
                      :Container(
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
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                ),
                                SizedBox(width: 5,),
                                InkWell(
                                  onTap: (){
                                    print(widget.awayId);
                                  },
                                  child: Text(
                                    provider.matchDetailsModel.leagueName,
                                    style: TextStyle(
                                        fontFamily: 'Vazirmatn',
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),

                            Divider(),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
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
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.3,
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
                                                  width: 33,
                                                ),
                                                Expanded(
                                                    child: Text(
                                                      "ف".tr,
                                                      style: headline2,
                                                    )),
                                                SizedBox(
                                                  width: 33,
                                                ),
                                                Expanded(
                                                    child: Text(
                                                      "ت".tr,
                                                      style: headline2,
                                                    )),
                                                SizedBox(
                                                  width: 28,
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
                                                width: 24,
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
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: provider.tablesModelList[0].list[0].tableModel.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return
                                        widget.homeId == provider.tablesModelList[0].list[0].tableModel[index].id
                                            || widget.awayId == provider.tablesModelList[0].list[0].tableModel[index].id
                                            ?Container(
                                          child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 10),
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 35,
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
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                              children: [
                                                                Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.center,
                                                                  children: [
                                                                    Text(
                                                                      provider.tablesModelList[0].list[0].tableModel[index].name,
                                                                      style: content,
                                                                    )
                                                                  ],
                                                                )
                                                              ],
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
                                              ]),
                                        )
                                            :Container();
                                    })
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
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
                      style: _textStyle,
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
                          Text(provider
                              .eventsModel[index].details.belongsToName.tr)
                        ],
                      ),
                      provider.eventsModel[index].details.goalMakerName.isBlank
                          ? Container()
                          : Row(
                              children: <Widget>[
                                provider.eventsModel[index].linkedTo == 'home'
                                    ? Text(
                                        "${provider.eventsModel[index].details.goalMakerName} :صانع الهدف"
                                            .tr,
                                        style: _textStyle1,
                                      )
                                    : Text(
                                        " صانع الهدف: ${provider.eventsModel[index].details.goalMakerName}"
                                            .tr,
                                        style: _textStyle1,
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
                      style: _textStyle,
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
                      style: _textStyle,
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
                  Text(provider.eventsModel[index].details.belongsToName.tr),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "(${provider.eventsModel[index].details.outcome})".tr,
                    style: content2,
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
                      style: head),
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
                        style: _textStyle,
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
                    Text(provider.eventsModel[index].details.belongsToName.tr)
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
                        style: _textStyle,
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
                    Text(provider.eventsModel[index].details.belongsToName.tr)
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
