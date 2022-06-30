import 'dart:async';

import 'package:c_movies/torrentList.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'cmoviesList.dart';
import 'controller/home_movies_controller.dart';
import 'detailsPage/cmoviesDetails.dart';
import 'detailsPage/ytsMovieDetails.dart';
import 'template/custom_loading_indicator.dart';

class Home extends StatelessWidget {
  final HomeMoviesController _homeMoviesController =
      Get.put(HomeMoviesController(), tag: "home");
  final PageStorageKey<String> pageStorageKey = const PageStorageKey('home');

  @override
  Widget build(BuildContext context) {
    return
        /*_homeMoviesController.ytsMovies.isEmpty &&
                _homeMoviesController.cinemaMovies.isEmpty &&
                _homeMoviesController.hindiMovies.isEmpty
            ?*/ /*ElevatedButton(
                onPressed: getMovies,
                child: Text(
                  "data",
                ),
              ) */
        /*  CustomReloadButton(() {
                _homeMoviesController.getHomeMovies();
              })
            :*/
        Obx(
      () => RefreshIndicator(
        onRefresh: () async {
          _homeMoviesController.cinemaMovies.clear();
          // _homeMoviesController.hindiMovies.clear();
          _homeMoviesController.tvSeries.clear();
          _homeMoviesController.ytsMovies.clear();
          _homeMoviesController.sliderMovies.clear();
          _homeMoviesController.getHomeMovies();
        },
        child: CustomScrollView(
          key: pageStorageKey,
          slivers: [
            if (_homeMoviesController.isLoading.value)
              const SliverFillRemaining(child: CustomLoadingIndicator()),
            SliverToBoxAdapter(
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: [
                  for (var item in _homeMoviesController.sliderMovies)
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => CMoviesDetails(item.link),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  item.image,
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            bottom: -5,
                            right: 5,
                            child: Icon(
                              Icons.play_circle_fill,
                              color: Colors.red,
                              size: 50,
                            ),
                          ),
                          Text(
                            item.title,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.all(10),
            //     child: Column(
            //       children: <Widget>[
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             const Text(
            //               "On Torrent",
            //               style: TextStyle(fontSize: 20, color: Colors.white),
            //             ),
            //             TextButton(
            //               onPressed: () {
            //                 Get.to(TorrentList());
            //               },
            //               child: const Text(
            //                 "View All",
            //                 style: TextStyle(
            //                   fontSize: 20,
            //                   color: Color(
            //                     0xff4B97C5,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //         SizedBox(
            //           height: 250,
            //           child: ListView.builder(
            //             scrollDirection: Axis.horizontal,
            //             itemCount: _homeMoviesController.ytsMovies.length,
            //             itemBuilder: (_, index) => GestureDetector(
            //               onTap: () => Get.to(
            //                 () => YTSDetailsPage(
            //                   _homeMoviesController.ytsMovies[index].link,
            //                 ),
            //               ),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Padding(
            //                     padding: const EdgeInsets.only(
            //                       right: 10,
            //                       bottom: 10,
            //                       top: 20,
            //                     ),
            //                     child: SizedBox(
            //                       height: 150,
            //                       width: 120,
            //                       child: ClipRRect(
            //                         borderRadius: BorderRadius.circular(5),
            //                         child: Image.network(
            //                           // "lib/assets/images/the-sinner-2017.png",
            //                           _homeMoviesController
            //                               .ytsMovies[index].image,
            //                           height: 150,
            //                           width: 120,
            //                           fit: BoxFit.cover,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     width: 120,
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(bottom: 10),
            //                       child: Text(
            //                         _homeMoviesController
            //                             .ytsMovies[index].title,
            //                         textAlign: TextAlign.start,
            //                         maxLines: 1,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: TextStyle(
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: 15,
            //                             color: Colors.grey[400]),
            //                       ),
            //                     ),
            //                   ),
            //                   const Padding(
            //                     padding: EdgeInsets.only(bottom: 5),
            //                     child: Text(
            //                       "HD",
            //                       textAlign: TextAlign.start,
            //                       maxLines: 1,
            //                       overflow: TextOverflow.ellipsis,
            //                       style: TextStyle(
            //                           // fontWeight: FontWeight.bold,
            //                           fontSize: 12,
            //                           color: Colors.grey),
            //                     ),
            //                   ),
            //                   // MyRatingBar(_ytsMovies[index].rating),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.all(10),
            //     child: Column(
            //       children: <Widget>[
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             const Text(
            //               "Hindi dobbed",
            //               style: TextStyle(fontSize: 20, color: Colors.white),
            //             ),
            //             TextButton(
            //               onPressed: () {
            //                 Get.to(
            //                   () => HindiDobbedList(),
            //                 );
            //               },
            //               child: const Text(
            //                 "View All",
            //                 style: TextStyle(
            //                     fontSize: 20, color: Color(0xff4B97C5)),
            //               ),
            //             ),
            //           ],
            //         ),
            //         SizedBox(
            //           height: 260,
            //           child: ListView.builder(
            //             scrollDirection: Axis.horizontal,
            //             itemCount: _homeMoviesController.hindiMovies.length,
            //             itemBuilder: (_, index) => TextButton(
            //               onPressed: () {
            //                 Get.to(
            //                   () => HindiDobbedDetails(
            //                     _homeMoviesController.hindiMovies[index].link,
            //                   ),
            //                 );
            //               },
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Padding(
            //                     padding: const EdgeInsets.only(
            //                       right: 10,
            //                       bottom: 10,
            //                       top: 20,
            //                     ),
            //                     child: SizedBox(
            //                       height: 150,
            //                       width: 120,
            //                       child: ClipRRect(
            //                         borderRadius: BorderRadius.circular(5),
            //                         child: Image.network(
            //                           // "lib/assets/images/the-sinner-2017.png",
            //                           _homeMoviesController
            //                               .hindiMovies[index].image,
            //                           height: 150,
            //                           width: 120,
            //                           fit: BoxFit.cover,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     width: 120,
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(bottom: 10),
            //                       child: Text(
            //                         _homeMoviesController
            //                             .hindiMovies[index].title,
            //                         textAlign: TextAlign.start,
            //                         maxLines: 1,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: const TextStyle(
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: 15,
            //                             color: Colors.grey),
            //                       ),
            //                     ),
            //                   ),
            //                   const Padding(
            //                     padding: EdgeInsets.only(bottom: 5),
            //                     child: Text(
            //                       "Hd Cam",
            //                       textAlign: TextAlign.start,
            //                       maxLines: 1,
            //                       overflow: TextOverflow.ellipsis,
            //                       style: TextStyle(
            //                           // fontWeight: FontWeight.bold,
            //                           fontSize: 12,
            //                           color: Colors.grey),
            //                     ),
            //                   ),
            //                   // MyRatingBar(Random().nextInt(5).toDouble()),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            if (!_homeMoviesController.isLoading.value)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Popular Movies",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () => Get.to(
                              () => CMoviesList("movie", "latest"),
                            ),
                            child: const Text(
                              "View All",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff4B97C5),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _homeMoviesController.cinemaMovies.length,
                          itemBuilder: (_, index) => TextButton(
                            onPressed: () {
                              Get.to(
                                () => CMoviesDetails(
                                  _homeMoviesController
                                      .cinemaMovies[index].link,
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 10,
                                    bottom: 10,
                                    top: 20,
                                  ),
                                  child: SizedBox(
                                    height: 150,
                                    width: 120,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                        // "lib/assets/images/the-sinner-2017.png",
                                        _homeMoviesController
                                            .cinemaMovies[index].image,
                                        height: 150,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      _homeMoviesController
                                          .cinemaMovies[index].title,
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    _homeMoviesController
                                        .cinemaMovies[index].epOrQuality,
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.grey),
                                  ),
                                ),
                                // RatingBar.builder(
                                //   initialRating: 3,
                                //   minRating: 1,
                                //   direction: Axis.horizontal,
                                //   allowHalfRating: true,
                                //   itemCount: 5,
                                //   itemSize: 12,
                                //   maxRating: 5,
                                //   unratedColor: Color(0xFF05478D),
                                //   ignoreGestures: true,
                                //   itemPadding:
                                //       EdgeInsets.symmetric(horizontal: 0.5),
                                //   itemBuilder: (context, _) => Icon(
                                //     Icons.star,
                                //     color: Color(0xff4B97C5),
                                //   ),
                                //   onRatingUpdate: (rating) {
                                //     print(rating);
                                //   },
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Tv Shows",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(
                              CMoviesList("cinema-movies", "cimes"),
                            );
                          },
                          child: const Text(
                            "View All",
                            style: TextStyle(
                                fontSize: 20, color: Color(0xff4B97C5)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _homeMoviesController.tvSeries.length,
                          itemBuilder: (_, index) {
                            return TextButton(
                              onPressed: () {
                                Get.to(() => CMoviesDetails(
                                    _homeMoviesController
                                        .tvSeries[index].link));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 10,
                                      bottom: 10,
                                      top: 20,
                                    ),
                                    child: SizedBox(
                                      height: 150,
                                      width: 120,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          // "lib/assets/images/the-sinner-2017.png",
                                          _homeMoviesController
                                              .tvSeries[index].image,
                                          height: 150,
                                          width: 120,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: SizedBox(
                                      width: 120,
                                      child: Text(
                                        _homeMoviesController
                                            .tvSeries[index].title,
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      "Episode:  ${_homeMoviesController.tvSeries[index].epOrQuality}",
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
