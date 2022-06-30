import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/cmovies.dart';
import '../model/services/cmovies_fetcher.dart';
import '../utility.dart';

class CMoviesController extends GetxController {
  String type;
  CMoviesController(this.type);
  int page = 1;
  List<CMovies> cMoviesList = <CMovies>[].obs;
  var isLoading = true.obs;
  late ScrollController scrollController;

  final CMoviesFetcher _cMoviesFetcher = CMoviesFetcher();
  @override
  void onInit() {
    fetchCMovies();
    scrollController = ScrollController();
    super.onInit();
    scrollController.addListener(() {
      if (Utility.checkScrollPosition(scrollController.position.pixels,
              scrollController.position.maxScrollExtent) &&
          !isLoading.value) {
        fetchCMovies();
      }
    });
  }

  Future<void> fetchCMovies() async {
    try {
       isLoading(true);
      cMoviesList.addAll(await _cMoviesFetcher.fetchCMovies(
          "https://tormovie.online/apis/cmovies.php?page=$page&type=$type"));

      page++;
    } catch (e) {
       print(e);
    } finally {
       _cMoviesFetcher.clearData();
      isLoading(false);
    }
  }
}
