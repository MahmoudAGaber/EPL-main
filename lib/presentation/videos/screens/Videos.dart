
import 'package:epl/Data/StateModel.dart';
import 'package:epl/presentation/videos/provider/VideosViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../shared/Utils/date_converter.dart';
import '../../../shared/Views/custom/custom_loader.dart';


class Videos extends ConsumerStatefulWidget {
  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends ConsumerState<Videos> with SingleTickerProviderStateMixin {

  int page = 1;

  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool hasMoreData = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {

      _scrollController.addListener(() {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !isLoading) {
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
      await ref.read(videosProvider.notifier).getVideos(ref.watch(videosProvider.notifier).currentPage, isLoadMore: true);
      setState(() {
        isLoading = false;
        ref.watch(videosProvider.notifier).currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var videos = ref.watch(videosProvider);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        title: Padding(
          padding: const EdgeInsets.only(right: 0),
          child: Row(
            children: <Widget>[
              Text(
                "الفيديوهات".tr,
                style: TextStyle(fontFamily: 'Vazirmatn', color: Colors.white,fontSize: 20),
              )
            ],
          ),
        ),
      ),

        body: videos.handelState(
          onLoading: (state)=> CustomLoader(),
          onFailure: (state)=>  Text("FAILD"),
          onSuccess: (state)=> Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
          controller: _scrollController,
          itemCount: videos.data!.length + (isLoading ? 1 : 0),
          itemBuilder: (BuildContext context, int index) {
            if (index == videos.data!.length) {
              return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SpinKitThreeBounce(
                      color: Theme.of(context).primaryColor,
                      size: 25,
                    ),
                  ));

            }
            var video = videos.data![index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      // Navigate to video details page
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
                                        video.urlToImage,
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
                                      video.title,
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
                                    video.channelTitle,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
                                  ),
                                  SizedBox(width: 5),
                                  Text(DateConverter.timeAgoSinceDate(video.publishedAt),
                                      style: Theme.of(context).textTheme.bodySmall),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 85,
                    right: MediaQuery.of(context).size.width * 0.42,
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to video details
                      },
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),

          ),
        )

    );
  }
}
