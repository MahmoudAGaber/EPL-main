import 'package:arseli/EachTeam/eachTeam.dart';
import 'package:arseli/Provider/EachMatchViewModel.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class MatchEvents extends StatefulWidget {
  String homeId;
  String awayId;
  String comName;
  String url;
  MatchEvents({this.url,this.homeId,this.awayId});
  @override
  _MatchEventsState createState() => _MatchEventsState();
}

class _MatchEventsState extends State<MatchEvents> {
  EachMatchViewModel eachMatchViewModel;


  TextStyle headline = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 11, fontWeight: FontWeight.w600);
  TextStyle headline2 =
  TextStyle(fontFamily: 'Vazirmatn', fontSize: 13.5, color: Colors.grey);
  TextStyle content = TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 13.5,
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eachMatchViewModel = Provider.of(context, listen: false);
      eachMatchViewModel.getMatchEvent(widget.url);
      var now = DateTime.now();
      print("gooooood${eachMatchViewModel.matchDetailsModel.teamFormModel}");
      //print(now);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EachMatchViewModel>(
      builder: (context, provider, child) {
        return provider.loadingEvents || provider.matchDetailsModel == null
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
                              'من تعتقد سيفوز',
                              style: Theme.of(context).textTheme.headline2
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.only(left: 8,right: 8,top: 10,bottom: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                      },
                                      child: Container(
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.surface,
                                          borderRadius: BorderRadius.circular(50)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Image.network(
                                              "https://www.eplworld.com${provider.msnModel.homeTeamLogo}"),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.surface,
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: Icon(Icons.clear,size: 25,color: Colors.grey,),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                          width: 45,
                                          height: 45,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.surface,
                                            borderRadius: BorderRadius.circular(50)
                                        ),

                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Image.network(
                                                "https://www.eplworld.com${provider.msnModel.awayTeamLogo}"),
                                          )),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width*.25,
                                        child: Center(child: Text(provider.msnModel.homeTeamName
                                          ,style:Theme.of(context).textTheme.headline1,))),
                                    Container(
                                        width: MediaQuery.of(context).size.width*.25,
                                        child: Center(child: Text('تعادل' ,
                                          style:Theme.of(context).textTheme.headline1,))),
                                    Container(
                                        width: MediaQuery.of(context).size.width*.25,
                                        child: Center(child: Text(provider.msnModel.awayTeamName ,
                                          style:Theme.of(context).textTheme.headline1,))),
                                  ],
                                ),
                              ],
                            )
                          ),
                        ],
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
                  SizedBox(height: 5,),
                  provider.matchDetailsModel.teamFormModel.away.isBlank
                      ? Container()
                      : Container(
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
                  SizedBox(height: 5,),
                    Container(
                    width: MediaQuery.of(context).size.width,
                    child: provider.tablesModelList == null
                        ?Card(
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
                                Text(
                                  provider.matchDetailsModel.leagueName,
                                  style: TextStyle(
                                      fontFamily: 'Vazirmatn',
                                      fontWeight: FontWeight.w500),
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
                    )
                        :Container(),
                  ),
                  /*
                  SizedBox(height: 5,),
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
                              'افضل الهدافين',
                              style: Theme.of(context).textTheme.headline2
                            ),
                          ),
                          Divider(),
                          Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 68,
                                      width: 110,
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
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
                                          Positioned(
                                            bottom: 0,
                                              right: 0,
                                              child: Container(
                                            height: 25,
                                            width: 26,
                                            child: Image.network(
                                                "https://www.eplworld.com${provider.msnModel.homeTeamLogo}"),
                                          )),
                                          Positioned(
                                              top: 0,
                                              left: 35,
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
                                              child:  Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("مارسيلو",style: Theme.of(context).textTheme.bodyText1,),
                                              Text('مهاجم',style: Theme.of(context).textTheme.bodyText2,)
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 68,
                                      width: 120,
                                      child: Stack(
                                        textDirection: TextDirection.ltr,
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
                                              left:5 ,
                                              child: Container(
                                                height: 25,
                                                width: 26,
                                                child: Image.network(
                                                    "https://www.eplworld.com${provider.msnModel.awayTeamLogo}"),
                                              )),
                                          Positioned(
                                              top: 0,
                                              left: 0,
                                              child: Container(
                                                height: 13,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  color: Colors.green,
                                                ),

                                              )),
                                          Positioned(
                                              right: 0,
                                              bottom: 0,
                                              child:  Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("مارسيلو",style: Theme.of(context).textTheme.bodyText1,),
                                                  Text('مهاجم',style: Theme.of(context).textTheme.bodyText2,)
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              )
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  provider.matchDetailsModel.leagueName,
                                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14))
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListView.builder(
                                physics:
                                NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: 8,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 50,
                                    width: MediaQuery.of(context)
                                        .size
                                        .width,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 60,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 7,
                                                right: 7,
                                                top: 5,
                                                bottom: 2),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    right: 6,
                                                    left: 6,
                                                    top: 3,
                                                    bottom: 3),
                                                child: Text(
                                                  "8",
                                                    style:Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16)
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "اهداف",
                                              style:Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 15)
                                          ),
                                        ),
                                        Container(
                                          width: 60,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 7,
                                                right: 7,
                                                top: 5,
                                                bottom: 2),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    right: 6,
                                                    left: 6,
                                                    top: 3,
                                                    bottom: 3),
                                                child: Text(
                                                  "6",
                                                    style:Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16)
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),

                   */
                ]),
              );
      },
    );
  }
}
