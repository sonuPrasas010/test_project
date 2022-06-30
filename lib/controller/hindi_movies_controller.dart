import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';



import '../model/hindimovies.dart';
import '../model/services/hindimovies_fetcher.dart';
import '../utility.dart';

class HindiMoviesController extends GetxController {
  String type;
  HindiMoviesController(this.type);
  int page = 1;
  final List<HindiMovies> hindiMoviesList = <HindiMovies>[].obs;
  var isLoading = true.obs;
  late ScrollController scrollController;

  final HindiMoviesFetcher _hindiMoviesFetcher = HindiMoviesFetcher();

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    getHindiMovies();
    scrollController = ScrollController();
    super.onInit();
    scrollController.addListener(() {
      if (Utility.checkScrollPosition(scrollController.position.pixels,
              scrollController.position.maxScrollExtent) &&
          !isLoading.value) {
        getHindiMovies();
      }
    });
  }

  Future<void> getHindiMovies() async {
    try {
      isLoading(true);
      hindiMoviesList.addAll(await _hindiMoviesFetcher.fetchHindiLinks4U(
          "https://tormovie.online/apis/doubbed_list.php?page=$page"));

      page++;
    } catch (e) {
      print(e);
      isLoading(false);
    } finally {
      _hindiMoviesFetcher.clearData();
      isLoading(false);
    }
  }
}
