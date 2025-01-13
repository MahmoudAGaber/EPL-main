import 'package:epl/Data/StateModel.dart';
import 'package:epl/presentation/team/provider/TeamViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../shared/Views/custom/custom_loader.dart';

class Trophy extends ConsumerStatefulWidget {
  String? url;
  Trophy({this.url});
  @override
  _TrophyState createState() => _TrophyState();
}

class _TrophyState extends ConsumerState<Trophy> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var trophy = ref.watch(teamTrophyProvider);

   return trophy.handelState(
        onLoading: (state) => CustomLoader(),
        onSuccess: (state) => Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: trophy.data!.length,
            itemBuilder: (context, index) {
              var item = trophy.data![index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 4,top: 4),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  /*
                                  Container(
                                    height: 45,
                                    width: 45,
                                    child: Image.asset("assets/12.jpg"),
                                  ),

                                   */
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10,bottom: 10,right: 16,left: 16),
                                    child: Column(
                                      children: <Widget>[
                                        Text(item.competition.competitionName,
                                          style: Theme.of(context).textTheme.titleMedium,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Divider(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4,bottom: 4,right: 16,left: 16),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      " الفائز  ".toString().tr,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    Text("${item.firstPlace.length}",
                                      style: TextStyle(
                                          fontFamily: 'Vazirmatn',
                                          color: Colors.green),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Wrap(
                                        children: List.generate(item.firstPlace.length, (innerIndex){
                                          var date = item.firstPlace[innerIndex];

                                          if(date.startDate.isNotEmpty)
                                          return Text("${date.startDate.split("-").first}/${date.endDate.split("-").first} . ",
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                            overflow: TextOverflow.visible,
                                          );
                                          return SizedBox();
                                        }),

                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.only(top: 4,bottom: 4,right: 16,left: 16),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      " الوصيف ".toString(),
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    Text("${item.secondPlace.length}",
                                      style: TextStyle(
                                          fontFamily: 'Vazirmatn',
                                          color: Colors.red),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child:  Wrap(
                                        children: List.generate(item.secondPlace.length, (innerIndex){
                                          var date = item.secondPlace[innerIndex];

                                          if(date.startDate.isNotEmpty)
                                          return Text("${date.startDate.split("-").first}/${date.endDate.split("-").first} . ",
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                            overflow: TextOverflow.visible,
                                          );
                                          return SizedBox();
                                        }),

                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 8,),
                            ],
                          )),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        onFailure: (state) => Text("SHIT")
    );
  }
}
