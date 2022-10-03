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
            : Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: provider.trophiesBoxesModelList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4,top: 4),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
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
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10,bottom: 10,right: 16,left: 16),
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                provider
                                                    .trophiesBoxesModelList[index]
                                                    .name
                                                    .tr,
                                                style: Theme.of(context).textTheme.headline2,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4,bottom: 4,right: 16,left: 16),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            " الفائز  ".toString().tr,
                                            style: Theme.of(context).textTheme.bodyText1,
                                          ),
                                          Text(
                                            "${provider.trophiesBoxesModelList[index].winnerCount}",
                                            style: TextStyle(
                                                fontFamily: 'Vazirmatn',
                                                color: Colors.green),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 63, bottom: 8, top: 8,right: 16),
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
                                                 style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4,bottom: 4,right: 16,left: 16),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            " الوصيف ".toString(),
                                            style: Theme.of(context).textTheme.bodyText1,
                                          ),
                                          Text(
                                            "${provider.trophiesBoxesModelList[index].runnerCount}",
                                            style: TextStyle(
                                                fontFamily: 'Vazirmatn',
                                                color: Colors.red),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 63, bottom: 4, top: 4,right: 16),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              provider
                                                  .trophiesBoxesModelList[index]
                                                  .runner,
                                              style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                                              overflow: TextOverflow.visible,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    );
                  },
                ),
            );
      },
    );
  }
}
