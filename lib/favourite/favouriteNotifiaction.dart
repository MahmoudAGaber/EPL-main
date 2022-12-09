import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../Provider/favouriteViewModel.dart';

class FavouriteNotification extends StatefulWidget {
  @override
  _FavouriteNotificationState createState() => _FavouriteNotificationState();
}

class _FavouriteNotificationState extends State<FavouriteNotification> {

  FavouriteViewModel favouriteViewModel;
  bool light = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      favouriteViewModel = Provider.of(context, listen: false);

      favouriteViewModel.getAllFavouriteItems("favouritesList");
      favouriteViewModel.getTeamsItems("teamsList");
      favouriteViewModel.getAllLeaguesItems("leaguesList");
      favouriteViewModel.getAllPlayersItems("playersList");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Consumer<FavouriteViewModel>(
          builder: (context,provider,child){
            return Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("اختر كل الفرق",style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 14),),
                            Switch(
                              value: light,
                              activeColor:  Color(0xFF77109B),
                              onChanged: (bool value) {
                                setState(() {
                                  light = value;
                                });
                              },
                            )
                          ],
                        ),
                        Divider(height: 0,),
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: provider.teamsModelList.length,
                          itemBuilder: (context,index){
                            return  Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            height: 30,width: 30,
                                            child: provider.teamsModelList[index].image.endsWith('svg')
                                                ? SvgPicture.network(
                                                "https://www.eplworld.com${provider.teamsModelList[index].image}",
                                                semanticsLabel:
                                                'Acme Logo')
                                                : ClipRRect(
                                              borderRadius: BorderRadius.circular(50),
                                              child: Image.network(provider.teamsModelList[index].image.endsWith('small')
                                                  ? "${provider.teamsModelList[index].image.split('?').first}.jpg"
                                                  : "https://www.eplworld.com${provider.teamsModelList[index].image}"),
                                            )
                                        ),
                                        SizedBox(width: 8,),
                                        Text(provider.teamsModelList[index].text,style: Theme.of(context).textTheme.bodyText1)
                                      ],
                                    ),
                                    Switch(
                                      value: light,
                                      activeColor:  Color(0xFF77109B),
                                      onChanged: (bool value) {
                                        setState(() {
                                          light = value;
                                        });
                                      },
                                    )
                                  ],
                                ),
                                Divider(height: 0,),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("اختر كل البطولات",style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 14),),
                            Switch(
                              value: light,
                              activeColor:  Color(0xFF77109B),
                              onChanged: (bool value) {
                                setState(() {
                                  light = value;
                                });
                              },
                            )
                          ],
                        ),
                        Divider(height: 0,),
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: provider.leaguesiteModelList.length,
                          itemBuilder: (context,index){
                            return  Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            height: 30,width: 30,
                                            child: provider.leaguesiteModelList[index].image.endsWith('svg')
                                                ? SvgPicture.network(
                                                "https://www.eplworld.com${provider.leaguesiteModelList[index].image}",
                                                semanticsLabel:
                                                'Acme Logo')
                                                : ClipRRect(
                                              borderRadius: BorderRadius.circular(50),
                                              child: Image.network(provider.leaguesiteModelList[index].image.endsWith('small')
                                                  ? "${provider.leaguesiteModelList[index].image.split('?').first}.jpg"
                                                  : "https://www.eplworld.com${provider.leaguesiteModelList[index].image}"),
                                            )
                                        ),
                                        SizedBox(width: 8,),
                                        Text(provider.leaguesiteModelList[index].text,style: Theme.of(context).textTheme.bodyText1)
                                      ],
                                    ),
                                    Switch(
                                      value: light,
                                      activeColor:  Color(0xFF77109B),
                                      onChanged: (bool value) {
                                        setState(() {
                                          light = value;
                                        });
                                      },
                                    )
                                  ],
                                ),
                                Divider(height: 0,),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("اختر كل اللاعيبين",style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 14),),
                            Switch(
                              value: light,
                              activeColor:  Color(0xFF77109B),
                              onChanged: (bool value) {
                                setState(() {
                                  light = value;
                                });
                              },
                            )
                          ],
                        ),

                        Divider(height: 0,),

                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: provider.playerModelList.length,
                          itemBuilder: (context,index){
                            return  Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            height: 30,width: 30,
                                            child: provider.playerModelList[index].image.endsWith('svg')
                                                ? SvgPicture.network(
                                                "https://www.eplworld.com${provider.playerModelList[index].image}",
                                                semanticsLabel:
                                                'Acme Logo')
                                                : ClipRRect(
                                              borderRadius: BorderRadius.circular(50),
                                              child: Image.network(provider.playerModelList[index].image.endsWith('small')
                                                  ? "${provider.playerModelList[index].image.split('?').first}.jpg"
                                                  : "https://www.eplworld.com${provider.playerModelList[index].image}"),
                                            )
                                        ),
                                        SizedBox(width: 8,),
                                        Text(provider.playerModelList[index].text,style: Theme.of(context).textTheme.bodyText1)
                                      ],
                                    ),
                                    Switch(
                                      value: light,
                                      activeColor:  Color(0xFF77109B),
                                      onChanged: (bool value) {
                                        setState(() {
                                          light = value;
                                        });
                                      },
                                    )
                                  ],
                                ),
                                Divider(height: 0,)
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
