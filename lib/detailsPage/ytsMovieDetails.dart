import 'dart:async';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controller/details_controller/hindi_doubbed_details.dart';
import '../model/ads/InterstitialAd.dart';
import '../model/yts_movies.dart';
import '../template/ImageWithLoader.dart';
import '../template/cmovies_list_template.dart';
import '../template/custom_loading_indicator.dart';
import '../template/custom_reload_button.dart';
import '../template/yts_movie_template.dart';
import '../utility.dart';


class YTSDetailsPage extends StatelessWidget {
  final String link;
  late YTSDetailsController _ytsDetailsController;

  YTSDetailsPage(this.link, {Key? key}) : super(key: key) {
    _ytsDetailsController = Get.put(YTSDetailsController(link), tag: link);
   
  }

  @override
  Widget build(BuildContext context) {
    //  MyInterstitialAd.showAd();
    return Obx(
      () => SafeArea(
        child: Scaffold(
          body: _ytsDetailsController.isLoading.value
              ? const CustomLoadingIndicator()
              : _ytsDetailsController.data.isEmpty
                  ? CustomReloadButton(
                      () => _ytsDetailsController.getData(),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ImageWithLoader(
                              "${_ytsDetailsController.data['image']}"),

                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Text(
                              _ytsDetailsController.data['title'],
                              style: const TextStyle(
                                fontSize: 25,
                                // fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Text(
                              "${_ytsDetailsController.data['summary']}",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          // const FaceNv(),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Column(
                              children: [
                                const CMoviesListTemplate(
                                    "\u25A0", "Type:", 'Movie'),
                                CMoviesListTemplate(
                                  "\u25A0",
                                  "Release:",
                                  "${_ytsDetailsController.data['year']}",
                                ),
                                CMoviesListTemplate("\u25A0", "Genre:",
                                    _ytsDetailsController.data['genres'] ?? ""),
                                CMoviesListTemplate(
                                  "\u25A0",
                                  "Director:",
                                  _ytsDetailsController.data['director'] ?? "",
                                ),
                                CMoviesListTemplate("\u25A0", "IMDB:",
                                    "${_ytsDetailsController.data['imdbRating']}"),
                                CMoviesListTemplate(
                                  "\u25A0",
                                  "Language:",
                                  _ytsDetailsController.data['language'] ?? "",
                                ),
                                CMoviesListTemplate("\u25A0", "Duration:",
                                    "${_ytsDetailsController.data['runtime']} min"),
                                const CMoviesListTemplate(
                                  "\u25A0",
                                  "Quality:",
                                  "720 P",
                                ),
                              ],
                            ),
                          ),

                          // NativeAds(),
                          for (var torrents
                              in _ytsDetailsController.data['torrents'])
                            Card(
                              margin: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    torrents['quality'],
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                  Text(
                                    torrents['type'].toString().toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "Size: ${torrents['size']}".toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          primary: const Color(0xFFC82333),
                                          elevation: 5,
                                          shadowColor: Colors.blue,
                                        ),
                                        onPressed: () {
                                          Utility.launchMyUrl(
                                              torrents['hashLink'], context);
                                        },
                                        icon: const Icon(Icons.download),
                                        label: const Text("Download"),
                                      ),
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          primary: const Color(0xFFC82333),
                                          elevation: 5,
                                          shadowColor: Colors.blue,
                                        ),
                                        onPressed: () {
                                          Clipboard.setData(
                                            ClipboardData(
                                              text: torrents['hashLink'],
                                            ),
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                "Magnet url Copied to Clipboard"),
                                          ));
                                        },
                                        icon: const Icon(Icons.copy),
                                        label: const Text("Copy Link"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 100),
                          const Text(
                            "Similar Movies:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                          GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              primary: false,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 356 - 38,
                              ),
                              itemCount: _ytsDetailsController
                                  .data['similarList'].length,
                              itemBuilder: (_, index) {
                                // print(_movie['similarList'][index]['link']);
                                return YTSMoviesTemplate(
                                  YTSMovies.fromJson(_ytsDetailsController
                                      .data['similarList'][index]),
                                );
                              }),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
