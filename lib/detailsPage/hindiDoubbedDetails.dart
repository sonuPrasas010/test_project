import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/details_controller/hindi_doubbed_details.dart';
import '../model/ads/InterstitialAd.dart';
import '../template/custom_loading_indicator.dart';
import '../template/custom_reload_button.dart';
import '../utility.dart';
import '../webViewPlayer.dart';

class HindiDobbedDetails extends StatelessWidget {
  final String url;
  late YTSDetailsController _ytsDetailsController;
  HindiDobbedDetails(this.url) {
    _ytsDetailsController = Get.put(YTSDetailsController(url));
  }

  @override
  Widget build(BuildContext context) {
    // MyInterstitialAd.showAd();
    return Obx(
      () => SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text(_ytsDetailsController.data['title'] ?? "..."),
            backgroundColor: Colors.transparent,
          ),
          body: _ytsDetailsController.isLoading.value
              ? const CustomLoadingIndicator()
              : _ytsDetailsController.data.isEmpty
                  ? CustomReloadButton(() => _ytsDetailsController.getData())
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WebViewPlayer(
                                            url: _ytsDetailsController
                                                .data["streamtape"],
                                          )));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          _ytsDetailsController.data['image'],
                                      width: MediaQuery.of(context).size.width,
                                      height: 450,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const Center(
                                    // heightFactor: 4,
                                    child: Icon(
                                      Icons.play_circle_rounded,
                                      color: Colors.blue,
                                      size: 50,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: ElevatedButton.icon(
                                onPressed: () {
                                  Utility.launchMyUrl(
                                      _ytsDetailsController.data['download'],context,);
                                },
                                icon: const Icon(
                                  Icons.download,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  "Download",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          // FaceNv(),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                const TextSpan(
                                  text: "Other Name: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                                TextSpan(
                                  text: _ytsDetailsController.data['title'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                )
                              ]),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                const TextSpan(
                                  text: "Director: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                                TextSpan(
                                  text: _ytsDetailsController.data['director'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                )
                              ]),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                const TextSpan(
                                  text: "Starring: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                                TextSpan(
                                  text: _ytsDetailsController.data['cast'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                )
                              ]),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                const TextSpan(
                                  text: "Genre: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                                TextSpan(
                                  text: _ytsDetailsController.data['genre'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                )
                              ]),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                const TextSpan(
                                  text: "Released On: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                                TextSpan(
                                  text: _ytsDetailsController
                                      .data['uploadedDate'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                )
                              ]),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                const TextSpan(
                                  text: "Writer: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                                TextSpan(
                                  text: _ytsDetailsController.data['writer'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                )
                              ]),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                const TextSpan(
                                  text: "Rating: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      _ytsDetailsController.data['imdbRating'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                const TextSpan(
                                  text: "Duration: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: _ytsDetailsController.data['duration'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                const TextSpan(
                                  text: "Synopsis: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: _ytsDetailsController.data['synopsis'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
