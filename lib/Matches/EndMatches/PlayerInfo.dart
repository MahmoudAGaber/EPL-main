import 'package:arseli/Models/matches/EachMatch/Lineups/PlayersOutFieldModel.dart';
import 'package:arseli/Models/matches/PlayerInf.dart';
import 'package:arseli/Playrers/players.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../Provider/EachPlayerViewModel.dart';

 Route<Object> showPlayerInfo(BuildContext context, PlayerInf playerInf,String teamImage) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
              margin: EdgeInsets.all(20),
              color: Theme.of(context).colorScheme.surface,
              child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                          leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                              child: Image.network(
                                  "https://www.eplworld.com${playerInf.image}"),
                            ),
                          ),
                          title: Text(playerInf.firstName + " " + playerInf.lastName),
                          subtitle: Text(playerInf.position == null ? "" : playerInf.position),
                          trailing: InkWell(
                              onTap: () => {Navigator.pop(context)},
                              child: Icon(Icons.close,color: Theme.of(context).colorScheme.secondary,)))

                      // Row(
                      //   mainAxisSize: MainAxisSize.max,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //   Container(
                      //     width: 45,
                      //     height: 45,
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.all(Radius.circular(100)),
                      //         border: Border.all(width: 1, color: Colors.grey)),
                      //     child: ClipRRect(
                      //       borderRadius: BorderRadius.all(
                      //         Radius.circular(100),
                      //       ),
                      //       child: Image.network(
                      //           "https://www.eplworld.com/img/players/150/QlDYd8.png"),
                      //     ),
                      //   ), Column(children: [
                      //     Text("player Name",style: TextStyle(                      fontFamily: 'Vazirmatn',fontSize: 15)),
                      //     Text("Position",style: TextStyle(                      fontFamily: 'Vazirmatn',fontSize: 12))
                      //   ],),
                      //
                      //   Expanded(child: Icon(Icons.close))
                      // ],)
                      ,
                      ListView.builder(
                        itemCount: playerInf.statAPI.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, top: 10,bottom: 10),
                                alignment: Alignment.centerRight,
                                child: Text(playerInf.statAPI[index].title,
                                    style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 16)
                                ),
                              ),
                              ListView.builder(
                                itemCount: playerInf.statAPI[index].attr.length,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (context, index2) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          playerInf.statAPI[index].attr[index2].key,
                                          style: Theme.of(context).textTheme.bodyText1,
                                        ),
                                        Text(playerInf.statAPI[index].attr[index2].value,
                                        style: Theme.of(context).textTheme.bodyText1,)
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 5,),
                              Container(
                                height: 1,
                                color: Colors.black12,
                              )
                            ],
                          );
                        },
                      ),
                      InkWell(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider<
                                          EachplayerViewModel>(
                                        create: (_) => EachplayerViewModel(),
                                        child: EachPlayer(
                                          url: playerInf.url,
                                          teamImg: teamImage,
                                        ),
                                      )))
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          color: Colors.black12,
                          child: Text('تفاصيل اللاعب',style: Theme.of(context).textTheme.headline2,),
                        ),
                      )
                    ],
                  )
                ],
              )),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}

// class PlayerInfo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
