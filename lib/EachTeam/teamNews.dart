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
            : Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: provider.newsModelList.length,
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
                                                "https://www.eplworld.com${provider.newsModelList[index].url}",
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
                                      provider.newsModelList[index].imageJPG,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8)),
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width*.59,
                                  child: Column(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            provider.newsModelList[index].title,
                                            style: Theme.of(context).textTheme.bodyText1,
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
                                              provider.newsModelList[index].username,
                                              style: Theme.of(context).textTheme.bodyText2,
                                            ),
                                            SizedBox(width: 4,),
                                            Text(
                                              " ${provider.newsModelList[index].date} - ${provider.newsModelList[index].time} ".tr,
                                              style: Theme.of(context).textTheme.bodyText2
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
            );
      },
    );
  }
}
