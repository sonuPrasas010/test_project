import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'controller/hindi_movies_controller.dart';
import 'controller/search_controller.dart';
import 'detailsPage/hindiDoubbedDetails.dart';
import 'detailsPage/hindiDoubbedSearchDetails.dart';
import 'template/custom_loading_indicator.dart';
import 'template/custom_reload_button.dart';
import 'template/search_template.dart';

class HindiDobbedList extends StatelessWidget {
  HindiMoviesController hindiMoviesController =
      Get.put(HindiMoviesController("type"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Hindi Doubbed Movies",
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                  query: "Sonu");
            },
            color: Colors.white,
          ),
        ],
      ),
      body: Obx(
        () => CustomScrollView(
          controller: hindiMoviesController.scrollController,
          slivers: [
            if (hindiMoviesController.isLoading.value &&
                hindiMoviesController.hindiMoviesList.isEmpty)
              const SliverFillRemaining(child: CustomLoadingIndicator()),
            if (hindiMoviesController.isLoading.isFalse &&
                hindiMoviesController.hindiMoviesList.isEmpty)
              SliverFillRemaining(
                child: CustomReloadButton(() {
                  hindiMoviesController.getHindiMovies();
                }),
              ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                mainAxisExtent: 340,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => InkWell(
                  onTap: () => Get.to(
                    () => HindiDobbedDetails(
                        hindiMoviesController.hindiMoviesList[index].link),
                  ),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            hindiMoviesController.hindiMoviesList[index].image,
                        height: 260,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          hindiMoviesController.hindiMoviesList[index].title,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                childCount: hindiMoviesController.hindiMoviesList.length,
              ),
            ),
            if (hindiMoviesController.isLoading.value ||
                hindiMoviesController.hindiMoviesList.isNotEmpty)
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

class CustomSearchDelegate extends SearchDelegate {
  final SearchController searchController = Get.put(SearchController());

  @override
  void close(BuildContext context, result) {
    super.close(context, result);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  void showResults(BuildContext context) async {
    searchController.fetchMovies(query);
    super.showResults(context);
  }

  @override
  Widget buildResults(BuildContext context) {
    return Obx(
      () => searchController.isLoading.value
          ? CustomLoadingIndicator()
          : searchController.movies.isEmpty
              ? CustomReloadButton(() => searchController.fetchMovies(query))
              : GridView.builder(
                  itemCount: searchController.movies.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    // maxCrossAxisExtent: 210.0,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                    childAspectRatio: 1.0,
                    mainAxisExtent: 300,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (_, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(10),

                        // color: Colors.white,
                      ),
                      child: SearchTemplate(
                        imageUrl: searchController.movies[index].image,
                        title: searchController.movies[index].title,
                        url: searchController.movies[index].link,
                        year: searchController.movies[index].title,
                        pag: () => HindiDobbedSearchDetails(
                          searchController.movies[index].link,
                        ),
                      ),
                    );
                  },
                ),
    );

    /* FutureBuilder<List<HindiMovies>>(
        future: HindiMoviesFetcher().fetchTheMovieFlix(query),
        builder: (_, snapshot) {
          printError(info: snapshot.error!.toString());

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomLoadingIndicator();
          }
          if (snapshot.hasError) {
            return CustomReloadButton(() => buildResults(context));
          }

          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (_, index) {
                return SearchTemplate(
                    imageUrl: snapshot.data![index].image,
                    title: snapshot.data![index].title,
                    url: snapshot.data![index].link,
                    year: snapshot.data![index].title,
                    pag: CMoviesDetails(snapshot.data![index].link));
              });
        });
        */
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
    /*ListView.builder(itemBuilder: (context, index) {
      return Text("dd");
    });*/
  }
}
