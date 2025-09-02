import 'package:epl/Data/StateModel.dart';
import 'package:epl/presentation/league/provider/LeagueViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/Utils/Constants.dart';
import '../../../shared/Views/custom/custom_imageView.dart';
import '../../../shared/Views/custom/custom_loader.dart';


class Trophies extends ConsumerStatefulWidget {
  String? url;
  Trophies({this.url});
  @override
  _TrophiesState createState() => _TrophiesState();
}

class _TrophiesState extends ConsumerState<Trophies> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var trophies = ref.watch(leagueTrophyProvider);

    return trophies.handelState(
        onLoading: (state)=> CustomLoader(),
        onSuccess: (state)=>Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: trophies.data!.seasons.length,
            itemBuilder: (context, index) {
              var trophy =  trophies.data!.seasons[index];
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4,top: 4),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 14,bottom: 7,right: 18,left: 18),
                              child: Text(
                                trophy.name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            Divider(),
                            SizedBox(
                              height: 15,
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    SizedBox(
                                      height: 40,width: 40,
                                      child: CustomImage(imgUrl: "${Constants.teamImage}${trophy.trophy.winnerTeamId}.png",),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "الفائز",
                                            style: Theme.of(context).textTheme.titleMedium
                                        )
                                      ],
                                    )
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10,bottom: 10),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    SizedBox(
                                      height: 40,width: 40,
                                      child: CustomImage(imgUrl: "${Constants.teamImage}${trophy.trophy.runnerupTeamId}.png",),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "المركز الثاني",
                                            style: Theme.of(context).textTheme.titleMedium
                                        )
                                      ],
                                    )
                                  ]),
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),),
        onFailure: (state)=>  Text("SHTt")
    );

  }
}
