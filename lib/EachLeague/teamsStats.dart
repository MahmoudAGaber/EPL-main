import 'package:arseli/EachTeam/eachTeam.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:arseli/Provider/EachLeagueViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class teamsStats extends StatefulWidget {
  String url;
  teamsStats({this.url});
  @override
  _teamsStatsState createState() => _teamsStatsState();
}

class _teamsStatsState extends State<teamsStats> {
  EachLeagueViewModel oneLeagueViewModel;
  TextStyle head = TextStyle(fontFamily: 'Vazirmatn', fontSize: 13.5);
  TextStyle content = TextStyle(fontFamily: 'Vazirmatn', fontSize: 15);
  TextStyle content2 =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 13.5, color: Colors.grey);
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
          return provider.loadingTeamStats
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
                itemCount: provider.statsModel.teamsModel.length ?? 0,
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
                                provider.statsModel.teamsModel[index].title.tr,
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
                                    Row(
                                      children: [
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
                                                                  EachTeamViewModel>(
                                                                create: (_) =>
                                                                    EachTeamViewModel(),
                                                                child:
                                                                EachTeam(
                                                                  url: provider.statsModel.teamsModel[index].firstModel.URL,
                                                                  //teamImg: provider.statsModel.playersModel[index].firstModel.teamLogo,
                                                                ),
                                                              )));
                                                },
                                                child: Container(
                                                    height: 55,
                                                    width: 55,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                        child: Image
                                                            .network(
                                                            "https://www.eplworld.com${provider.statsModel.teamsModel[index].firstModel.IMG}"))
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10,),
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
                                                provider.statsModel.teamsModel[index].firstModel.name.tr,
                                                style: content,
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
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
                                Row(
                                    children: <Widget>[
                                      Text('2',style: TextStyle(fontSize: 18,color: Colors.black38),),
                                      SizedBox(width: 15,),
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
                                                        child:
                                                        EachTeam(
                                                          url: provider
                                                              .statsModel
                                                              .teamsModel[index]
                                                              .secondModel
                                                              .URL,
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
                                                  "https://www.eplworld.com${provider.statsModel.teamsModel[index].secondModel.IMG}",
                                                ))),
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
                                          .teamsModel[index]
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
                                Row(
                                    children: <Widget>[
                                      Text('3',style: TextStyle(fontSize: 18,color: Colors.black38),),
                                      SizedBox(width: 15,),
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
                                                        child:
                                                        EachTeam(
                                                          url: provider
                                                              .statsModel
                                                              .teamsModel[index]
                                                              .thirdModel
                                                              .URL,
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
                                                  "https://www.eplworld.com${provider.statsModel.teamsModel[index].thirdModel.IMG}",
                                                ))),
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
                                          .teamsModel[index]
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
