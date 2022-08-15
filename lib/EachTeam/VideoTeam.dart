import 'package:arseli/webView.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../trendingData.dart';

class VideoTeam extends StatefulWidget {
  String url;
  VideoTeam({this.url});
  @override
  _VideoTeamState createState() => _VideoTeamState();
}

class _VideoTeamState extends State<VideoTeam> {
  EachTeamViewModel eachTeamViewModel;
  ScrollController _controller = ScrollController();
  int page=1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eachTeamViewModel = Provider.of(context,listen: false);
      eachTeamViewModel.getVideos("${widget.url}/videos",1);

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
        physics: ClampingScrollPhysics(),
      controller: _controller,
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Consumer<EachTeamViewModel>(
            builder: (context,provider,child){
              return provider.loadingVideos
                  ?Padding(padding: EdgeInsets.only(top: 35),
                  child:Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor),))
                  :ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: provider.videoModelList.length,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 4,bottom: 4),
                          child: Column(
                              children: <Widget>[
                                /*
                                index==provider.videoModelList.length
                                    ?Center(child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SpinKitThreeBounce(color: Theme.of(context).primaryColor,size: 25,),
                                ))
                                :
                                 */
                                    GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder:(context)=>webView(url: "https://www.eplworld.com${provider.videoModelList[index].url}",)));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Container(

                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(left: 5),

                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: <Widget>[
                                                Card(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(10))),
                                                    child: Container(
                                                      height: 100,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Container(
                                                              height: 100,
                                                              width: MediaQuery.of(context).size.width * 0.338,
                                                              decoration: BoxDecoration(
                                                                  color: Colors.grey[200],
                                                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                                                              child: Stack(
                                                                children: <Widget>[
                                                                  ClipRRect(
                                                                    borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                                                                    child: Container(
                                                                        height: 100,
                                                                        width: MediaQuery.of(context).size.width * 0.338,
                                                                        child: Image.network(provider.videoModelList[index].imgJPG,
                                                                          fit: BoxFit.cover ,)),
                                                                  ),
                                                                  Positioned(
                                                                      top: 35,
                                                                      right: 50,
                                                                      child: Icon(Icons.play_arrow,color: Colors.white,size: 35,) )
                                                                ],
                                                              )),
                                                          Container(
                                                            height: 100,
                                                            width: MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                                0.6,
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets.only(left: 15,right: 15),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.center,
                                                                children: <Widget>[
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Expanded(
                                                                          child: Text(provider.videoModelList[index].title.tr,overflow: TextOverflow.clip,))
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  FittedBox(
                                                                    child: Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      children: <Widget>[
                                                                        Text(
                                                                          provider.videoModelList[index].username,
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Colors.grey),
                                                                        ),
                                                                        SizedBox(width: 5,),
                                                                        Text(
                                                                          "${provider.videoModelList[index].date} - ${provider.videoModelList[index].since}".tr,
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Colors.grey),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ]),
                        );
                      });
            },
          ),

        ),
      ],
    );
  }}

