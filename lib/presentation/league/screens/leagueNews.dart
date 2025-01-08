
import 'package:epl/Data/StateModel.dart';
import 'package:epl/presentation/league/provider/LeagueViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/Utils/date_converter.dart';
import '../../../shared/Views/custom/custom_loader.dart';


class leagueNews extends ConsumerStatefulWidget {
  String? url;
  leagueNews({this.url});
  @override
  _leagueNewsState createState() => _leagueNewsState();
}

class _leagueNewsState extends ConsumerState<leagueNews> {
  TextStyle headline = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 14, fontWeight: FontWeight.w500);
  TextStyle titleMedium =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 12, color: Colors.grey);
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
    var news =ref.watch(LeagueNewsProvider);

    return news.handelState(
        onLoading: (state)=> CustomLoader(),
        onSuccess: (state)=> Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: news.data!.length,
            itemBuilder: (BuildContext context, index) {
              var item = news.data![index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  children: <Widget>[
                    // index == 5
                    //     ? Center(
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(10.0),
                    //       child: SpinKitThreeBounce(
                    //         color: Theme.of(context).primaryColor,
                    //         size: 25,
                    //       ),
                    //     ))
                    //     :
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             webView(
                          //               url:
                          //               "https://www.eplworld.com${provider.newsModelList[index].url}",
                          //             )));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Stack(
                            children: [
                              Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8)
                                          ),
                                          height: 220,
                                          child: new ClipRRect(
                                            child:
                                            Image.network(item.urlToImage,
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
                                                color: Theme.of(context).primaryColor.withOpacity(0.3),
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets.only(left: 15, right: 15,top: 12),
                                                      child: Text(
                                                        item.title,
                                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w600),
                                                        overflow: TextOverflow.clip,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 12, right: 15, bottom: 8),
                                                    child: Row(
                                                      children: <Widget>[
                                                        SizedBox(width: 5,),
                                                        Text(
                                                          item.author,
                                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13,color: Colors.white),
                                                        ),
                                                        SizedBox(width: 5,),
                                                        Text(DateConverter.timeAgoSinceDate(item.publishedAt),
                                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13,color: Colors.white),
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
        onFailure: (state)=>  Text("SHTt")
    );

  }
}
