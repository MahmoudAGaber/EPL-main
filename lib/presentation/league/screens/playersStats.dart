import 'package:cached_network_image/cached_network_image.dart';
import 'package:epl/Data/StateModel.dart';
import 'package:epl/presentation/league/provider/LeagueViewModel.dart';
import 'package:epl/shared/Views/custom/custom_imageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../shared/Utils/Constants.dart';
import '../../../shared/Views/custom/custom_loader.dart';
import '../../playrers/screens/playerHome.dart';



class playersStats extends ConsumerStatefulWidget {
  String? url;
  playersStats({this.url});
  @override
  _playersStatsState createState() => _playersStatsState();
}

class _playersStatsState extends ConsumerState<playersStats> {

  TextStyle head = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 14, fontWeight: FontWeight.bold);
  TextStyle content = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 15, fontWeight: FontWeight.w500);
  TextStyle content2 =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 14, color: Colors.black);
  TextStyle number = TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 20,
  );

  List<String> icons = [
    'assets/matchsIcon.png',
    'assets/passesIcon.png',
    'assets/goalsIcon.png'
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var playerStats = ref.watch(leaguePlayerStatsProvider);

    return playerStats.handelState(
        onLoading: (state)=> CustomLoader(),
        onSuccess: (state)=> Padding(
          padding: const EdgeInsets.all(12),
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              itemCount: playerStats.data!.length,
              itemBuilder: (BuildContext context, index) {
                var item = playerStats.data![index];
                return Padding(
                  padding: const EdgeInsets.only(top: 4,bottom: 4),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 12,bottom: 12,left: 16,right: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    height: 18,width: 18,
                                    child: getIconForType(item.statsName)
                                ),
                                SizedBox(width: 10,),
                                Text(item.statsName, style: Theme.of(context).textTheme.titleMedium
                                )
                              ]),
                        ),
                        Column(
                          children: List.generate(item.statsModel.length, (innerIndex){
                            return Container(
                              decoration: BoxDecoration(
                                color: innerIndex ==0 ? Theme.of(context).primaryColor.withOpacity(.2): null,
                                border: Border(bottom: BorderSide(color: innerIndex == item.statsModel.length-1
                                    ? Colors.transparent : Colors.grey))
                              ),

                                child: innerIndex == 0
                                    ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(right: 10,left: 10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(builder: (context) => Players()));
                                                  },
                                                  child: Container(
                                                      height: 60,
                                                      width: 60,
                                                      child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(50),
                                                          child:CustomImage(imgUrl: "test.png")
                                                          //Image.network("https://www.eplworld.com")
                                                         )
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8,bottom: 12),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(item.statsModel[innerIndex].name,
                                                  style: Theme.of(context).textTheme.bodyMedium,
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(height: 20,
                                                        width: 20,
                                                        child:CustomImage(imgUrl:"${Constants.teamImage}${item.statsModel[innerIndex].teamId}.png",)
                                                  ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(item.statsModel[innerIndex].teamName,
                                                      style: Theme.of(context).textTheme.bodySmall,
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(item.statsModel[innerIndex].statistic.value,
                                              style:Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 24),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                              )
                                    : Padding(padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                          children: <Widget>[
                                          Text("${innerIndex+1}",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18)),
                                          SizedBox(width: 15,),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => Players())
                                              );
                                            },
                                            child: SizedBox(
                                                height: 40, width: 40,
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                                    child:CustomImage(imgUrl: "test.png")
                                                    //Image.network("https://www.eplworld.com",)
                                                )
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(item.statsModel[innerIndex].name,
                                                style: Theme.of(context).textTheme.bodyMedium,
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child:CustomImage(imgUrl: "${Constants.teamImage}${item.statsModel[innerIndex].teamId}.png")
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    item.statsModel[innerIndex].teamName,
                                                    style: Theme.of(context).textTheme.bodySmall,
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),

                                        ]),
                                    SizedBox(width: 25,),
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      child: Center(
                                        child: Text(item.statsModel[innerIndex].statistic.value,
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            );
                          }),
                        )
                      ,

                      ],
                    ),
                  ),
                );
              }),
        ),
        onFailure: (state)=>  Text("SHTt")
    );

  }

  Widget yellowCard(int cards){
    return Container(
      child: SizedBox(width: 25,height: 30,
        child: Stack(
            children: List.generate(cards, (index) => Positioned(
              right: index*8+2,
              top: index*4+2,
              child: Container(
                width: 13,
                height: 18,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius:
                    BorderRadius.circular(2)),
              ),
            ),)
        ),
      ),
    );
  }

  Widget redCard(){
    return Container(
      width: 16,
      height: 23,
      child: Column(
        children: [
          Container(
            width: 13,
            height: 18,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius:
                BorderRadius.circular(2)),
          ),
        ],
      ),
    );
  }

  Widget getIconForType(String type) {
    switch (type) {
      case 'appearances':
        return Icon(Icons.visibility);
      case 'assists':
        return Icon(MdiIcons.soccer);
      case 'goals':
        return Icon(Icons.sports_soccer);
      case 'minutes_played':
        return Icon(Icons.timer);
      case 'penalty_goals':
        return Icon(Icons.sports_soccer);
      case 'red_cards':
        return redCard();
      case 'second_yellow_cards':
        return yellowCard(2);
      case 'yellow_cards':
        return yellowCard(1);
      default:
        return Icon(Icons.subdirectory_arrow_left_outlined);
    }
  }
}
