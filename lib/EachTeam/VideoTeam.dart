import 'package:arseli/webView.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../trendingData.dart';

class VideoTeam extends StatefulWidget {
  String url;
  VideoTeam({this.url});
  @override
  _VideoTeamState createState() => _VideoTeamState();
}

class _VideoTeamState extends State<VideoTeam> {
  EachTeamViewModel eachTeamViewModel;
  ScrollController _controller = ScrollController();
  int page = 1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eachTeamViewModel = Provider.of(context, listen: false);
      eachTeamViewModel.getVideos("${widget.url}/videos", 1);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EachTeamViewModel>(
      builder: (context, provider, child) {
        return provider.loadingVideos
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
            itemCount: provider.videoModelList.length,
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
                                  "https://www.eplworld.com${provider.videoModelList[index].url}",
                                )));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.32,
                                height: 100,
                                child: new ClipRRect(
                                  child: Image.network(
                                    provider.videoModelList[index].imgJPG,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius:BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8)),
                                ),
                              ),
                              Positioned(
                                right: MediaQuery.of(context).size.width*.12,
                                top: MediaQuery.of(context).size.width*.08,
                                child: Icon(Icons.play_arrow_rounded,color: Colors.white,size: 35,),
                              )
                            ],
                          ),
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width*.58,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      provider.videoModelList[index].title,
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
                                        provider.videoModelList[index].username,
                                        style: Theme.of(context).textTheme.bodyText2
                                      ),
                                      SizedBox(width: 4,),
                                      Text(
                                        " ${provider.videoModelList[index].date} - ${provider.videoModelList[index].date} ".tr,
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
