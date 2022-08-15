import 'package:arseli/Models/Leagues/Tournaments.dart';
import 'package:arseli/webView.dart';
import 'package:arseli/Provider/EachLeagueViewModel.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../trendingData.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class leagueNews extends StatefulWidget {
  String url;
  leagueNews({this.url});
  @override
  _leagueNewsState createState() => _leagueNewsState();
}

class _leagueNewsState extends State<leagueNews> {
  EachLeagueViewModel oneLeagueViewModel;
  TextStyle headline = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  TextStyle headline2 = TextStyle(fontSize: 12, color: Colors.grey);
  ScrollController _controller = ScrollController();
  int page =1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      oneLeagueViewModel = Provider.of(context, listen: false);
      oneLeagueViewModel.getNews(widget.url, 'news',page,);

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EachLeagueViewModel>(
      builder: (context,provider,child){
        return provider.loadingNews
            ?Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,),),
        )
            : Container(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount:provider.newsModelList.length??0,
                itemBuilder: (BuildContext context, index) {
                  return Column(
                    children: <Widget>[
                      /*
                      index==provider.newsModelList.length
                          ?Center(child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SpinKitThreeBounce(color: Theme.of(context).primaryColor,size: 25,),
                      ))
                      :
                       */
                          Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder:(context)=>webView(url: "https://www.eplworld.com${provider.newsModelList[index].url}",)));
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 4, right: 4, top: 5),
                                child: new Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                                  semanticContainer: true,
                                  elevation: 0.6,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(right: 0.0),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width*0.95,
                                              height: 200,
                                              child: new ClipRRect(
                                                  child: Image.network(
                                                    provider.newsModelList[index].imageJPG,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(12),
                                                      topRight: Radius.circular(12))),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 15, right: 15),
                                        child: Text(
                                          provider.newsModelList[index].title,
                                          style: headline,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12, right: 15, bottom: 8),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              MdiIcons.soccer,
                                              size: 15.0,
                                            ),
                                            SizedBox(width: 5,),
                                            Text(
                                              provider.newsModelList[index].username,
                                              style: headline2,
                                            ),
                                            SizedBox(width: 5,),
                                            Text("- ${provider.newsModelList[index].date.tr} - ${provider.newsModelList[index].time.tr}",
                                              style: headline2,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),


                    ],
                  );
                },
              ),
            );
      },
    );
  }
}
