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

class Videos extends StatefulWidget {
  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  
  VideosViewModel videosViewModel;
  int selectIndex = 0;
  int page =0;
  String ocId='';
  bool loadVideos=false;

  onSelected(int index) {
    setState(() => selectIndex = index);
  }
  ScrollController _controller = ScrollController();



  @override
  void initState() {
    Timer(Duration(milliseconds: 100),(){

    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      videosViewModel = Provider.of(context, listen: false);
      videosViewModel.getVideos('تقارير ومؤتمرات صحفية'.tr,0,"");


        _controller.addListener(() {
          if (_controller.position.pixels ==
              _controller.position.maxScrollExtent) {
            page++;
            loadVideos = true;
           // print("hiiiiiiiiiii");
            videosViewModel.getVideos('تقارير ومؤتمرات صحفية'.tr,page, ocId);
          }
        });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        title: Padding(
          padding: const EdgeInsets.only(right: 0),
          child: Row(
            children: <Widget>[Text("أحدث مقاطع الفيديو".tr,style: TextStyle(color: Colors.white),)],
          ),
        ),
      ),
     // bottomSheet: loadVideos ?Container(color: Colors.green,height: 50, child: Center(child: CircularProgressIndicator()),):null,
      drawer: Drawer(
        child: More(),
      ),
      body: Consumer<VideosViewModel>(
        builder: (context,provider,child){
          return provider.loadingNews
              ?Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,))
              : ListView(
            controller: _controller,
            children: [
              Container(
                height: 40,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.categoriesList.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          height: 50,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                onSelected(index);
                              });
                             if(selectIndex != index-1){
                               page = 1;
                                 videosViewModel.getVideos('تقارير ومؤتمرات صحفية'.tr,page,'${provider.categoriesList[index].ocId}');
                                 ocId = provider.categoriesList[index].ocId;
                             }

                              //videosViewModel.getVideos(page,'${provider.categoriesList[index].ocId}');

                            },
                            child: Card(
                                color: selectIndex != null && selectIndex == index
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(child: Padding(
                                  padding: const EdgeInsets.only(left: 7,right:7),
                                  child: Text(provider.categoriesList[index].name,
                                  style: TextStyle(color: selectIndex != null && selectIndex == index
                                      ? Colors.white
                                      : Colors.black,),),
                                ))),
                          ),),
                      );
                    }),),
              ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: provider.videosList.length+1,
                itemBuilder: (BuildContext context, index) {
                  //print( provider.videosList[0].url);
                  return Stack(
                    children: <Widget>[
                      index == provider.videosList.length
                          ? Center(child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SpinKitThreeBounce(color: Theme.of(context).primaryColor,size: 25,),
                      ))
                          : Container(
                        width: MediaQuery.of(context).size.width,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>webView(url: "https://www.eplworld.com${provider.videosList[index].url}",)));
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.95,
                                          height: 200,
                                          child: new ClipRRect(
                                            child: Image.network(
                                             provider.videosList[index].imgJPG,
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.circular(16.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15, right: 15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.85,
                                            child: Text(
                                              provider.videosList[index].title,
                                              style: TextStyle(
                                                  fontSize: 15, fontWeight: FontWeight.w500,),
                                            ),
                                          ),
                                        ],

                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12, right: 15),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            MdiIcons.soccer,
                                            size: 15.0,
                                          ),
                                          SizedBox(width: 5,),
                                          Text(
                                            provider.videosList[index].username,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(width: 5,),
                                          Text(
                                          "${provider.videosList[index].date} - ${provider.videosList[index].since}".tr,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 85,right: MediaQuery.of(context).size.width*.45,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>webView(url: "https://www.eplworld.com${provider.videosList[index].url}",)));
                          },
                          child: Container(
                            height: 55,width: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                width: 4,
                                color: Colors.white.withOpacity(.6)
                              )
                            ),
                              child: Icon(Icons.play_arrow,color: Colors.white.withOpacity(.6),size: 48,)),
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}