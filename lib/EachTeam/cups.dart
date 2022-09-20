import 'package:arseli/Provider/EachTeamViewModel.dart';
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
  EachTeamViewModel eachTeamViewModel;
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
    return Consumer<EachTeamViewModel>(
      builder: (context, provider, child) {
        return provider.loadingTrophies
            ? Padding(
                padding: EdgeInsets.only(top: 35),
                child: Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor),
                ))
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: provider.trophiesBoxesModelList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 5, right: 5, left: 5),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        /*
                                  Container(
                                    height: 45,
                                    width: 45,
                                    child: Image.asset("assets/12.jpg"),
                                  ),

                                   */
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              provider
                                                  .trophiesBoxesModelList[index]
                                                  .name
                                                  .tr,
                                              style: TextStyle(
                                                  fontFamily: 'Vazirmatn',
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Divider(
                                      height: 20,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          " الفائز  ".toString().tr,
                                          style: TextStyle(
                                              fontFamily: 'Vazirmatn',
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "${provider.trophiesBoxesModelList[index].winnerCount}",
                                          style: TextStyle(
                                              fontFamily: 'Vazirmatn',
                                              color: Colors.green),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 63, bottom: 8, top: 8),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Text(
                                                provider
                                                    .trophiesBoxesModelList[
                                                        index]
                                                    .winner,
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          " الوصيف ".toString(),
                                          style: TextStyle(
                                              fontFamily: 'Vazirmatn',
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "${provider.trophiesBoxesModelList[index].runnerCount}",
                                          style: TextStyle(
                                              fontFamily: 'Vazirmatn',
                                              color: Colors.red),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 63, bottom: 8, top: 8),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              provider
                                                  .trophiesBoxesModelList[index]
                                                  .runner,
                                              overflow: TextOverflow.visible,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ],
                  );
                },
              );
      },
    );
  }
}
