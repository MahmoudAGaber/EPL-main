
import 'dart:async';
import 'dart:io';
import 'dart:ui';

//import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
//import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class Reels extends StatefulWidget {
  @override
  _ReelsState createState() => _ReelsState();
}

class _ReelsState extends State<Reels> {

  PageController controller = PageController(initialPage: 0,keepPage: true);
  //PreloadPageController preloadPageController = PreloadPageController(initialPage: 0,keepPage: true);
  ScrollController _scrollController;
  double _scrollPosition;
  VideoPlayerController _controller;
  bool change = false;
  int currentPage = 0;
  bool isOnPageTuning = false;
  int selectedIndex=0;
  FileInfo test;
  List<FileInfo>fileInfoOut=[];
  selected(index){
    selectedIndex = index;
    return selectedIndex;
  }

  /*
  Future<FileInfo>download()async{
    List<FileInfo> fileInfo=[];
    var file = await DefaultCacheManager().downloadFile(videos[2]);
    for(int i=0; i<20; i++){
      fileInfo.add( await DefaultCacheManager().downloadFile(videos[i]));
    }
    print(fileInfo[8].file.path);
    fileInfoOut = fileInfo;
    print(fileInfoOut.length);
    test=file;
    return file;
  }



   */

List<String> videosAss = [
  "assets/moroccotalksfootball_20220222_002424_0.mp4",
  "assets/muslera_fc1905_gs_20220222_002301_0.mp4",
  "assets/ney.reelz_20220222_002351_0.mp4",
  'assets/psg_20220222_002838_0.mp4',
  'assets/twelfthplayer12_20220222_002218_0.mp4',
  "assets/moroccotalksfootball_20220222_002424_0.mp4",
  "assets/muslera_fc1905_gs_20220222_002301_0.mp4",
  "assets/ney.reelz_20220222_002351_0.mp4",
  'assets/psg_20220222_002838_0.mp4',
  'assets/twelfthplayer12_20220222_002218_0.mp4'



];
  List<String> videos = [
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4"

  ];

  VideosProvider videosProvider;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      videosProvider = Provider.of(context,listen: false);
      _scrollController = ScrollController();
    });


    //controller.addListener(_scrollListener);
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0.0,),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child:Center(
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: PageView.builder(
                          controller: controller,
                          scrollDirection: Axis.vertical,
                          itemCount: videosAss.length,
                          itemBuilder: (context,index){
                            return Stack(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.green,
                                  child:VideoApp(url: videosAss[index],play: true,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20,bottom: 20,right: 10,left: 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Reels',style: TextStyle(fontSize: 21,color: Colors.white),)
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      minRadius: 17,
                                                    ),
                                                    SizedBox(width: 10,),
                                                    Text('Eplworld_d',style: TextStyle(color: Colors.white,fontSize: 15),)
                                                  ],
                                                ),
                                                SizedBox(height: 8,),
                                                Text('Eplwrold Football',style: TextStyle(fontSize: 14,color: Colors.white),),
                                                SizedBox(height: 8,),
                                                Row(
                                                  children: [
                                                    Icon(Icons.assessment,size: 13,color: Colors.white,),
                                                    SizedBox(width: 5,),
                                                    Text('Raouf Khelaf_orginal audio',style: TextStyle(fontSize: 13,color: Colors.white),),
                                                  ],
                                                )

                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Icon(MdiIcons.heartOutline,color: Colors.white,size: 26,),
                                                    Text('4,898',style: TextStyle(color:Colors.white),)
                                                  ],
                                                ),
                                                SizedBox(height: 20,),
                                                Column(
                                                  children: [
                                                    Icon(MdiIcons.commentOutline,color: Colors.white,size: 26,),
                                                    Text('9',style: TextStyle(color:Colors.white),)
                                                  ],
                                                ),
                                                SizedBox(height: 20,),
                                                Column(
                                                  children: [
                                                    Transform.rotate(
                                                        angle: 100,
                                                        child: Icon(MdiIcons.sendOutline,color: Colors.white,size: 24,)),
                                                  ],
                                                ),
                                                SizedBox(height: 20,),
                                                Icon(MdiIcons.dotsVertical,color: Colors.white,),
                                                SizedBox(height: 20,),
                                                Container(
                                                  height: 23,width: 23,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors.white
                                                      ),
                                                      borderRadius: BorderRadius.circular(4)
                                                  ),
                                                )
                                              ],
                                            ),


                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                    )

                  ],
            ),
          )
      ),
    );
  }
}



class VideoApp extends StatefulWidget {
  final String url;
  final bool play;
  VideoApp({this.url,this.play});
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {


  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

 // BetterPlayerController betterPlayerController;


  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.url);
    _controller.initialize().then((_) {
      setState(() {});
    });
    if (widget.play) {
      _controller.play();
      _controller.setLooping(true);
      _controller.setVolume(300.0);
    }


    /*
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(

        BetterPlayerDataSourceType.network,
        widget.url,
    );
    betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          fit: BoxFit.fill,
          aspectRatio: 8/14,
          autoPlay: true,
          looping: true,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            showControls: false,
          ),
          startAt: Duration(milliseconds: 1),
          showPlaceholderUntilPlay: true,
        ),
        betterPlayerDataSource: betterPlayerDataSource);

     */
  }

  @override
  void didUpdateWidget(VideoApp oldWidget) {
    if (oldWidget.play != widget.play) {
      if (widget.play) {
        _controller.play();
        _controller.setLooping(true);
      } else {
        _controller.pause();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: _controller.value.isInitialized
              ?VideoPlayer(_controller)
              :Container(color:Colors.black)
      ),
    );
  }
}


class VideosProvider with ChangeNotifier {
  int _currentVideo = 0;
  bool _listen = false;
  int get currentVideo => _currentVideo;
  bool get listen => _listen;

  set currentVideo(int currentVideo) {
    _currentVideo = currentVideo;
    notifyListeners();
  }

  set listen(bool listen){
    _listen = listen;
    notifyListeners();
  }
}




