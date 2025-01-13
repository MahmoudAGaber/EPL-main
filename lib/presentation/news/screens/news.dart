import 'dart:async';

import 'package:epl/Data/StateModel.dart';
import 'package:epl/presentation/news/provider/NewsViewModel.dart';
import 'package:epl/presentation/news/screens/SubOfNews.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../shared/Utils/date_converter.dart';
import '../../../shared/Views/custom/custom_loader.dart';
import '../../../webView.dart';


class News extends ConsumerStatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends ConsumerState<News> with SingleTickerProviderStateMixin {

  int page = 1;

  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool hasMoreData = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {

      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent && !isLoading) {
          _loadMoreData();
        }
      });
    });
    super.initState();
  }

  Future<void> _loadMoreData() async {
    if (hasMoreData) {
      setState(() {
        isLoading = true;
      });
      await ref.read(newsProvider.notifier).getNews(ref
          .watch(newsProvider.notifier)
          .currentPage, isLoadMore: true);
      setState(() {
        isLoading = false;
        ref
            .watch(newsProvider.notifier)
            .currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var news = ref.watch(newsProvider);

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          title: Row(
            children: <Widget>[
              Text(
                "الأخبار".tr,
                style: TextStyle(fontFamily: 'Vazirmatn',
                    color: Colors.white,
                    fontSize: 20),
              )
            ],
          ),
        ),
        body: news.handelState(
          onLoading: (state)=> CustomLoader(),
          onFailure: (state)=>  Text("FAILD"),
          onSuccess: (state)=> Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: news.data!.length + (isLoading ? 1 : 0),
              itemBuilder: (BuildContext context, int index) {
                if (index == news.data!.length) {
                  return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SpinKitThreeBounce(
                          color: Theme.of(context).primaryColor,
                          size: 25,
                        ),
                      ));

                }
                var newsItem = news.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> WebView(url: newsItem.url)));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    height: 200,
                                    child: ClipRRect(
                                      child: Image.network(
                                        newsItem.urlToImage,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.85,
                                    child: Text(
                                      newsItem.title,
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12, right: 15),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    MdiIcons.soccer,
                                    size: 15.0,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    newsItem.author,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                  ),
                                  SizedBox(width: 5),
                                  Text(DateConverter.timeAgoSinceDate(newsItem.publishedAt),
                                      style: Theme.of(context).textTheme.bodySmall),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

          ),
        )

    );
  }
}


