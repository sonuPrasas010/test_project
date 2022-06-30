import 'package:get/get.dart';

import 'package:flutter/material.dart';

import 'controller/cmovies_controller.dart';
import 'detailsPage/cmoviesDetails.dart';
import 'template/cmovies_template.dart';
import 'template/custom_loading_indicator.dart';
import 'template/custom_reload_button.dart';

class CMoviesList extends StatelessWidget {
  final String type;
  final String tag;
  late CMoviesController _cMoviesController;
  CMoviesList(this.type, this.tag, {Key? key}) : super(key: key) {
    _cMoviesController = Get.put(CMoviesController(type), tag: tag);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => CustomScrollView(
          key: PageStorageKey(type),
          controller: _cMoviesController.scrollController,
          slivers: [
            if (_cMoviesController.isLoading.value &&
                _cMoviesController.cMoviesList.isEmpty)
              const SliverToBoxAdapter(
                  child:
                      SizedBox(height: 400, child: CustomLoadingIndicator())),
            if (_cMoviesController.isLoading.isFalse &&
                _cMoviesController.cMoviesList.isEmpty)
              SliverFillRemaining(
                child: CustomReloadButton(() {
                  _cMoviesController.fetchCMovies();
                }),
              ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                mainAxisExtent: 250,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                 
                  return CMoviesTemplate(
                    fit: BoxFit.cover,
                    eqOrQuality:
                        _cMoviesController.cMoviesList[index].epOrQuality,
                    image: _cMoviesController.cMoviesList[index].image,
                    title: _cMoviesController.cMoviesList[index].title,
                    onClick: () => Get.to(
                      () => CMoviesDetails(
                        _cMoviesController.cMoviesList[index].link,
                      ),
                      preventDuplicates: false,
                    ),
                  );
                },
                childCount: _cMoviesController.cMoviesList.length,
              ),
            ),
            if (_cMoviesController.isLoading.value &&
                _cMoviesController.cMoviesList.isNotEmpty)
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
