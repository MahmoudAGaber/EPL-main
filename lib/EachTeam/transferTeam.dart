import 'package:arseli/Data/RequestHandler.dart';
import 'package:arseli/Playrers/players.dart';
import 'package:arseli/Provider/EachPlayerViewModel.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../trendingData.dart';
import 'eachTeam.dart';

class tranferTeam extends StatefulWidget {
  String url;
  tranferTeam({this.url});
  @override
  _tranferTeamState createState() => _tranferTeamState();
}

class _tranferTeamState extends State<tranferTeam> {
  TextStyle _textStyle =
      TextStyle(fontFamily: 'Vazirmatn', color: Colors.black54, fontSize: 13);
  EachTeamViewModel eachTeamViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eachTeamViewModel = Provider.of(context, listen: false);
      eachTeamViewModel.getTransfers("${widget.url}", 'transfers', context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer<EachTeamViewModel>(
        builder: (context, provider, child) {
          return provider.transferBoxesModelList == null ||
              RequestHandler.error == 'NoData'
              ? Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: NoData(),
            ),
          )
              : Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: provider.transferBoxesModelList.length,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => ChangeNotifierProvider<EachplayerViewModel>(
                                                                create: (_) => EachplayerViewModel(),
                                                                child: EachPlayer(
                                                                  url: provider.transferBoxesModelList[index].link,
                                                                )
                                                            )));
                                                  },
                                                  child: Container(
                                                    height: 48,
                                                    width: 48,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.all(Radius.circular(50)),
                                                    ),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.all(Radius.circular(50)),
                                                        child: Image.network(
                                                            "https://www.eplworld.com${provider.transferBoxesModelList[index].mainIMG}")),
                                                  )
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 10,),

                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(4),
                                                        color: Theme.of(context).primaryColor
                                                    ),
                                                    /*
                                                  child:Padding(
                                                    padding: const EdgeInsets.all(1.0),
                                                    child: Text('CM',style: TextStyle(color: Colors.white,fontSize: 12),),
                                                  )

                                                   */
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Text(
                                                      provider.transferBoxesModelList[index].name.tr,
                                                      style: Theme.of(context).textTheme.bodyText1
                                                  ),
                                                ],
                                              ),
                                              /*
                                          SizedBox(height: 2,),
                                          Row(
                                            children: [
                                              Text('الجنسيه',style: TextStyle(color: Colors.black54),),
                                              SizedBox(width: 5,),
                                              //CircleAvatar(radius: 10,)
                                            ],
                                          ),


                                          SizedBox(height: 2,),
                                          Text('القيمة السوقيه 80 مليون دولار'),
                                          SizedBox(height: 2,),

                                           */
                                            ],
                                          ),
                                        ],
                                      ),

                                      Expanded(
                                          child: Text(provider.transferBoxesModelList[index].sdate,
                                            style:Theme.of(context).textTheme.subtitle2,
                                            textAlign: TextAlign.left,))

                                    ],
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                            width: MediaQuery.of(context).size.width * 0.2,
                                            child: Text(provider.transferBoxesModelList[index].toName.tr,
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.left,
                                              style:Theme.of(context).textTheme.bodyText1,
                                            )
                                        ),
                                        SizedBox(width: 5,),
                                        Container(
                                            width: MediaQuery.of(context).size.width * 0.39,
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom: 1),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ChangeNotifierProvider<
                                                                          EachTeamViewModel>(
                                                                          create: (_) =>
                                                                              EachTeamViewModel(),
                                                                          child: EachTeam(
                                                                            url: provider
                                                                                .transferBoxesModelList[index]
                                                                                .toURL,))));
                                                        },
                                                        child: Container(
                                                          width: 35,
                                                          height: 35,
                                                          child:
                                                          Image.network(
                                                              "https://www.eplworld.com${provider
                                                                  .transferBoxesModelList[index]
                                                                  .toLogo}"),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 15,right: 15),
                                                        child: Container(
                                                            width: 40,
                                                            height: 16,
                                                            decoration: BoxDecoration(
                                                                color: Color(0xFF42c713),
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        100))),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(3.0),
                                                              child: Container(
                                                                  height: 10,width: 25,
                                                                  child: RotatedBox(
                                                                      quarterTurns: 2,
                                                                      child: Image.asset('assets/arrow.png',fit: BoxFit.contain,))),
                                                            )
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ChangeNotifierProvider<
                                                                          EachTeamViewModel>(
                                                                          create: (_) =>
                                                                              EachTeamViewModel(),
                                                                          child: EachTeam(
                                                                            url: provider
                                                                                .transferBoxesModelList[index]
                                                                                .fromURL,))));
                                                        },
                                                        child: Container(
                                                          width: 35,
                                                          height: 35,
                                                          child:
                                                          Image.network(
                                                              "https://www.eplworld.com${provider
                                                                  .transferBoxesModelList[index]
                                                                  .fromLogo}"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10,),
                                                  // Text('65 مليون دولار',style: TextStyle(color: Colors.green),)
                                                ],
                                              ),
                                            )),
                                        SizedBox(width: 5,),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.21,
                                          child: Text(provider.transferBoxesModelList[index].fromName.tr,
                                            textDirection: TextDirection.rtl,
                                            style:Theme.of(context).textTheme.bodyText1,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(provider.transferBoxesModelList[index].date,
                                      style:Theme.of(context).textTheme.bodyText1,),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}
