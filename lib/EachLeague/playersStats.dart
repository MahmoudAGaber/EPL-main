
import 'package:arseli/Playrers/players.dart';
import 'package:arseli/Provider/EachPlayerViewModel.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:arseli/Provider/EachLeagueViewModel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class playersStats extends StatefulWidget {
  String url;
  playersStats({this.url});
  @override
  _playersStatsState createState() => _playersStatsState();
}

class _playersStatsState extends State<playersStats> {

  EachLeagueViewModel oneLeagueViewModel;

  TextStyle head = TextStyle(fontSize: 14,fontWeight: FontWeight.bold);
  TextStyle content = TextStyle(fontSize: 15,fontWeight: FontWeight.w500);
  TextStyle content2 = TextStyle(fontSize: 14, color: Colors.black);
  TextStyle number = TextStyle(fontSize: 20,);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      oneLeagueViewModel = Provider.of(context, listen: false);
      oneLeagueViewModel.getPlayersStats("${widget.url}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Consumer<EachLeagueViewModel>(
          builder: (context,provider,child){
            return provider.loadingPlayerStats
                ?Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,),),
            )
                :ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                itemCount: provider.playersModel.length??0,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                    child: Card(
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: Colors.grey[100],
                            height: 130,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 5, right: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(children: <Widget>[
                                          Text(
                                            provider.playersModel[index].title.tr,
                                            style: head,
                                          )
                                        ]),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          provider.playersModel[index].firstModel.name.tr,
                                          style: content,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 28,
                                              width: 28,
                                              child: Image.network("https://www.eplworld.com${provider.playersModel[index].firstModel.teamLogo}"),
                                            ),
                                            SizedBox(width: 5,),
                                            Text(
                                              provider.playersModel[index].firstModel.teamName.tr,
                                              style: content2,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              provider.playersModel[index].firstModel.number,
                                              style: number,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context)=> ChangeNotifierProvider<EachplayerViewModel>(
                                                  create: (_)=>EachplayerViewModel(),
                                                  child: EachPlayer(
                                                    url:  provider.playersModel[index].firstModel.URL,
                                                    teamImg:  provider.playersModel[index].firstModel.teamLogo,),
                                                )));
                                          },
                                          child: Container(
                                              height: 60,
                                              width: 60,
                                              child:
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(50),
                                                  child: Image.network("https://www.eplworld.com${provider.playersModel[index].firstModel.IMG}"))),
                                        )
                                      ],
                                    ),
                                  )
                                ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 20, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context)=> ChangeNotifierProvider<EachplayerViewModel>(
                                            create: (_)=>EachplayerViewModel(),
                                            child: EachPlayer(
                                              url:  provider.playersModel[index].secondModel.URL,
                                              teamImg:  provider.playersModel[index].secondModel.teamLogo,),
                                          )));
                                    },
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100)),
                                            child: Image.network(
                                              "https://www.eplworld.com${provider.playersModel[index].secondModel.IMG}",
                                            ))),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(provider.playersModel[index].secondModel.name)
                                ]),
                                Text(
                                  provider.playersModel[index].secondModel.number,
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context)=> ChangeNotifierProvider<EachplayerViewModel>(
                                            create: (_)=>EachplayerViewModel(),
                                            child: EachPlayer(
                                              url:  provider.playersModel[index].thirdModel.URL,
                                              teamImg:  provider.playersModel[index].thirdModel.teamLogo,),
                                          )));
                                    },
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100)),
                                            child: Image.network(
                                              "https://www.eplworld.com${provider.playersModel[index].thirdModel.IMG}",
                                            ))),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(provider.playersModel[index].thirdModel.name.tr)
                                ]),
                                Text(
                                  provider.playersModel[index].thirdModel.number,
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          /*
                          Divider(
                            height: 2,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 8, bottom: 8, right: 15),
                            child: GestureDetector(
                                onTap: () {},
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "عرض الكل".tr,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                    )
                                  ],
                                )),
                          )


                           */

                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
