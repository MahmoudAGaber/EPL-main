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

class ForYou extends StatefulWidget {
  @override
  _ForYouState createState() => _ForYouState();
}

class _ForYouState extends State<ForYou> {
  NewsViewModel newsViewModel;
  int selectIndex = 0;
  int page = 1;
  String ocId = '1';

  onSelected(int index) {
    setState(() => selectIndex = index);
  }

  ScrollController _controller = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      newsViewModel = Provider.of(context, listen: false);
      newsViewModel.getNews(1, "1");

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
      /*
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xfff77109B),
        title: Padding(
          padding: const EdgeInsets.only(right: 0),
          child: Row(
            children: <Widget>[
              Text(
                "الأخبار".tr,
                style: TextStyle(fontFamily: 'Vazirmatn', color: Colors.white),
              )
            ],
          ),
        ),
      ),

       */
      /*
      drawer: Drawer(
        child: More(),
      ),

       */
      body: Consumer<NewsViewModel>(
        builder: (context, provider, child) {
          return provider.loadingNews
              ? Center(
              child: CircularProgressIndicator(
                color: Color(0xfff77109B),
              ))
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              controller: _controller,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: Container(
                    height: 50,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.categoriesList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              height: 50,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    onSelected(index);
                                  });
                                  if (selectIndex != index - 1) {
                                    page = 1;
                                    newsViewModel.getNews(page,
                                        '${provider.categoriesList[index].ocId}');
                                    ocId = provider
                                        .categoriesList[index].ocId;
                                  }
                                },
                                child: Card(
                                    color: selectIndex != null &&
                                        selectIndex == index
                                        ? Color(0xFF862aa6)
                                        : Theme.of(context).buttonColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(7),
                                          child: Row(
                                            children: [
                                              CircleAvatar(radius: 8,),
                                              SizedBox(width: 6,),
                                              Text(
                                                provider.categoriesList[index].name,
                                                style: TextStyle(
                                                    fontFamily: 'Vazirmatn',
                                                    color: selectIndex != null &&
                                                        selectIndex == index
                                                        ? Colors.white
                                                        : Theme.of(context).colorScheme.secondary,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                        ))),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              children: <Widget>[
                0 == provider.newsList.length
                    ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SpinKitThreeBounce(
                        color: Theme.of(context).primaryColor,
                        size: 25,
                      ),
                    ))
                    : Container(
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
                                    "https://www.eplworld.com${provider.newsList[0].url}",
                                  )));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(16)),
                      child: Stack(
                        children: [
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                      height: 220,
                                      child: new ClipRRect(
                                        child:
                                        Image.network(
                                          provider
                                              .newsList[
                                          0]
                                              .imageJPG,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment:MainAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                          height: 220,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: Color(0xFF77109B).withOpacity(0.4),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                  children: [
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.only(left: 15, right: 15),
                                                        child: Text(
                                                          provider.newsList[0].title,
                                                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),
                                                          overflow: TextOverflow.clip,
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 12, right: 15, bottom: 8),
                                                child: Row(
                                                  children: <Widget>[
                                                    SizedBox(width: 5,),
                                                    Text(
                                                      provider.newsList[0].username,
                                                      style: TextStyle(color: Colors.grey[100],fontSize: 13),
                                                    ),
                                                    SizedBox(width: 5,),
                                                    Text("- ${provider.newsList[0].date.tr} - ${provider.newsList[0].time.tr}",
                                                      style: TextStyle(color: Colors.grey[100],fontSize: 13),
                                                      overflow: TextOverflow.clip,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                      )
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
                Padding(
                  padding: const EdgeInsets.only(top: 6,bottom: 6),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 3,top: 3),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => webView(
                                          url:
                                          "https://www.eplworld.com${provider.newsList[index].url}",
                                        )));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.32,
                                    height: 100,
                                    child: new ClipRRect(
                                      child: Image.network(
                                        provider.newsList[index].imageJPG,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius:BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8)),
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width*.57,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              provider.newsList[index].title,
                                              style: TextStyle(fontFamily: 'Vazirmatn', fontSize: 14, fontWeight: FontWeight.w500),
                                              overflow: TextOverflow.clip ,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                provider.newsList[index].username,
                                                style: TextStyle(
                                                    fontFamily: 'Vazirmatn',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(width: 4,),
                                              Text(
                                                " ${provider.newsList[index].date} - ${provider.newsList[index].time} ".tr,
                                                style: TextStyle(
                                                    fontFamily: 'Vazirmatn',
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
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6,bottom: 6),
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: provider.newsList.length + 1,
                    itemBuilder: (BuildContext context, index) {
                      // print( provider.newsList[0].url);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          children: <Widget>[
                            index == provider.newsList.length
                                ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SpinKitThreeBounce(
                                    color: Theme.of(context).primaryColor,
                                    size: 25,
                                  ),
                                ))
                                : Container(
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
                                                "https://www.eplworld.com${provider.newsList[index].url}",
                                              )));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(16)),
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8)
                                                  ),
                                                  height: 220,
                                                  child: new ClipRRect(
                                                    child:
                                                    Image.network(
                                                      provider
                                                          .newsList[
                                                      index]
                                                          .imageJPG,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:MainAxisAlignment.end,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                  child: Container(
                                                      height: 220,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        color: Color(0xFF77109B).withOpacity(0.4),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Row(
                                                              children: [
                                                                Flexible(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.only(left: 15, right: 15),
                                                                    child: Text(
                                                                      provider.newsList[index].title,
                                                                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),
                                                                      overflow: TextOverflow.clip,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                          Padding(
                                                            padding: const EdgeInsets.only(
                                                                top: 12, right: 15, bottom: 8),
                                                            child: Row(
                                                              children: <Widget>[
                                                                SizedBox(width: 5,),
                                                                Text(
                                                                  provider.newsList[index].username,
                                                                  style: TextStyle(color: Colors.grey[100],fontSize: 13),
                                                                ),
                                                                SizedBox(width: 5,),
                                                                Text("- ${provider.newsList[index].date.tr} - ${provider.newsList[index].time.tr}",
                                                                  style: TextStyle(color: Colors.grey[100],fontSize: 13),
                                                                  overflow: TextOverflow.clip,
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                  )
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
