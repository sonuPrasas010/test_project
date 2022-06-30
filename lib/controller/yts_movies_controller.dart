import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/services/yts_fetcher.dart';
import '../model/yts_movies.dart';
import '../utility.dart';
class YTSMoviesController extends GetxController {
  int page = 1;
  final List<YTSMovies> ytsMoviesList = <YTSMovies>[].obs;
  var isLoading = true.obs;
  ScrollController scrollController = ScrollController();

  final YTSFetcher _yTSMoviesFetcher = YTSFetcher();

  @override
  void onInit() {
    print("Yts Movies Controller initilized");
    scrollController = ScrollController();

    fetchYtsMovies();
    super.onInit();
    scrollController.addListener(() {
      if (Utility.checkScrollPosition(scrollController.position.pixels,
              scrollController.position.maxScrollExtent) &&
          !isLoading.value) {
        fetchYtsMovies();
      }
    });
  }

  Future<void> fetchYtsMovies() async {
    try {
      isLoading(true);
      ytsMoviesList.addAll(await _yTSMoviesFetcher.fetchYtsMovies(
          "https://tormovie.online/apis/torrentList.php?page=$page"));

      page++;
    } catch (e) {
      print(e);
    } finally {
      _yTSMoviesFetcher.clearData();
      isLoading(false);
    }
  }
}
