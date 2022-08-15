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

const TextStyle _textStyle = TextStyle(color: Colors.black, fontSize: 13,fontWeight: FontWeight.bold);
const TextStyle _textStyle2 = TextStyle(color: Colors.grey, fontSize: 13);

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
                              left: 45, right: 45, top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    height:25,width: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(4)
                                    ),
                                      child: Center(child: Text("السن",style: _textStyle,))),
                                  SizedBox(height: 15,),
                                  Center(
                                    child: Text(
                                      provider.piModel.dateOfBirth,
                                      style: _textStyle2,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    height:25,width: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(4)
                                    ),
                                    child: Center(
                                      child: Text(
                                        "الجنسية".tr,
                                        style: _textStyle,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [
                                      Container(
                                        width: 18,
                                        height: 18,
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
                                      SizedBox(width: 5,),
                                      Text(
                                        "${provider.piModel.nationalityLogo.split('.').first.split('/').last}",
                                        style: _textStyle2,
                                      ),
                                    ],
                                  ),


                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    height:25,width: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(4)
                                    ),
                                    child: Center(
                                      child: Text(
                                        "الطول".tr,
                                        style: _textStyle,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  Text("${provider.piModel.height} سم ".tr,style: _textStyle2,),

                                ],
                              ),


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

                      ],
                    )),
              ),
              (provider.piModel.Stats)==null
                  ?Container()
                  : Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Container(
                      height: 120,
                      child: Card(
                shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            //Text(provider.piModel.Stats.tournamentCalendarName)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, right: 25, left: 25, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                      height:25,width: 65,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      child: Center(child: Text("${provider.piModel.Stats.appearances}"))),
                                  SizedBox(height: 15,),
                                  Text(
                                    "المباريات".tr,
                                    style: _textStyle2,
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                      height:25,width: 65,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      child: Center(child: Text("${provider.piModel.Stats.goals}"))),
                                  SizedBox(height: 15,),
                                  Text(
                                    "اهداف".tr,
                                    style: _textStyle2,
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                      height:25,width: 65,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      child: Center(child: Text("${provider.piModel.Stats.assists}"))),
                                  SizedBox(height: 15,),
                                  Text(
                                    "صناعه الاهداف".tr,
                                    style: _textStyle2,
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    height: 21,
                                    width: 65,
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
                                  SizedBox(height: 15,),
                                  Text(
                                    "تقييم".tr,
                                    style: _textStyle2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                ),
              ),
                    ),
                  )
            ],
          );
        }
      ),
    );
  }
}
