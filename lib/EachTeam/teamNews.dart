import 'package:arseli/Models/EachTeam/TableModel.dart';
import 'package:arseli/webView.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../trendingData.dart';

class TeamNews extends StatefulWidget {
  String url;
  TeamNews({this.url});

  @override
  _TeamNewsState createState() => _TeamNewsState();
}

class _TeamNewsState extends State<TeamNews> {
  EachTeamViewModel eachTeamViewModel;
  ScrollController _controller = ScrollController();
  int page = 1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eachTeamViewModel = Provider.of(context, listen: false);
      eachTeamViewModel.getNews("${widget.url}/news", page);

      //print(oneLeagueViewModel.newsModelList[0].date);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EachTeamViewModel>(
      builder: (context, provider, child) {
        return provider.loadingNews
            ? Padding(
                padding: EdgeInsets.only(top: 35),
                child: Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor),
                ))
            : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: provider.newsModelList.length,
                itemBuilder: (BuildContext context, index) {
                  return Column(
                    children: <Widget>[
                      /*
                      index == provider.newsModelList.length
                          ? Center(
                              child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SpinKitThreeBounce(
                                color: Theme.of(context).primaryColor,
                                size: 25,
                              ),
                            ))
                            :
                       */
                           Container(
                              width: MediaQuery.of(context).size.width,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => webView(
                                                url:
                                                    "https://www.eplworld.com${provider.newsModelList[index].url}",
                                              )));
                                },
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: new Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.95,
                                                height: 200,
                                                child: new ClipRRect(
                                                  child: Image.network(
                                                    provider
                                                        .newsModelList[index]
                                                        .imageJPG,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Text(
                                              provider
                                                  .newsModelList[index].title,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12, right: 15),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  MdiIcons.soccer,
                                                  size: 15.0,
                                                ),
                                                Text(
                                                  provider.newsModelList[index]
                                                      .username,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                  "${provider.newsModelList[index].date} - ${provider.newsModelList[index].time}"
                                                      .tr,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
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
              );
      },
    );
  }
}
