import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../model/ads/InterstitialAd.dart';
import '../model/services/DataFetcher.dart';
import '../template/custom_loading_indicator.dart';
import '../template/custom_reload_button.dart';
import '../utility.dart';
import '../webViewPlayer.dart';

class HindiDobbedSearchDetails extends StatefulWidget {
  final String url;
  const HindiDobbedSearchDetails(this.url);

  @override
  _HindiDobbedSearchDetailsState createState() =>
      _HindiDobbedSearchDetailsState();
}

class _HindiDobbedSearchDetailsState extends State<HindiDobbedSearchDetails> {
  late StreamController<Map> _streamController;
  Map _details = {};
  bool _isLoading = true;

  @override
  void initState() {
    // for ads listener
    // CustomAdmob.showInterstitialAd();
    // FacebookIntres.loadAndShow();
    // end for ads listener

    _streamController = StreamController<Map>();
    getMovieDetails();
    // MyInterstitialAd.showAd();
    super.initState();

    _streamController.stream.listen((data) {
      setState(() {
        _details = data;
        _isLoading = false;
      });
    }).onError((err) {
      print(err);
      setState(() => _isLoading = false);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _isLoading
            ? const CustomLoadingIndicator()
            : _details.isEmpty
                ? CustomReloadButton(() => getMovieDetails())
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: _details['image'] ?? "",
                                width: MediaQuery.of(context).size.width,
                                height: 450,
                                fit: BoxFit.fill,
                                filterQuality: FilterQuality.low,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                const TextSpan(
                                  text: "Full Name: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                                TextSpan(
                                  text: _details['fullName'] ?? "",
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
                                  text: "Original Name: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                                TextSpan(
                                  text: _details['originalName'] ?? "",
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
                                  text: _details['director'] ?? "",
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
                                  text: _details['actors'] ?? "",
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
                                  text: _details['genre'] ?? "",
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
                                  text: _details['releasedDate'] ?? "",
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
                                  text: "Languages: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                                TextSpan(
                                  text: _details['language'] ?? "",
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
                                  text: _details['imdbRating'] ?? "",
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
                              text: TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: "Duration: ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: _details['duration'] ?? "",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
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
                                  text: _details['imdbSynopsis'] ?? "",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          //

                          Container(
                            margin: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                const TextSpan(
                                  text: "Size: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: _details['size'] ?? "",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                              ]),
                            ),
                          ),

                          //

                          Container(
                            margin: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                const TextSpan(
                                  text: "Format: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: _details['format'] ?? "",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                              ]),
                            ),
                          ),

                          for (var download in _details['downloadsLinks'])
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Theme.of(context).primaryColor,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        download['downTitle'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        ElevatedButton.icon(
                                            onPressed: () {
                                              Utility.launchMyUrl(
                                                
                                                download['downloadLink'],
                                                context,
                                              );
                                            },
                                            icon: const Icon(Icons.download),
                                            label: const Text("Download")),
                                        if (download['streamingLink'] != null)
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              Get.to(
                                                () => WebViewPlayer(
                                                  url:
                                                      download['streamingLink'],
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.play_arrow),
                                            label: const Text("Watch"),
                                          ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }

  Future<void> getMovieDetails() async {
    setState(() => _isLoading = true);

    try {
      _streamController.add(await DataFetcher().fetchRawData(widget.url));
    } catch (e) {
      _streamController.addError(e);
    }
  }
}
