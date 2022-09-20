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

  TextStyle head = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 14, fontWeight: FontWeight.bold);
  TextStyle content = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 15, fontWeight: FontWeight.w500);
  TextStyle content2 =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 14, color: Colors.black);
  TextStyle number = TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 20,
  );

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
      child: Consumer<EachLeagueViewModel>(
        builder: (context, provider, child) {
          return provider.loadingPlayerStats
              ? Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    itemCount: provider.statsModel.playersModel.length ?? 0,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 4,bottom: 4),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8))),
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
                                              .secondModel
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
              );
        },
      ),
    );
  }
}
