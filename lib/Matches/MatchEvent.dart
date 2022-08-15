import 'package:arseli/Provider/EachMatchViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MatchEvents extends StatefulWidget {
  String url;
  MatchEvents(this.url);
  @override
  _MatchEventsState createState() => _MatchEventsState();
}

class _MatchEventsState extends State<MatchEvents> {

  EachMatchViewModel eachMatchViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eachMatchViewModel = Provider.of(context,listen: false);
      eachMatchViewModel.getMatchEvent(widget.url);
      var now = DateTime.now();
      print("gooooood${eachMatchViewModel.matchDetailsModel.teamFormModel}");
      //print(now);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EachMatchViewModel>(
      builder: (context,provider,child){
        return provider.loadingEvents || provider.matchDetailsModel==null
            ?Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,),),
        )
            :Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Column(
                  children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.all(15.0),
                     child: Row(
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text('تاريخ المباراة	',style: TextStyle(fontSize: 15),),
                             SizedBox(height: 15,),
                             Text('البطولة',style: TextStyle(fontSize: 15),),
                             SizedBox(height: 15,),
                             Text('الملعب',style: TextStyle(fontSize: 15),),
                             SizedBox(height: 15,),
                             provider.matchDetailsModel.refreeName.isBlank
                                  ?Container()
                                 :Text('الحكم',style: TextStyle(fontSize: 15),)
                           ],
                         ),
                         SizedBox(width: 50,),
                         Expanded(
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                             Container(
                               child: Padding(
                                 padding: const EdgeInsets.only(left: 3, right: 3),
                                 child: Text(
                                   provider.matchDetailsModel.date.tr,
                                   maxLines: 2,
                                   softWrap: true,
                                 ),
                               ),
                             ),
                             SizedBox(height: 15,),
                             Container(
                               decoration: BoxDecoration(
                                   color: Colors.grey[300],
                                   borderRadius: BorderRadius.all(
                                     Radius.circular(10),
                                   )),
                               child: Padding(
                                 padding: const EdgeInsets.only(left: 3, right: 3),
                                 child: Text(
                                   provider.matchDetailsModel.leagueName.tr,
                                   maxLines: 2,
                                   softWrap: true,
                                 ),
                               ),
                             ),
                               SizedBox(height: 15,),
                             Container(
                               decoration: BoxDecoration(
                                   color: Colors.grey[300],
                                   borderRadius: BorderRadius.all(
                                     Radius.circular(10),
                                   )),
                               child: Padding(
                                 padding: const EdgeInsets.only(left: 3, right: 3),
                                 child: Text(
                                   provider.matchDetailsModel.groundName.tr,
                                   maxLines: 2,
                                   softWrap: true,
                                 ),
                               ),
                             ),

                               SizedBox(height: 15,),
                               provider.matchDetailsModel.refreeName.isBlank
                                   ?Container()
                                   :Container(
                                 decoration: BoxDecoration(
                                     color: Colors.grey[300],
                                     borderRadius: BorderRadius.all(
                                       Radius.circular(10),
                                     )),
                                 child: Padding(
                                   padding: const EdgeInsets.only(left: 3, right: 3),
                                   child: Text(
                                     provider.matchDetailsModel.refreeName.tr,
                                     maxLines: 2,
                                     softWrap: true,
                                   ),
                                 ),
                               )

                           ],),
                         )
                       ],
                     ),
                   )
                  ],
                ),
              ),
            ),
          ),
          provider.matchDetailsModel.teamFormModel.away.isBlank
              ?Container()
              :Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 160,
              width: MediaQuery.of(context).size.width,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 15, right: 10,bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[Text("المواجهات السابقة".tr)],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 85,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                height: 85,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: provider.teamFormModel.teamFormModel.home.length,
                                    itemBuilder:(context,index){
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 4,right: 4,top: 8,bottom: 8),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 23,
                                              width: 23,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                  color: provider.teamFormModel.teamFormModel.home[index].status == 'W'
                                                      ? Colors.green
                                                      : provider.teamFormModel.teamFormModel.home[index].status == 'L'
                                                      ? Colors.red
                                                      : provider.teamFormModel.teamFormModel.home[index].status == 'D'
                                                      ? Colors.black45
                                                      : null

                                              ),
                                              child: Center(child: Text(provider.teamFormModel.teamFormModel.home[index].status,
                                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),)),
                                            ),
                                            SizedBox(height: 5,),
                                            index== 0
                                                ?Container(height: 2,width:23,color: Colors.green,)
                                                :Container(),
                                            SizedBox(height: 5,),
                                            Container(
                                              height: 25,
                                              width: 26,
                                              child: Image.network("https://www.eplworld.com${provider.teamFormModel.teamFormModel.home[index].teamLogo}"),
                                            )
                                          ],

                                        ),
                                      );
                                    }),
                              ),
                            ),
                            SizedBox(width: 30,),
                            Flexible(
                              flex: 1,
                              child: Container(
                                height: 85,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: provider.teamFormModel.teamFormModel.away.length,
                                    itemBuilder:(context,index){
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 4,right: 4,top: 8,bottom: 8),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 23,
                                              width: 23,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                  color: provider.teamFormModel.teamFormModel.away[index].status == 'W'
                                                      ? Colors.green
                                                      : provider.teamFormModel.teamFormModel.away[index].status == 'L'
                                                      ? Colors.red
                                                      : provider.teamFormModel.teamFormModel.away[index].status == 'D'
                                                      ? Colors.black45
                                                      : null

                                              ),
                                              child: Center(child: Text(provider.teamFormModel.teamFormModel.away[index].status,
                                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),)),
                                            ),
                                            SizedBox(height: 5,),
                                            index==0
                                                ?Container(height: 2,width:23,color: Colors.green,)
                                                :Container(),
                                            SizedBox(height: 5,),
                                            Container(
                                              height: 25,
                                              width: 26,
                                              child: Image.network("https://www.eplworld.com${provider.teamFormModel.teamFormModel.away[index].teamLogo}"),
                                            )
                                          ],

                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )

        ]);
      },
    );
  }
}
