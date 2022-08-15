import 'package:arseli/Provider/NewsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../More.dart';
import '../trendingData.dart';
import '../webView.dart';

class latest extends StatefulWidget {
  @override
  _latestState createState() => _latestState();
}

class _latestState extends State<latest> {
  
  NewsViewModel newsViewModel;
  int selectIndex = 0;
  int page =1;
  String ocId='1';

  onSelected(int index) {
    setState(() => selectIndex = index);
  }
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      newsViewModel = Provider.of(context, listen: false);
      newsViewModel.getNews(1,"1");

      _controller.addListener(() {
        if (_controller.position.pixels ==
            _controller.position.maxScrollExtent) {
          page++;
         // print("hiiiiiiiiiii");
          newsViewModel.getNews(page, ocId);
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
          child: Row(children: <Widget>[Text("الأخبار".tr,style: TextStyle(color: Colors.white),)],
          ),
        ),
      ),
      drawer: Drawer(
        child: More(),
      ),
      body: Consumer<NewsViewModel>(
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
                        child: Container(height: 50,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                onSelected(index);
                              });
                              if(selectIndex != index-1){
                                page = 1;
                                newsViewModel.getNews(page,'${provider.categoriesList[index].ocId}');
                                ocId = provider.categoriesList[index].ocId;
                              }
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
                itemCount: provider.newsList.length+1,
                itemBuilder: (BuildContext context, index) {
                 // print( provider.newsList[0].url);
                  return Column(
                    children: <Widget>[
                      index == provider.newsList.length
                          ? Center(child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SpinKitThreeBounce(color: Theme.of(context).primaryColor,size: 25,),
                      ))
                          : Container(
                        width: MediaQuery.of(context).size.width,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>webView(url: "https://www.eplworld.com${provider.newsList[index].url}",)));
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
                                             provider.newsList[index].imageJPG,
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
                                              provider.newsList[index].title,
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
                                            provider.newsList[index].username,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(width: 5,),
                                          Text(
                                          "${provider.newsList[index].date} - ${provider.newsList[index].time}".tr,
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
                              )
                            ],
                          ),
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
