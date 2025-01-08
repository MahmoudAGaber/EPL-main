import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ForYou extends StatefulWidget {
  @override
  _ForYouState createState() => _ForYouState();
}

class _ForYouState extends State<ForYou> {
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

      _controller.addListener(() {
        if (_controller.position.pixels ==
            _controller.position.maxScrollExtent) {
          page++;
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
      body: Consumer(
        builder: (context, provider, child) {
          return Padding(
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
                        itemCount: 5,
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
                                   // newsViewModel.getNews(page, '${provider.categoriesList[index].ocId}');
                                   // ocId = provider.categoriesList[index].ocId;
                                  }
                                },
                                child: Card(
                                    color: selectIndex != null &&
                                        selectIndex == index
                                        ? Color(0xFF862aa6)
                                        : Theme.of(context).cardColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(7),
                                          child: Row(
                                            children: [
                                              //CircleAvatar(radius: 8,),
                                              SizedBox(width: 6,),
                                              Text(
                                                "1",
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
                0 == 5
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
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             webView(
                      //               url:
                      //               "https://www.eplworld.com",
                      //             )));
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
                                          "",
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
                                                         "title",
                                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15,color: Colors.white),
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
                                                      "userName",
                                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13,color: Colors.white70)
                                                    ),
                                                    SizedBox(width: 5,),
                                                    Text("- data - time",
                                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13,color: Colors.white70),
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
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => webView(
                                //           url:
                                //           "https://www.eplworld.com",
                                //         )));
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
                                        "",
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
                                              "title",
                                              style: Theme.of(context).textTheme.bodyMedium,
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
                                                "userName",
                                                style: Theme.of(context).textTheme.bodySmall,
                                              ),
                                              SizedBox(width: 4,),
                                              Text(
                                                " data - time ".tr,
                                                style: Theme.of(context).textTheme.bodySmall,
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
                    itemCount: 5,
                    itemBuilder: (BuildContext context, index) {
                      // print( provider.newsList[0].url);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          children: <Widget>[
                            index == 5
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
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             webView(
                                  //               url:
                                  //               "https://www.eplworld.com",
                                  //             )));
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
                                                      "",
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
                                                                     "title",
                                                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15,color: Colors.white),
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
                                                                  "userName",
                                                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13,color: Colors.white70)
                                                                ),
                                                                SizedBox(width: 5,),
                                                                Text("- data - time",
                                                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13,color: Colors.white70),
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
