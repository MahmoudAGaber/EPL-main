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
            :Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
              children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('تفاصيل المباراة',style: TextStyle(fontWeight: FontWeight.w600),),
                     Divider(),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             children: [
                               Container(width: 25,),
                               SizedBox(width: 10,),
                               Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text('المسابقة',style: TextStyle(fontWeight: FontWeight.w600),),
                                   Text(
                                     provider.matchDetailsModel.leagueName.tr,
                                     maxLines: 2,
                                     softWrap: true,
                                   ),
                                 ],
                               ),
                             ],
                           ),
                           SizedBox(height: 18,),
                           Row(
                             children: [
                               Icon(Icons.access_time,size: 22,),
                               SizedBox(width: 10,),
                               Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text('ضربة البداية',style: TextStyle(fontWeight: FontWeight.w600),),
                                   Text(
                                     provider.matchDetailsModel.date.tr,
                                     maxLines: 2,
                                     softWrap: true,
                                   ),
                                 ],
                               ),
                             ],
                           ),
                           SizedBox(height: 18,),
                           Row(
                             children: [
                               Icon(Icons.location_on_outlined,size: 22,),
                               SizedBox(width: 10,),
                               Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text('ملعب المباراة',style: TextStyle(fontWeight: FontWeight.w600),),
                                   Text(
                                     provider.matchDetailsModel.groundName.tr,
                                     maxLines: 2,
                                     softWrap: true,
                                   ),
                                 ],
                               )
                             ],
                           )

                         ],
                       ),
                     ),
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
                height: 175,
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
                      Divider(),
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
                                          padding: const EdgeInsets.only(left: 3,right: 3,top: 8,bottom: 8),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 21,
                                                width: 21,
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
                                          padding: const EdgeInsets.only(left: 3,right: 3,top: 8,bottom: 8),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 21,
                                                width: 21,
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

        ]),
            );
      },
    );
  }
}
