import 'package:epl/Data/StateModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../shared/Utils/Constants.dart';
import '../../../shared/Views/custom/custom_loader.dart';
import '../../../shared/helper/countryShortName.dart';
import '../provider/PlayerViewModel.dart';

class PlayerProfile extends ConsumerStatefulWidget {
  String? url;
  String? teamImg;
  PlayerProfile({this.url, this.teamImg});
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

class _profileState extends ConsumerState<PlayerProfile> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    }); //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var player = ref.watch(PlayerProvider);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: player.handelState(
        onLoading: (state)=> CustomLoader(),
        onFailure: (state)=> Text("Shit"),
        onSuccess: (state)=> Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 4),
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
                          Text("dasdsa",style: Theme.of(context).textTheme.bodyMedium)
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
                                          "ddd", style:Theme.of(context).textTheme.bodyMedium))),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                  "المباريات".tr,
                                  style:Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14)
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
                                          "", style:Theme.of(context).textTheme.bodyMedium))),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                  "اهداف".tr,
                                  style:Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14)
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
                                          "", style:Theme.of(context).textTheme.bodyMedium))),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                  "صناعه الاهداف".tr,
                                  style:Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14)
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
                                        "",
                                        style:Theme.of(context).textTheme.bodyMedium
                                    )),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                  "تقييم".tr,
                                  style:Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14)
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
                        padding: const EdgeInsets.only(left: 45, right: 45, top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                    decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                          child: Text(player.data!.person.dateOfBirth,
                                            style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                                          ),
                                        ))),
                                SizedBox(
                                  height: 8,
                                ),
                                Center(
                                  child: Text("مواليد",
                                      style:Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14)
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                      borderRadius:
                                      BorderRadius.circular(4)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 18,
                                            height: 18,
                                            child:Image.network(
                                              "${Constants.countryImage}${CountryShortName.country["${player.data!.person.nationalityId}"]}.png",
                                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                                return CircleAvatar(backgroundColor: Colors.grey,);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(player.data!.person.nationality,
                                              style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    "الجنسية".tr,
                                    style:Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14)
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  width: 80,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                        BorderRadius.circular(4)),
                                    child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                          child: Text(player.data!.person.foot!,
                                              style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)
                                          ),
                                        ))),
                                SizedBox(
                                  height: 8,
                                ),
                                Center(
                                  child: Text(
                                      "القدم المفضله",
                                      style:Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14)
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                      BorderRadius.circular(4)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                      child: Text(
                                          "cm ${player.data!.person.height}".tr,
                                          style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    "الطول".tr,
                                    style:Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14)
                                ),

                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                      BorderRadius.circular(4)),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                          child: Text(player.data!.person.weight!,
                                              style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    "الوزن".tr,
                                    style:Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14)
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

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
                            Text('المركز',style: Theme.of(context).textTheme.bodyMedium)
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
                                            color: Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.all(Radius.circular(50)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(Radius.circular(50),
                                              ),
                                              child: CircleAvatar(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          left: -10,bottom: 15,
                                          child:  Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("CMF",style: Theme.of(context).textTheme.bodyMedium),
                                              Row(
                                                children: [
                                                  Text('المركز الاساسي',style: Theme.of(context).textTheme.bodySmall),
                                                  SizedBox(width: 3,),
                                                  Text(player.data!.person.position,style: TextStyle(color: Colors.green,fontSize: 12.5),)
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
        ),
      )

    );
  }
}
