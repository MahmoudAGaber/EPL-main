import 'dart:async';
import 'dart:developer';

import 'package:arseli/Provider/NewsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../More.dart';
import 'webView.dart';
import 'Provider/VideosViewModel.dart';

class SubOfVideos extends StatefulWidget {
  String ocId;
  SubOfVideos({this.ocId});
  @override
  _SubOfVideosState createState() => _SubOfVideosState();
}

class _SubOfVideosState extends State<SubOfVideos> with AutomaticKeepAliveClientMixin {


  VideosViewModel videosViewModel;
  int selectIndex = 0;
  int page = 0;
  String ocId = '';
  bool loadVideos = false;
  TabController tabController;
  bool v = true;


  ScrollController _controller = ScrollController();

  @override
  void initState() {
    Timer(Duration(milliseconds: 100), () {});
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      videosViewModel = Provider.of(context, listen: false);
        videosViewModel.getVideos('تقارير ومؤتمرات صحفية',0,widget.ocId);

      _controller.addListener(() {
        if (_controller.position.pixels ==
            _controller.position.maxScrollExtent) {
          page++;
          loadVideos = true;
          // print("hiiiiiiiiiii");
          videosViewModel.getVideos('تقارير ومؤتمرات صحفية',page, ocId);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Consumer<VideosViewModel>(
          builder: (context,provider,child){
           return provider.loadingVideos
               ?Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),)
               :Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: ListView.builder(
                   controller: _controller,
                  physics: ClampingScrollPhysics(),
                   shrinkWrap: true,
                   scrollDirection: Axis.vertical,
                   itemCount: provider.videosList.length + 1,
                   itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Stack(
                        children: <Widget>[
                          index == provider.videosList.length
                              ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SpinKitThreeBounce(
                                  color: Theme.of(context).primaryColor,
                                  size: 25,
                                ),
                              ))
                            :Container(
                          width:
                          MediaQuery.of(context).size.width,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          webView(
                                            url:
                                            "https://www.eplworld.com${provider.videosList[index].url}",
                                          )));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(16)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8),
                                child: new Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            height: 200,
                                            child: new ClipRRect(
                                              child:
                                              Image.network(
                                                provider
                                                    .videosList[
                                                index]
                                                    .imgJPG,
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius
                                                      .circular(
                                                      16),
                                                  topRight: Radius
                                                      .circular(
                                                      16)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          left: 15,
                                          right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(
                                                context)
                                                .size
                                                .width *
                                                0.85,
                                            child: Text(
                                              provider.videosList[index].title,style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          top: 12, right: 15),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            MdiIcons.soccer,
                                            size: 15.0,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            provider
                                                .videosList[index]
                                                .username,
                                            style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 13),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "${provider.videosList[index].date} - ${provider.videosList[index].since}"
                                                .tr,
                                            style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 85,
                          right: MediaQuery.of(context).size.width * .42,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => webView(
                                        url:
                                        "https://www.eplworld.com${provider.videosList[index].url}",
                                      )));
                            },
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
              },
            ),
               );
          },
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  
 
}
