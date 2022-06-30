import 'package:get/get.dart';

import '../model/hindimovies.dart';
import '../model/services/hindimovies_fetcher.dart';

class SearchController extends GetxController {
  // final String query;
  List<HindiMovies> movies = <HindiMovies>[].obs;
  RxBool isLoading = true.obs;
  int page = 1;
  HindiMoviesFetcher fetcher = HindiMoviesFetcher();
  // SearchController(this.query);

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  // }

  // @override
  // void onInit() {
  //   fetchMovies();
  //   super.onInit();
  //   print('SearchController onInit');
  // }

  Future<void> fetchMovies(String query) async {
    try {
      movies.clear();
      print(
          "https://tormovie.online/apis/search/doubbed_search.php?search-term=$query&page=$page");
      isLoading(true);
      movies.addAll(await fetcher.fetchTheMovieFlix(
          "https://tormovie.online/apis/search/doubbed_search.php?search-term=$query&page=$page"));
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
      fetcher.clearData();
    }
  }
}
