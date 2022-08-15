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
  TextStyle head = TextStyle(fontSize: 13.5);
  TextStyle content = TextStyle(fontSize: 15);
  TextStyle content2 = TextStyle(fontSize: 13.5, color: Colors.grey);
  TextStyle number = TextStyle(
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
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Consumer<EachLeagueViewModel>(
          builder: (context,provider,child){
            return provider.loadingTeamStats
                ?Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,),),
                )
                : ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                itemCount: provider.teamsModel.length,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                    child: Card(
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[100],
                            height: 130,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder:(context)=>  ChangeNotifierProvider<EachTeamViewModel>(
                                            create: (_) => EachTeamViewModel(),
                                            child: EachTeam(
                                              url: provider.teamsModel[index].firstModel.URL,)
                                        ))
                                );
                              },
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
                                              provider.teamsModel[index].title,
                                              style: head,
                                            )
                                          ]),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(provider.teamsModel[index].firstModel.name,
                                              style: content),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                provider.teamsModel[index].firstModel.number,
                                                style: number,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 20),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                              height: 55,
                                              width: 55,
                                              child: Image.network("https://www.eplworld.com${provider.teamsModel[index].firstModel.IMG}"))
                                        ],
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 20, bottom: 13),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder:(context)=>  ChangeNotifierProvider<EachTeamViewModel>(
                                            create: (_) => EachTeamViewModel(),
                                            child: EachTeam(
                                              url:provider.teamsModel[index].secondModel.URL)
                                        ))
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Container(
                                      height: 25,
                                      width: 25,
                                      child: Image.network("https://www.eplworld.com${provider.teamsModel[index].secondModel.IMG}"),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(provider.teamsModel[index].secondModel.name)
                                  ]),
                                  Text(
                                    provider.teamsModel[index].secondModel.number,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder:(context)=>  ChangeNotifierProvider<EachTeamViewModel>(
                                            create: (_) => EachTeamViewModel(),
                                            child: EachTeam(
                                              url: provider.teamsModel[index].thirdModel.URL,)
                                        ))
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Container(
                                      height: 25,
                                      width: 25,
                                      child: Image.network("https://www.eplworld.com${provider.teamsModel[index].thirdModel.IMG}"),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(provider.teamsModel[index].thirdModel.name)
                                  ]),
                                  Text(
                                    provider.teamsModel[index].thirdModel.number,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
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
