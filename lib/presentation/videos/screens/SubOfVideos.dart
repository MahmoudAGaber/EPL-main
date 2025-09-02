import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';


class SubOfVideos extends StatefulWidget {
  String? ocId;
  SubOfVideos({this.ocId});
  @override
  _SubOfVideosState createState() => _SubOfVideosState();
}

class _SubOfVideosState extends State<SubOfVideos> with AutomaticKeepAliveClientMixin {


  int selectIndex = 0;
  int page = 0;
  String ocId = '';
  bool loadVideos = false;
  TabController? tabController;
  bool v = true;


  ScrollController _controller = ScrollController();

  @override
  void initState() {
    Timer(Duration(milliseconds: 100), () {});
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      _controller.addListener(() {
        if (_controller.position.pixels ==
            _controller.position.maxScrollExtent) {
          page++;
          loadVideos = true;
          // print("hiiiiiiiiiii");
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
        child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: ListView.builder(
                   controller: _controller,
                  physics: ClampingScrollPhysics(),
                   shrinkWrap: true,
                   scrollDirection: Axis.vertical,
                   itemCount: 5,
                   itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Stack(
                        children: <Widget>[
                          index ==5
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
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => webView(url: "https://www.eplworld.com",)));
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
                                                "",
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
                                            child: Text("title",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
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
                                           "userName",
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "data - since"
                                                .tr,
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
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
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => webView(
                              //           url:
                              //           "https://www.eplworld.com",
                              //         )));
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
               )

      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  
 
}
