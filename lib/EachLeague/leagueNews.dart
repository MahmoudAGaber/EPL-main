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
  TextStyle headline = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 14, fontWeight: FontWeight.w500);
  TextStyle headline2 =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 12, color: Colors.grey);
  ScrollController _controller = ScrollController();
  int page = 1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      oneLeagueViewModel = Provider.of(context, listen: false);
      oneLeagueViewModel.getNews(
        widget.url,
        'news',
        page,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EachLeagueViewModel>(
      builder: (context, provider, child) {
        return provider.loadingNews
            ? Center(
            child: CircularProgressIndicator(
              color: Color(0xfff77109B),
            ))
            : Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: provider.newsModelList.length + 1,
            itemBuilder: (BuildContext context, index) {
              // print( provider.newsList[0].url);
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  children: <Widget>[
                    index == provider.newsModelList.length
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
                                        "https://www.eplworld.com${provider.newsModelList[index].url}",
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
                                                  .newsModelList[
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
                                            color: Theme.of(context).primaryColor.withOpacity(0.4),
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
                                                          provider.newsModelList[index].title,
                                                          style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 15,color: Colors.white70),
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
                                                      provider.newsModelList[index].username,
                                                        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13,color: Colors.white70),
                                                    ),
                                                    SizedBox(width: 5,),
                                                    Text("- ${provider.newsModelList[index].date.tr} - ${provider.newsModelList[index].time.tr}",
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
    );
  }
}
