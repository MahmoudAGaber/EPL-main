import 'package:arseli/Provider/EachMatchViewModel.dart';
import 'package:arseli/matches.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MatchEvent_a extends StatefulWidget {
  String url;
  MatchEvent_a({this.url});
  @override
  _MatchEvent_aState createState() => _MatchEvent_aState();
}

class _MatchEvent_aState extends State<MatchEvent_a> {
  TextStyle _textStyle = TextStyle(fontWeight: FontWeight.w800, fontSize: 16);
  TextStyle _textStyle1 = TextStyle(color: Colors.grey, fontSize: 13);
  TextStyle _textStyle2 = TextStyle(color: Colors.green);
  TextStyle _textStyle3 = TextStyle(color: Colors.red);

  TextStyle head = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);
  TextStyle content = TextStyle(fontSize: 13.5);
  TextStyle content2 = TextStyle(fontSize: 13.5, color: Colors.grey);
  TextStyle content3 = TextStyle(fontSize: 12);
  TextStyle content4 = TextStyle(fontSize: 12, color: Colors.grey);
  TextStyle number = TextStyle(fontSize: 18, fontWeight: FontWeight.w400);

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
      child: Consumer<EachMatchViewModel>(
          builder: (context, provider, child) {
            return provider.loadingEventsEnd || provider.matchDetailsModel==null
                ?Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,),),
                )
                : Column(children: <Widget>[
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Card(
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(8)
                 ),
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
             ) ,

              Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child:Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('تاريخ المباراة	',style: TextStyle(fontSize: 15),),
                                        SizedBox(height: 15,),
                                        Text('البطولة',style: TextStyle(fontSize: 15),),
                                        SizedBox(height: 15,),
                                        Text('الملعب',style: TextStyle(fontSize: 15),),
                                        SizedBox(height: 15,),
                                        provider.matchDetailsModel.refreeName.isBlank
                                            ?Container()
                                            :Text('الحكم',style: TextStyle(fontSize: 15),)
                                      ],
                                    ),
                                    SizedBox(width: 50,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 3, right: 3),
                                              child: Text(
                                                provider.matchDetailsModel.date.tr,
                                                maxLines: 2,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 15,),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                )),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 3, right: 3),
                                              child: Text(
                                                provider.matchDetailsModel.leagueName.tr,
                                                maxLines: 2,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 15,),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                )),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 3, right: 3),
                                              child: Text(
                                                provider.matchDetailsModel.groundName.tr,
                                                maxLines: 2,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: 15,),
                                          provider.matchDetailsModel.refreeName.isBlank
                                              ?Container()
                                              :Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                )),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 3, right: 3),
                                              child: Text(
                                                provider.matchDetailsModel.refreeName.tr,
                                                maxLines: 2,
                                                softWrap: true,
                                              ),
                                            ),
                                          )

                                        ],),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                provider.matchDetailsModel.teamFormModel.away.isBlank
                    ?Container()
                    :Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 15, right: 10,bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[Text("المواجهات السابقة".tr)],
                            ),
                          ),
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
                                            scrollDirection: Axis.horizontal,
                                            itemCount: provider.teamFormModel.teamFormModel.home.length,
                                            itemBuilder:(context,index){
                                              return Padding(
                                                padding: const EdgeInsets.only(left: 4,right: 4,top: 8,bottom: 8),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 23,
                                                      width: 23,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(6),
                                                          color: provider.teamFormModel.teamFormModel.home[index].status == 'W'
                                                              ? Colors.green
                                                              : provider.teamFormModel.teamFormModel.home[index].status == 'L'
                                                              ? Colors.red
                                                              : provider.teamFormModel.teamFormModel.home[index].status == 'D'
                                                              ? Colors.black45
                                                              : null

                                                      ),
                                                      child: Center(child: Text(provider.teamFormModel.teamFormModel.home[index].status,
                                                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),)),
                                                    ),
                                                    SizedBox(height: 5,),
                                                    index== 0
                                                        ?Container(height: 2,width:23,color: Colors.green,)
                                                        :Container(),
                                                    SizedBox(height: 5,),
                                                    Container(
                                                      height: 25,
                                                      width: 26,
                                                      child: Image.network("https://www.eplworld.com${provider.teamFormModel.teamFormModel.home[index].teamLogo}"),
                                                    )
                                                  ],

                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                    SizedBox(width: 30,),
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                        height: 85,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: provider.teamFormModel.teamFormModel.away.length,
                                            itemBuilder:(context,index){
                                              return Padding(
                                                padding: const EdgeInsets.only(left: 4,right: 4,top: 8,bottom: 8),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 23,
                                                      width: 23,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(6),
                                                          color: provider.teamFormModel.teamFormModel.away[index].status == 'W'
                                                              ? Colors.green
                                                              : provider.teamFormModel.teamFormModel.away[index].status == 'L'
                                                              ? Colors.red
                                                              : provider.teamFormModel.teamFormModel.away[index].status == 'D'
                                                              ? Colors.black45
                                                              : null

                                                      ),
                                                      child: Center(child: Text(provider.teamFormModel.teamFormModel.away[index].status,
                                                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),)),
                                                    ),
                                                    SizedBox(height: 5,),
                                                    index==0
                                                        ?Container(height: 2,width:23,color: Colors.green,)
                                                        :Container(),
                                                    SizedBox(height: 5,),
                                                    Container(
                                                      height: 25,
                                                      width: 26,
                                                      child: Image.network("https://www.eplworld.com${provider.teamFormModel.teamFormModel.away[index].teamLogo}"),
                                                    )
                                                  ],

                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                  ])
            ]);

          })

    );
  }

  Widget _goal(String name, index) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Consumer<EachMatchViewModel>(builder: (context, provider, child) {
          return Directionality(
            textDirection: provider.eventsModel[index].linkedTo == 'home'
                ?TextDirection.ltr
                :TextDirection.rtl,
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
                      provider.eventsModel[index].details.goalMakerName.isBlank?Container(): Row(
                          children: <Widget>[
                            provider.eventsModel[index].linkedTo == 'home'
                                ?Text(
                              "${provider.eventsModel[index].details.goalMakerName} :صانع الهدف".tr,
                              style: _textStyle1,
                            )
                                :Text(
                              " صانع الهدف: ${provider.eventsModel[index].details.goalMakerName}".tr,
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

  Widget _switch(String name,index) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Consumer<EachMatchViewModel>(builder: (contex, provider, child) {
          return Directionality(
            textDirection: provider.eventsModel[index].linkedTo == 'home'
                ?TextDirection.ltr
                :TextDirection.rtl,
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
        child: Consumer<EachMatchViewModel>(builder: (context, provider, child) {
          return Directionality(
            textDirection: provider.eventsModel[index].linkedTo == 'home'
                ?TextDirection.ltr
                :TextDirection.rtl,
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
                   "(${ provider.eventsModel[index].details.outcome})".tr,
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
        child: Consumer<EachMatchViewModel>(builder: (context, provider, child) {
          return Directionality(
            textDirection: provider.eventsModel[index].linkedTo == 'home'
                ?TextDirection.ltr
                :TextDirection.rtl,
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

  Widget _yellow(String name,index) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Consumer<EachMatchViewModel>(
          builder: (context,provider,child){
            return Directionality(
              textDirection: provider.eventsModel[index].linkedTo == 'home'
                  ?TextDirection.ltr
                  :TextDirection.rtl,
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

  Widget _redCard(String name,index) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Consumer<EachMatchViewModel>(
          builder: (context,provider,child){
            return Directionality(
              textDirection: provider.eventsModel[index].linkedTo == 'home'
                  ?TextDirection.ltr
                  :TextDirection.rtl,
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
      padding: const EdgeInsets.only(top: 8,bottom: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Consumer<EachMatchViewModel>(
          builder: (context, provider, child) {
            return
                  provider.eventsModel[index].linkedTo == "home"
                   ?Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: provider.eventsModel[index].details.name == "goal"
                            ? _goal(name, index)
                            : provider.eventsModel[index].details.name == "yellowCard"
                            ? _yellow(name,index)
                            :provider.eventsModel[index].details.name == "redCard"
                            ?_redCard(name, index)
                            : provider.eventsModel[index].details.name == "substitute"
                            ? _switch(name,index)
                            :  provider.eventsModel[index].details.name == "VAR"
                            ? _var(name, index)
                            :Container()
                      ),
                    ],
                  )
                  :provider.eventsModel[index].linkedTo == "away"
                  ?Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: provider.eventsModel[index].details.name == "goal"
                              ? _goal(name, index)
                              : provider.eventsModel[index].details.name ==
                                      "yellowCard"
                                  ? _yellow(name,index)
                                  : provider.eventsModel[index].details.name ==
                                          "substitute"
                                      ? _switch(name,index)
                                      : Container(),
                        ),
                      ],
                  )
                  :Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _timerIntervals(name, index)
                    ],);
          },
        ),
      ),
    );
  }
}
