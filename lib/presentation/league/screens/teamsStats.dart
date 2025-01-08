import 'package:epl/Data/StateModel.dart';
import 'package:epl/presentation/league/provider/LeagueViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/Views/custom/custom_loader.dart';
import '../../playrers/screens/players.dart';


class TeamState extends ConsumerStatefulWidget {
  String? url;
  TeamState({this.url});
  @override
  _playersStatsState createState() => _playersStatsState();
}

class _playersStatsState extends ConsumerState<TeamState> {



  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var playerStats = ref.watch(PlayerStatsProvider);

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
                                    child: Icon(getIconForType(item.statsName))
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
                                height: 100,
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
                                                          child: CircleAvatar()
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
                                                    Container(
                                                        height: 20,
                                                        width: 20,
                                                        child: CircleAvatar()
                                                      //Image.network("https://www.eplworld.com"),
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
                                    : Padding(padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 8),
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
                                                      child:CircleAvatar()
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
                                                  children: [
                                                    SizedBox(height: 16, width: 16, child: CircleAvatar()
                                                      //Image.network("https://www.eplworld.com"),
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
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.onPrimary,
                                            borderRadius: BorderRadius.circular(4)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),

                                          child: Text(item.statsModel[innerIndex].statistic.value,
                                              style: Theme.of(context).textTheme.bodyMedium
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
  IconData getIconForType(String type) {
    switch (type) {
      case 'appearances':
        return Icons.visibility;
      case 'assists':
        return Icons.handshake;
      case 'goals':
        return Icons.sports_soccer;
      case 'minutes_played':
        return Icons.timer;
      case 'penalty_goals':
        return Icons.gavel;
      case 'red_cards':
        return Icons.warning;
      case 'second_yellow_cards':
        return Icons.repeat;
      case 'yellow_cards':
        return Icons.warning_amber;
      default:
        return Icons.help;
    }
  }
}
