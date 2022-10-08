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

class SubOfNews extends StatefulWidget {
  String ocId;
  SubOfNews({this.ocId});
  @override
  _SubOfNewsState createState() => _SubOfNewsState();
}

class _SubOfNewsState extends State<SubOfNews> with AutomaticKeepAliveClientMixin {


  NewsViewModel newsViewModel;
  int selectIndex = 0;
  int page = 0;
  String ocId = '1';
  bool loadVideos = false;
  TabController tabController;
  bool v = true;


  ScrollController _controller = ScrollController();

  @override
  void initState() {
    Timer(Duration(milliseconds: 100), () {});
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      newsViewModel = Provider.of(context, listen: false);
      newsViewModel.getNews(1,widget.ocId);

      _controller.addListener(() {
        if (_controller.position.pixels ==
            _controller.position.maxScrollExtent) {
          page++;
         // loadVideos = true;
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Consumer<NewsViewModel>(
          builder: (context,provider,child){
           return provider.loadingNews
               ?Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),)
               :Padding(
                 padding: const EdgeInsets.all(8.0),
                 child:  ListView.builder(
                   controller: _controller,
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
                                                       color: Color(0xFF77109B).withOpacity(0.2),
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
                                                                     style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 15,color: Colors.white),
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
                                                                   style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13,color: Colors.white70)
                                                               ),
                                                               SizedBox(width: 5,),
                                                               Text("- ${provider.newsList[index].date.tr} - ${provider.newsList[index].time.tr}",
                                                                 style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13,color: Colors.white70),
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
