import 'package:epl/Data/StateModel.dart';
import 'package:epl/presentation/team/provider/TeamViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/Utils/date_converter.dart';
import '../../../shared/Views/custom/custom_loader.dart';
import '../../../webView.dart';


class VideoTeam extends ConsumerStatefulWidget {
  String? url;
  VideoTeam({this.url});
  @override
  _VideoTeamState createState() => _VideoTeamState();
}

class _VideoTeamState extends ConsumerState<VideoTeam> {
  ScrollController _controller = ScrollController();
  int page = 1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var videos = ref.watch(teamVideosProvider);

    return videos.handelState(
        onLoading: (state) => CustomLoader(),
        onSuccess: (state) => Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: videos.data!.length,
            itemBuilder: (BuildContext context, index) {
              var item = videos.data![index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> WebView(url: "https://www.youtube.com/watch?v=${item.videoId}")));

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
                                    item.urlToImage,
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
                            height: 110,
                            width: MediaQuery.of(context).size.width*.58,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      item.title,
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
                                      Flexible(
                                        child: Text(item.channelTitle,
                                            style: Theme.of(context).textTheme.bodySmall
                                        ),
                                      ),
                                      SizedBox(width: 4,),
                                      Text(DateConverter.timeAgoSinceDate(item.publishedAt),
                                          style: Theme.of(context).textTheme.bodySmall
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
        onFailure: (state) => Text("SHIT")
    );
  }
}
