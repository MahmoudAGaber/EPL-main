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
  profile({this.url, this.teamImg});
  @override
  _profileState createState() => _profileState();
}

const TextStyle _textStyle = TextStyle(
    fontFamily: 'Vazirmatn',
    color: Colors.black,
    fontSize: 13,
    fontWeight: FontWeight.w500);
const TextStyle _textStyle2 =
    TextStyle(fontFamily: 'Vazirmatn', color: Colors.grey, fontSize: 13);

class _profileState extends State<profile> {
  EachplayerViewModel eachplayerViewModel;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eachplayerViewModel = Provider.of(context, listen: false);
      eachplayerViewModel.getProfile(widget.url);
    }); //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Consumer<EachplayerViewModel>(builder: (context, provider, child) {
        return provider.loadingPlayer
            ? Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            : Column(
                children: <Widget>[
                  (provider.piModel.Stats) == null
                      ? Container()
                      : Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Container(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  //CircleAvatar(radius: 10,),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(provider.piModel.Stats.competitionName,style: Theme.of(context).textTheme.headline2)
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15,
                                  right: 25,
                                  left: 25,
                                  bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                          height: 25,
                                          width: 65,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.onPrimary,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  4)),
                                          child: Center(
                                              child: Text(
                                                  "${provider.piModel.Stats.appearances}", style:Theme.of(context).textTheme.bodyText1))),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "المباريات".tr,
                                          style:Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14)
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                          height: 25,
                                          width: 65,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.onPrimary,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  4)),
                                          child: Center(
                                              child: Text(
                                                  "${provider.piModel.Stats.goals}", style:Theme.of(context).textTheme.bodyText1))),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "اهداف".tr,
                                          style:Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14)
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                          height: 25,
                                          width: 65,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.onPrimary,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  4)),
                                          child: Center(
                                              child: Text(
                                                  "${provider.piModel.Stats.assists}", style:Theme.of(context).textTheme.bodyText1))),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "صناعه الاهداف".tr,
                                          style:Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14)
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
                                            BorderRadius.all(
                                                Radius.circular(4))),
                                        child: Center(
                                            child: Text(
                                              "${provider.piModel.Stats.rank}",
                                                style:Theme.of(context).textTheme.bodyText1
                                            )),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "تقييم".tr,
                                          style:Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14)
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
                  ),
                  SizedBox(height: 8,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 45, right: 45, top: 20, bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                          height: 25,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.onPrimary,
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Center(
                                              child: Text(
                                            provider.piModel.age.toString(),
                                                  style:Theme.of(context).textTheme.bodyText1,
                                          ))),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Center(
                                        child: Text(
                                          provider.piModel.dateOfBirth,
                                            style:Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14)
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        height: 25,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.onPrimary,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 18,
                                                height: 18,
                                                child: provider
                                                    .piModel.nationalityLogo
                                                    .endsWith('svg')
                                                    ? ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      50),
                                                  child: SvgPicture.network(
                                                    "https://www.eplworld.com${provider.piModel.nationalityLogo}",
                                                    semanticsLabel:
                                                    'Acme Logo',
                                                    fit: BoxFit.fill,
                                                  ),
                                                )
                                                    : Image.network(
                                                    "https://www.eplworld.com${provider.piModel.nationalityLogo}"),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "${provider.piModel.nationalityLogo.split('.').first.split('/').last}",
                                                  style:Theme.of(context).textTheme.bodyText1
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "الجنسية".tr,
                                          style:Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14)
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        height: 25,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.onPrimary,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Center(
                                          child: Text(
                                            "${provider.piModel.height} cm ".tr,
                                              style:Theme.of(context).textTheme.bodyText1
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "الطول".tr,
                                          style:Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14)
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 45, right: 45, top: 15, bottom: 15),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                          height: 25,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.onPrimary,
                                              borderRadius:
                                              BorderRadius.circular(4)),
                                          child: Center(
                                              child: Text(
                                                provider.piModel.foot == null?'':provider.piModel.foot.toString(),
                                                  style:Theme.of(context).textTheme.bodyText1
                                              ))),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Center(
                                        child: Text(
                                         "القدم المفضله",
                                            style:Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14)
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        height: 25,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.onPrimary,
                                            borderRadius:
                                            BorderRadius.circular(4)),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('?'),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "${provider.piModel.nationalityLogo.split('.').first.split('/').last}",
                                                  style:Theme.of(context).textTheme.bodyText1
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "القميص".tr,
                                          style:Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14)
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        height: 25,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.onPrimary,
                                            borderRadius:
                                            BorderRadius.circular(4)),
                                        child: Center(
                                          child: Text(
                                            "\$".tr,
                                              style:Theme.of(context).textTheme.bodyText1
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "القيمه السوقيه".tr,
                                        style:Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14)
                                      ),

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
                  SizedBox(height: 8,),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Container(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text('المركز',style: Theme.of(context).textTheme.headline2)
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 210,
                                        child: Stack(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(),
                                              child: Container(
                                                width: 70,
                                                height: 70,
                                                decoration:
                                                BoxDecoration(
                                                  color: Theme.of(context).colorScheme.onPrimary,
                                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(6.0),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.all(Radius.circular(50),
                                                    ),
                                                    child: Image.network("https://www.eplworld.com${provider.headerProfileModel.logo}"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child:widget.teamImg == null
                                                    ? Container()
                                                    : Container(
                                                  height: 22,
                                                  width: 22,
                                                  child: Image.network(
                                                      "https://www.eplworld.com${widget.teamImg}"),
                                                ),),
                                            Positioned(
                                                left: 0,bottom: 15,
                                                child:  Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(provider.headerProfileModel.name,style: Theme.of(context).textTheme.bodyText1),
                                                    Row(
                                                      children: [
                                                        Text('المركز الاساسي',style: Theme.of(context).textTheme.bodyText2),
                                                        SizedBox(width: 3,),
                                                        Text(provider.piModel.position,style: TextStyle(color: Colors.green,fontSize: 12.5),)
                                                      ],
                                                    )

                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  /*
                                  Row(
                                    children: [
                                      Text('يمكنه ايضا اللعب ',style: TextStyle(color: Colors.black45),),
                                      Text('RAM/CAM',style: TextStyle(fontWeight: FontWeight.bold),)
                                    ],
                                  )

                                   */

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
      }),
    );
  }
}
