import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../controller/details_controller/hindi_doubbed_details.dart';
import '../model/ads/InterstitialAd.dart';
import '../template/ImageWithLoader.dart';
import '../template/cmovies_list_template.dart';
import '../template/cmovies_template.dart';
import '../template/custom_loading_indicator.dart';
import '../template/custom_reload_button.dart';
import '../utility.dart';
import '../webViewPlayer.dart';

class CMoviesDetails extends StatelessWidget {
  final String link;
  late YTSDetailsController _controller;
  CMoviesDetails(this.link, {Key? key}) : super(key: key) {
    _controller = Get.put(YTSDetailsController(link), tag: link);
  }

  @override
  Widget build(BuildContext context) {
    // MyInterstitialAd.showAd();
    return Obx(
      () => SafeArea(
        child: Scaffold(
          body: _controller.isLoading.value
              ? const CustomLoadingIndicator()
              : _controller.data.isEmpty
                  ? CustomReloadButton(() {
                      _controller.getData();
                      // Utility.launchURLWithCustomTabs(context,
                      //     'https://tormovie.online/apis/search/vidcloud_details.php?v=/videos/a-killer-among-friends-sd');
                    })
                  : SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ImageWithLoader(_controller.data['image']),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              child: Text(
                                _controller.data['title'],
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
                                _controller.data['synopsis'] ?? "",
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
                                  CMoviesListTemplate("\u25A0", "Type:",
                                      _controller.data['type'] ?? ""),
                                  CMoviesListTemplate(
                                    "\u25A0",
                                    "Release:",
                                    _controller.data['releaseDate'] ?? "",
                                  ),
                                  CMoviesListTemplate("\u25A0", "Genre:",
                                      _controller.data['genre'] ?? ""),
                                  CMoviesListTemplate(
                                    "\u25A0",
                                    "Director:",
                                    _controller.data['director'] ?? "",
                                  ),
                                  CMoviesListTemplate("\u25A0", "IMDB:",
                                      _controller.data['imdb'] ?? ""),
                                  CMoviesListTemplate(
                                    "\u25A0",
                                    "Country:",
                                    _controller.data['country'] ?? "",
                                  ),
                                  CMoviesListTemplate("\u25A0", "Duration:",
                                      _controller.data['duration'] ?? ""),
                                  CMoviesListTemplate(
                                    "\u25A0",
                                    "Quality:",
                                    _controller.data['quality'] ?? "",
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFFC82333),
                                    elevation: 5,
                                    shadowColor: Colors.blue,
                                  ),
                                  onPressed: () {
                                    Utility.launchMyUrl(
                                       
                                        _controller.data['downloadLink']
                                            .toString(), context,);
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
                                    // print("Episode " + _movie['currentEp']);
                                    Get.to(
                                      () => WebViewPlayer(
                                          url: _controller.data['iframe']),
                                    );
                                  },
                                  icon: const Icon(Icons.play_arrow),
                                  label: const Text("Play"),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 100,
                              // child: AdWidget(
                              //   ad: _controller.nativeAd,
                              // ),
                            ),
                            Wrap(
                              alignment: WrapAlignment.spaceEvenly,
                              children: [
                                for (var episode
                                    in _controller.data["episodeList"] ?? [])
                                  InkWell(
                                    onTap: ("Episode " +
                                                _controller
                                                    .data['currentEp']) !=
                                            episode['epName']
                                        ? () {
                                            Get.to(
                                              () => CMoviesDetails(
                                                episode['eplink'],
                                              ),
                                              preventDuplicates: false,
                                            );
                                          }
                                        : () {
                                            print("Episode " +
                                                _controller.data['currentEp']);
                                          },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: ("Episode " +
                                                    _controller
                                                        .data['currentEp']) !=
                                                episode['epName']
                                            ? const Color(0xff4B97C5)
                                            : null,
                                      ),
                                      child: Text(
                                        episode['epName'].toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const Text(
                              "Similar Movies:",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              primary: false,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 200,
                              ),
                              itemCount: _controller.data['similarList'].length,
                              itemBuilder: (_, index) => CMoviesTemplate(
                                fit: BoxFit.fitWidth,
                                eqOrQuality: _controller.data['similarList']
                                    [index]['epOrQuality'],
                                image: _controller.data['similarList'][index]
                                    ['image'],
                                title: _controller.data['similarList'][index]
                                    ['title'],
                                onClick: () => Get.to(
                                  () => CMoviesDetails(
                                    _controller.data['similarList'][index]
                                        ['link'],
                                  ),
                                  preventDuplicates: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
