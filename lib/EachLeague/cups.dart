import 'package:arseli/Provider/EachLeagueViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Cups extends StatefulWidget {
  String url;
  Cups({this.url});
  @override
  _CupsState createState() => _CupsState();
}

class _CupsState extends State<Cups> {
  EachLeagueViewModel eachTeamViewModel;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eachTeamViewModel = Provider.of(context, listen: false);
      eachTeamViewModel.getCups("${widget.url}/trophies");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EachLeagueViewModel>(
      builder: (context, provider, child) {
        return provider.loadingCups
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
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: provider.trophiesBoxesModelList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4,top: 4),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 14,bottom: 7,right: 18,left: 18),
                                    child: Text(
                                      provider.trophiesBoxesModelList[index].CalendarYear,
                                      style: Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 15,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                        children: [
                                          SizedBox(width: 10,),
                                          Container(
                                            child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.network(
                                              'https://www.eplworld.com${provider.trophiesBoxesModelList[index].winnerLogo}',
                                              fit: BoxFit.fill,
                                              height: 45,
                                              width: 45,
                                            )),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          /*
                                          Text(
                                            provider.trophiesBoxesModelList[index]
                                                .winnerName,
                                            style: TextStyle(
                                                fontFamily: 'Vazirmatn',
                                                fontSize: 17),
                                          ),

                                           */
                                          Text(
                                            "الفائز",
                                            style: Theme.of(context).textTheme.headline2
                                          )
                                        ],
                                      )
                                    ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                                    child: Divider(),
                                  ),
                                  provider.trophiesBoxesModelList[index]
                                          .runnerUpName.isEmpty
                                      ? Container()
                                      : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(children: [
                                          SizedBox(width: 10,),
                                            Container(
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Image.network(
                                                    'https://www.eplworld.com${provider.trophiesBoxesModelList[index].runnerUplogo}',
                                                    fit: BoxFit.cover,
                                                    height: 45,
                                                    width: 45,
                                                  )),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                /*
                                                Text(
                                                  provider
                                                      .trophiesBoxesModelList[
                                                          index]
                                                      .runnerUpName,
                                                  style: TextStyle(
                                                      fontFamily: 'Vazirmatn',
                                                      fontSize: 17),
                                                ),

                                                 */
                                                Text(
                                                  "المركز الثاني",
                                                  style: Theme.of(context).textTheme.headline2
                                                ),
                                              ],
                                            )
                                          ]),
                                      ),
                                  SizedBox(height: 10,)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
            );
      },
    );
  }
}
