import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';



import '../model/services/DataFetcher.dart';
import '../utility.dart';
import '../model/cmovies.dart';
import '../model/yts_movies.dart';

class HomeMoviesController extends GetxController {
  int page = 1;
  final List<YTSMovies> ytsMovies = <YTSMovies>[].obs;
  final List<CMovies> cinemaMovies = <CMovies>[].obs;
  // final List<HindiMovies> hindiMovies = <HindiMovies>[].obs;
  final List<CMovies> sliderMovies = <CMovies>[].obs;
  final List<CMovies> tvSeries = <CMovies>[].obs;
  var isLoading = true.obs;
  late ScrollController scrollController;

  final DataFetcher _dataFetcher = DataFetcher();
  @override
  void onInit() {
    getHomeMovies();
    scrollController = ScrollController();
    super.onInit();
    scrollController.addListener(() {
      if (Utility.checkScrollPosition(scrollController.position.pixels,
              scrollController.position.maxScrollExtent) &&
          !isLoading.value) {
        getHomeMovies();
      }
    });
  }

  Future<void> getHomeMovies() async {
    try {
      isLoading(true);
      var e = await _dataFetcher.fetchHomeMovies(
          "https://tormovie.online/apis/home.php?page=$page&type=");

      sliderMovies.addAll(e['sliderList']);
      cinemaMovies.addAll(e['cinemaMovies']);
      // hindiMovies.addAll(e['hindiMovies']);
      ytsMovies.addAll(e['ytsMovies']);
      tvSeries.addAll(e['tvSeries']);

      page++;
    } catch (e) {
      print(e);
    
    } finally {
      isLoading(false);
    }
  }
}
