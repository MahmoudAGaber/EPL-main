import 'package:arseli/Provider/EachPlayerViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class profile extends StatefulWidget {
  String url;
  String teamImg;
  profile({this.url,this.teamImg});
  @override
  _profileState createState() => _profileState();
}

const TextStyle _textStyle = TextStyle(color: Colors.grey, fontSize: 13);

class _profileState extends State<profile> {

  EachplayerViewModel eachplayerViewModel;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eachplayerViewModel = Provider.of(context,listen: false);
      eachplayerViewModel.getProfile(widget.url);
    });//
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<EachplayerViewModel>(
        builder:(context,provider,child){
          return provider.loadingPlayer?
              Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),),
              )
              :Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 45, right: 45, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text("${provider.piModel.height} سم ".tr),
                                  Text(
                                    "الطول".tr,
                                    style: _textStyle,
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(" ${provider.piModel.age} سنة".tr),
                                  Text(
                                  provider.piModel.dateOfBirth,
                                    style: _textStyle,
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        child:
                                        provider.piModel.nationalityLogo.endsWith('svg')
                                            ? ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                              child: SvgPicture.network(
                                          "https://www.eplworld.com${provider.piModel.nationalityLogo}",semanticsLabel: 'Acme Logo',fit: BoxFit.fill,),
                                            )
                                            : Image.network(
                                            "https://www.eplworld.com${ provider.piModel.nationalityLogo}"),
                                      ),
                                      SizedBox(width: 4,),
                                      Text(
                                        "${provider.piModel.nationalityLogo.split('.').first.split('/').last}",
                                        style: TextStyle(),
                                      ),
                                    ],
                                  ),

                                  Text(
                                    "الدولة".tr,
                                    style: _textStyle,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        /*
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 70, right: 45, top: 5, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text("-"),
                                  Text(
                                    "قميص".tr,
                                    style: _textStyle,
                                  ),
                                ],
                              ),
                              /*
                              Column(
                                children: <Widget>[
                                  Text("الف840".tr),
                                  Text(
                                    "القيمة السوقية".tr,
                                    style: _textStyle,
                                  ),
                                ],
                              ),

                               */
                              Column(
                                children: <Widget>[],
                              )
                            ],
                          ),
                        ),

                         */
                        Divider(
                          height: 15,
                        ),

                        (provider.piModel.Stats)==null
                        ?Container()
                        : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ),
                                Text(provider.piModel.Stats.tournamentCalendarName)
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, right: 40, left: 40, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text("${provider.piModel.Stats.appearances}"),
                                      Text(
                                        "المباريات".tr,
                                        style: _textStyle,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                        Text("${provider.piModel.Stats.goals}"),
                                      Text(
                                        "اهداف".tr,
                                        style: _textStyle,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text("${provider.piModel.Stats.assists}"),
                                      Text(
                                        "صناعه الاهداف".tr,
                                        style: _textStyle,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        height: 21,
                                        width: 38,
                                        decoration: BoxDecoration(
                                            color: Colors.green[400],
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(4))),
                                        child: Center(
                                            child: Text(
                                              "${provider.piModel.Stats.rank}",
                                              style: TextStyle(color: Colors.white),
                                            )),
                                      ),
                                      Text(
                                        "تقييم".tr,
                                        style: _textStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                            )

                      ],
                    )),
              ),
            ],
          );
        }
      ),
    );
  }
}
