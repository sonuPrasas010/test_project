import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'controller/cmovies_controller.dart';
import 'controller/yts_movies_controller.dart';
import 'template/custom_loading_indicator.dart';
import 'template/custom_reload_button.dart';
import 'template/yts_movie_template.dart';

class TorrentList extends StatelessWidget {
  final YTSMoviesController _yTSMoviesController =
      Get.put(YTSMoviesController());

  final PageStorageKey<String> _pageStorageKey = const PageStorageKey("torrent");

  @override
  Widget build(BuildContext context) {
    // _yTSMoviesController.fetchYtsMovies();
    return Scaffold(
      body: Obx(
        () => CustomScrollView(
          key: _pageStorageKey,
          controller: _yTSMoviesController.scrollController,
          slivers: [
            if (_yTSMoviesController.isLoading.value &&
                _yTSMoviesController.ytsMoviesList.isEmpty)
              const SliverFillRemaining(child: CustomLoadingIndicator()),
            if (_yTSMoviesController.isLoading.isFalse &&
                _yTSMoviesController.ytsMoviesList.isEmpty)
              SliverFillRemaining(
                child: CustomReloadButton(() {
                  _yTSMoviesController.fetchYtsMovies();
                }),
              ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                mainAxisExtent: 302,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => YTSMoviesTemplate(
                  _yTSMoviesController.ytsMoviesList[index],
                ),
                childCount: _yTSMoviesController.ytsMoviesList.length,
              ),
            ),
            if (_yTSMoviesController.isLoading.value ||
                _yTSMoviesController.ytsMoviesList.isNotEmpty)
              const SliverToBoxAdapter(
                child: SizedBox(
                    height: 20,
                    child: FittedBox(child: CustomLoadingIndicator())),
              )
          ],
        ),
      ),
    );
  }
}
