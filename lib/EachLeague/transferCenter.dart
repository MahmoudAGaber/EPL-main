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

const TextStyle _textStyle =
    TextStyle(fontFamily: 'Vazirmatn', color: Colors.black54, fontSize: 13);

class _TransferCenterState extends State<TransferCenter> {
  Widget con;
  EachLeagueViewModel oneLeagueViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      try {
        oneLeagueViewModel = Provider.of(context, listen: false);
        oneLeagueViewModel.getTransfers(
          "${widget.url}",
          'transfers',
        );
        //print("Hiii${oneLeagueViewModel.transferBoxesModelList}");
      } catch (e) {
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
          return provider.transferBoxesModelList == null ||
              RequestHandler.error == 'NoData'
              ? Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: NoData(),
            ),
          )
              : Padding(
            padding: const EdgeInsets.all(8.0),
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
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, '/players');
                                              },
                                              child: Container(
                                                height: 70,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(50)),
                                                ),
                                                child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            50)),
                                                    child: Image.network(
                                                        "https://www.eplworld.com${provider.transferBoxesModelList[index].mainIMG}")),
                                              )
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10,),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(4),
                                                        color: Theme.of(context).primaryColor
                                                    ),
                                                    child:Padding(
                                                      padding: const EdgeInsets.all(1.0),
                                                      child: Text('CM',style: TextStyle(color: Colors.white,fontSize: 12),),
                                                    )
                                                ),
                                                SizedBox(width: 5,),
                                                Text(
                                                    provider.transferBoxesModelList[index].name.tr,
                                                    style: TextStyle(fontFamily: 'Vazirmatn', fontSize: 15)),
                                              ],
                                            ),
                                            SizedBox(height: 2,),
                                            Row(
                                              children: [
                                                Text('الجنسيه',style: TextStyle(color: Colors.black54),),
                                                SizedBox(width: 5,),
                                                CircleAvatar(radius: 10,)
                                              ],
                                            ),
                                            SizedBox(height: 2,),
                                            Text('القيمة السوقيه 80 مليون دولار'),
                                            SizedBox(height: 2,),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: Text(provider.transferBoxesModelList[index].sdate,
                                            style: TextStyle(color: Colors.black45),
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
                                          width: MediaQuery.of(context).size.width * 0.21,
                                          child: Text(provider.transferBoxesModelList[index].toName.tr,
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 16),),
                                        ),
                                        SizedBox(width: 5,),
                                        Container(
                                            width: MediaQuery.of(context).size.width * 0.4,
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
                                                            height: 20,
                                                            decoration: BoxDecoration(
                                                                color: Colors.green,
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        100))),
                                                            child: Icon(
                                                              Icons.arrow_forward_outlined,
                                                              size: 15,
                                                              color: Colors.white,
                                                            )),
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
                                                  Text('65 مليون دولار',style: TextStyle(color: Colors.green),)
                                                ],
                                              ),
                                            )),
                                        SizedBox(width: 5,),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.21,
                                          child: Text(provider.transferBoxesModelList[index].fromName.tr,
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(fontSize: 16),),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(provider.transferBoxesModelList[index].date,style: TextStyle(color: Colors.black54),),
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
