

import 'package:arseli/Provider/EachMatchViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class MatchStats extends StatefulWidget {
  String url;
  MatchStats({this.url});
  @override
  _MatchStatsState createState() => _MatchStatsState();
}

class _MatchStatsState extends State<MatchStats> {

  bool chContaier = false;

  AnimationController animationController;
  Animation<double> _animation;

  EachMatchViewModel eachMatchViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eachMatchViewModel = Provider.of(context,listen: false);
      eachMatchViewModel.getMatchStats(widget.url);
      print("fdsfdsf${widget.url}");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Consumer<EachMatchViewModel>(
        builder: (context,provider,child){
          return provider.loadingStats
              ?Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),),
              )
              :Column(
            children: <Widget>[
              /*
            Column(
              children: [
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10.0, right: 11.0),
                      width: 180,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: Colors.grey[300])),
                      child: Center(
                        child: Text("فريق",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12.5)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, right: 10.0),
                      width: 180,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: Colors.grey[300])),
                      child: Center(
                        child: Text("لاعب",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12.5)),
                      ),
                    ),

                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("احصائيات الصدارة", style: content),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 5, right: 15, left: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("السيطرة علي الكرة", style: content),
                ],
              ),
            ),

             */
              provider.statsEachMatchModel==null
                  ?Container()
                  :Padding(
                padding: const EdgeInsets.only(right: 10,left: 10,top: 15,bottom: 15),
                child: Stack(children: <Widget>[
                  /*
                  LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width*0.9,
                    percent: 0.1,
                    progressColor: Colors.green[600],
                    isRTL: true,
                    lineHeight: 35,
                    backgroundColor: Colors.grey[600],


                  ),

                   */
                  Container(
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width
                              *(((double.parse(provider.statsEachMatchModel.header.homePercent))/100)-0.039),
                               decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft:Radius.circular(6),
                                bottomLeft: Radius.circular(6),
                              )
                          ),
                        ),
                        SizedBox(width: 4,),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width
                              *(((double.parse(provider.statsEachMatchModel.header.awayPercent))/100)-0.025),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                              topRight:Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            )
                          ),


                        )
                      ],
                    ),
                  ),
                  Positioned(
                      right: 10,
                      top: 9,
                      child: Text("${provider.statsEachMatchModel.header.homePercent}%",
                        style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),)),
                  Positioned(
                      left:10,
                      top: 9,
                      child: Text("${provider.statsEachMatchModel.header.awayPercent}%",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),)),
                ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                  provider.sortedStatsModelMatch.general.isEmpty
                      ?Container()
                      :Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('عام',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                          SizedBox(height: 10,),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: provider.sortedStatsModelMatch.general.length,
                              itemBuilder: (context,index){
                                return Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7, right: 7, top: 5, bottom: 2),
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                color: int.parse("${"${provider.sortedStatsModelMatch.general[index].home}".split('%').first}")
                                                    >int.parse("${"${provider.sortedStatsModelMatch.general[index].away}".split('%').first}")
                                                    ?Colors.grey[300]:null
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 6,left: 6,top: 3,bottom: 3),
                                                child: Text(
                                                  "${provider.sortedStatsModelMatch.general[index].home}",
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${provider.sortedStatsModelMatch.general[index].name}",
                                          style: TextStyle(fontSize: 16,color: Colors.black54),
                                        ),
                                      ),
                                      Container(
                                        width: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7, right: 7, top: 5, bottom: 2),
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                  color: int.parse("${"${provider.sortedStatsModelMatch.general[index].home}".split('%').first}")
                                                      <int.parse("${"${provider.sortedStatsModelMatch.general[index].away}".split('%').first}")
                                                      ?Colors.grey[300]:null
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 6,left: 6,top: 3,bottom: 3),
                                                child: Text(
                                                  "${provider.sortedStatsModelMatch.general[index].away}",
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                    provider.sortedStatsModelMatch.passing.isEmpty
                        ?Container()
                  :Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('توزيع',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                          SizedBox(height: 10,),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: provider.sortedStatsModelMatch.passing.length,
                              itemBuilder: (context,index){
                                return Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7, right: 7, top: 5, bottom: 2),
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                  color: int.parse("${"${provider.sortedStatsModelMatch.passing[index].home}".split('%').first}")
                                                      >int.parse("${"${provider.sortedStatsModelMatch.passing[index].away}".split('%').first}")
                                                      ?Colors.grey[300]:null
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 6,left: 6,top: 3,bottom: 3),
                                                child: Text(
                                                  "${provider.sortedStatsModelMatch.passing[index].home}",
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${provider.sortedStatsModelMatch.passing[index].name}",
                                          style: TextStyle(fontSize: 16,color: Colors.black54),
                                        ),
                                      ),
                                      Container(
                                        width: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7, right: 7, top: 5, bottom: 2),
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                  color: int.parse("${"${provider.sortedStatsModelMatch.passing[index].home}".split('%').first}")
                                                      <int.parse("${"${provider.sortedStatsModelMatch.passing[index].away}".split('%').first}")
                                                      ?Colors.grey[300]:null
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 6,left: 6,top: 3,bottom: 3),
                                                child: Text(
                                                  "${provider.sortedStatsModelMatch.passing[index].away}",
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                    provider.sortedStatsModelMatch.attack.isEmpty
                        ?Container()
                  :Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('هجوم',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                          SizedBox(height: 10,),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: provider.sortedStatsModelMatch.attack.length,
                              itemBuilder: (context,index){
                                return Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7, right: 7, top: 5, bottom: 2),
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                  color: int.parse("${"${provider.sortedStatsModelMatch.attack[index].home}".split('%').first}")
                                                      >int.parse("${"${provider.sortedStatsModelMatch.attack[index].away}".split('%').first}")
                                                      ?Colors.grey[300]:null
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 6,left: 6,top: 3,bottom: 3),
                                                child: Text(
                                                  "${provider.sortedStatsModelMatch.attack[index].home}",
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${provider.sortedStatsModelMatch.attack[index].name}",
                                          style: TextStyle(fontSize: 16,color: Colors.black54),
                                        ),
                                      ),
                                      Container(
                                        width: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7, right: 7, top: 5, bottom: 2),
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                  color: int.parse("${"${provider.sortedStatsModelMatch.attack[index].home}".split('%').first}")
                                                      <int.parse("${"${provider.sortedStatsModelMatch.attack[index].away}".split('%').first}")
                                                      ?Colors.grey[300]:null
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 6,left: 6,top: 3,bottom: 3),
                                                child: Text(
                                                  "${provider.sortedStatsModelMatch.attack[index].away}",
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                    provider.sortedStatsModelMatch.defend.isEmpty
                        ?Container()
                  :Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('دفاع',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                          SizedBox(height: 10,),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: provider.sortedStatsModelMatch.defend.length,
                              itemBuilder: (context,index){
                                return Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7, right: 7, top: 5, bottom: 2),
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                  color: int.parse("${"${provider.sortedStatsModelMatch.defend[index].home}".split('%').first}")
                                                      >int.parse("${"${provider.sortedStatsModelMatch.defend[index].away}".split('%').first}")
                                                      ?Colors.grey[300]:null
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 6,left: 6,top: 3,bottom: 3),
                                                child: Text(
                                                  "${provider.sortedStatsModelMatch.defend[index].home}",
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${provider.sortedStatsModelMatch.defend[index].name}",
                                          style: TextStyle(fontSize: 16,color: Colors.black54),
                                        ),
                                      ),
                                      Container(
                                        width: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7, right: 7, top: 5, bottom: 2),
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                  color: int.parse("${"${provider.sortedStatsModelMatch.defend[index].home}".split('%').first}")
                                                      <int.parse("${"${provider.sortedStatsModelMatch.defend[index].away}".split('%').first}")
                                                      ?Colors.grey[300]:null
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 6,left: 6,top: 3,bottom: 3),
                                                child: Text(
                                                  "${provider.sortedStatsModelMatch.defend[index].away}",
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                    provider.sortedStatsModelMatch.precision.isEmpty
                        ?Container()
                  :Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('إنضباط',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                          SizedBox(height: 10,),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: provider.sortedStatsModelMatch.precision.length,
                              itemBuilder: (context,index){
                                return Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7, right: 7, top: 5, bottom: 2),
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                  color: int.parse("${"${provider.sortedStatsModelMatch.precision[index].home}".split('%').first}")
                                                      >int.parse("${"${provider.sortedStatsModelMatch.precision[index].away}".split('%').first}")
                                                      ?Colors.grey[300]:null
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 6,left: 6,top: 3,bottom: 3),
                                                child: Text(
                                                  "${provider.sortedStatsModelMatch.precision[index].home}",
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${provider.sortedStatsModelMatch.precision[index].name}",
                                          style: TextStyle(fontSize: 16,color: Colors.black54),
                                        ),
                                      ),
                                      Container(
                                        width: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7, right: 7, top: 5, bottom: 2),
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                  color: int.parse("${"${provider.sortedStatsModelMatch.precision[index].home}".split('%').first}")
                                                      <int.parse("${"${provider.sortedStatsModelMatch.precision[index].away}".split('%').first}")
                                                      ?Colors.grey[300]:null
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 6,left: 6,top: 3,bottom: 3),
                                                child: Text(
                                                  "${provider.sortedStatsModelMatch.precision[index].away}",
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                ],),
              )




            ],
          );
        }
      ),
    );
  }
}
