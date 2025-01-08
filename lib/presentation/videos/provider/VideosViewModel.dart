


import 'package:epl/domain/models/News.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Data/RequestHandler.dart';
import '../../../Data/StateModel.dart';

final videosProvider = StateNotifierProvider<VideosNotifier,StateModel<List<NewsModel>>>((ref) => VideosNotifier(ref));



class VideosNotifier extends StateNotifier<StateModel<List<NewsModel>>>{
  Ref ref;
  VideosNotifier(this.ref):super(StateModel.loading());
  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;

  Future<void> getVideos(int page, {bool isLoadMore = false}) async {
    RequestHandler requestHandler = RequestHandler();
    List<NewsModel> newVideos;
    Map<String, dynamic> body;

    try {
      body = {
        "amount": 20,
        "page": page,
      };

      if (!isLoadMore) {
        state = StateModel.loading();
      }

      newVideos = await requestHandler.postData(
        endPoint: "soccer/news/videos",
        auth: true,
        requestBody: body,
        fromJson: (json) => NewsModel.listFromJson(json),
      );

      if (newVideos.isNotEmpty) {
        if (isLoadMore) {
          List<NewsModel> updatedVideos = List.from(state.data ?? [])..addAll(newVideos);
          state = StateModel.paginate(updatedVideos);
        } else {
          state = StateModel.paginate(newVideos);
        }
      } else if (isLoadMore) {
        state = StateModel.success(state.data);
      } else {
        state = StateModel.fail("No data available.");
      }
    } catch (e) {
      state = StateModel.fail("Failed to get data: $e");
    }
  }

}