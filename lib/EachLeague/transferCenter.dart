import 'package:arseli/Data/AppException.dart';
import 'package:arseli/Data/RequestHandler.dart';
import 'package:arseli/EachTeam/eachTeam.dart';
import 'package:arseli/Oops.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:arseli/Provider/EachLeagueViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class TransferCenter extends StatefulWidget {
  String url;
  TransferCenter({this.url});
  @override
  _TransferCenterState createState() => _TransferCenterState();
}

const TextStyle _textStyle = TextStyle(color: Colors.black54, fontSize: 13);

class _TransferCenterState extends State<TransferCenter> {
  Widget con;
  EachLeagueViewModel oneLeagueViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      try {
        oneLeagueViewModel = Provider.of(context, listen: false);
        oneLeagueViewModel.getTransfers("${widget.url}", 'transfers',);
        //print("Hiii${oneLeagueViewModel.transferBoxesModelList}");
      }catch(e){
        print(e);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer<EachLeagueViewModel>(
        builder: (context, provider, child) {
          return provider.loadingTransfers
              ?Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,),),
          )
              :ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 15, top: 10, bottom: 10),
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Text("أبرز التحويلات".tr),
                ),
              ),
              ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount:provider.transferBoxesModelList == null?0:provider.transferBoxesModelList.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/players');
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(50)),),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 20),
                                          child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(50)),
                                              child: Image.network(
                                                  "https://www.eplworld.com${provider
                                                      .transferBoxesModelList[index]
                                                      .mainIMG}")),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          width: 70,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(10),
                                              color: Colors.grey[200]
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5, left: 5),
                                            child: Center(child: Text(provider
                                                .transferBoxesModelList[index]
                                                .position)),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                              Text(provider.transferBoxesModelList[index].name
                                  .tr, style: TextStyle(fontSize: 15)),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(provider.transferBoxesModelList[index]
                                      .fromName.tr,
                                    style: TextStyle(fontSize: 14),),
                                  SizedBox(width: 5,),
                                  Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width *
                                          0.24,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 1),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                                      .fromURL,))));
                                              },
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                child:
                                                Image.network(
                                                    "https://www.eplworld.com${provider
                                                        .transferBoxesModelList[index]
                                                        .fromLogo}"),
                                              ),
                                            ),
                                            Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            100))),
                                                child: Icon(
                                                  Icons.arrow_back,
                                                  size: 15,
                                                  color: Colors.white,
                                                )),
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
                                                width: 30,
                                                height: 30,
                                                child:
                                                Image.network(
                                                    "https://www.eplworld.com${provider
                                                        .transferBoxesModelList[index]
                                                        .toLogo}"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  SizedBox(width: 5,),
                                  Text(provider.transferBoxesModelList[index]
                                      .toName.tr,
                                    style: TextStyle(fontSize: 14),),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    provider.transferBoxesModelList[index]
                                        .quickDetails.freeTransfer.tr,
                                    style: _textStyle,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Text('-'),
                                  )
                                  ,
                                  Text(
                                    provider.transferBoxesModelList[index].date
                                        .tr,
                                    style: _textStyle,
                                  ),
                                ],
                              )

                            ],
                          ),
                        ),
                      ),
                    );
                  })
            ],
          );
        },
      ),
    );
  }
}


