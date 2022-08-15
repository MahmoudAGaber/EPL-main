import 'package:arseli/Provider/EachLeagueViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Cups extends StatefulWidget {
  String url;
  Cups({this.url});
  @override
  _CupsState createState() => _CupsState();
}

class _CupsState extends State<Cups> {

  EachLeagueViewModel eachTeamViewModel;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eachTeamViewModel = Provider.of(context, listen: false);
      eachTeamViewModel.getCups("${widget.url}/trophies");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EachLeagueViewModel>(
      builder: (context,provider,child){
        return  provider.loadingCups
            ?Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,),),
        )
            :ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: provider.trophiesBoxesModelList.length,
          itemBuilder: (context,index){
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(provider.trophiesBoxesModelList[index].CalendarYear,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                    child: Image.network('https://www.eplworld.com${provider.trophiesBoxesModelList[index].winnerLogo}',
                                      fit: BoxFit.fill,height: 40,width: 40,)),
                              ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(provider.trophiesBoxesModelList[index].winnerName,style: TextStyle(fontSize: 17),),
                                  Text("الفائز",style: TextStyle(fontSize: 15,color: Colors.black54),)
                                ],
                              )
                            ]
                          ),
                          SizedBox(height: 15,),
                          provider.trophiesBoxesModelList[index].runnerUpName.isEmpty
                              ?Container()
                              :Row(
                              children: [
                                Container(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network('https://www.eplworld.com${provider.trophiesBoxesModelList[index].runnerUplogo}',
                                        fit: BoxFit.fill,height: 40,width: 40,)),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(provider.trophiesBoxesModelList[index].runnerUpName,style: TextStyle(fontSize: 17),),
                                    Text("المركز الثاني",style: TextStyle(fontSize: 15,color: Colors.black54),)
                                  ],
                                )
                              ]
                          ),

                        ],),
                    ),
                  ),
                ),
            )],
            );
          },
        );
      },
    );
  }
}
