import 'dart:async';

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/ads/InterstitialAd.dart';
import '../model/ads/fb_intres.dart';
import '../model/ads/nativeads.dart';
import '../model/services/DataFetcher.dart';
import '../template/ImageWithLoader.dart';
import '../template/cmovies_list_template.dart';
import '../template/cmovies_template.dart';
import '../template/custom_loading_indicator.dart';
import '../template/custom_reload_button.dart';
import '../utility.dart';
import '../webViewPlayer.dart';

class CMoviesSearchDetails extends StatefulWidget {
  final String link;
  const CMoviesSearchDetails(this.link, {Key? key}) : super(key: key);

  @override
  _CMoviesSearchDetailsState createState() => _CMoviesSearchDetailsState();
}

class _CMoviesSearchDetailsState extends State<CMoviesSearchDetails> {
  bool _isLoading = true;
  late StreamController<Map<String, dynamic>> _streamController;
  Map _movie = {};

  @override
  void initState() {
    _streamController = StreamController<Map<String, dynamic>>();
//  FacebookIntres.loadAndShow();
    // MyInterstitialAd.showAd();
    super.initState();
    getDetails();

    _streamController.stream.listen((event) {
      setState(() {
        _movie = event;
        _isLoading = false;
      });
    }).onError((err) {
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
            : _movie.isEmpty
                ? CustomReloadButton(() {
                    getDetails();
                    // Utility.launchURLWithCustomTabs(context,
                    //     'https://tormovie.online/apis/search/vidcloud_details.php?v=/videos/a-killer-among-friends-sd');
                  })
                : _movie['status'] == "vid"
                    ? vid(context)
                    : cmov(context),
      ),
    );
  }

  SingleChildScrollView vid(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageWithLoader(_movie['image'] ?? ""),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Text(
              _movie['title'] ?? "",
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
              _movie['synopsis'] ?? "",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Column(
              children: [
                CMoviesListTemplate("\u25A0", "Type:", _movie['type'] ?? "n/a"),
                CMoviesListTemplate(
                  "\u25A0",
                  "Release:",
                  _movie['releaseDate'] ?? "",
                ),
                CMoviesListTemplate(
                    "\u25A0", "Genre:", _movie['genre'] ?? "n/a"),
                CMoviesListTemplate(
                  "\u25A0",
                  "Director:",
                  _movie['director'] ?? "",
                ),
                CMoviesListTemplate("\u25A0", "IMDB:", _movie['imdb'] ?? "n/a"),
                CMoviesListTemplate(
                  "\u25A0",
                  "Country:",
                  _movie['country'] ?? "n/a",
                ),
                CMoviesListTemplate(
                    "\u25A0", "Duration:", _movie['duration'] ?? "n/a"),
                CMoviesListTemplate(
                  "\u25A0",
                  "Quality:",
                  _movie['quality'] ?? "n/a",
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
                       _movie['downloadLink'].toString(),context,);
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              WebViewPlayer(url: _movie['iframe'])));
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text("Play"),
              ),
            ],
          ),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: [
              for (var episode in _movie["episodeList"] ?? [])

                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     primary: Color(0xff4B97C5),
                //     elevation: 10,
                //     shadowColor: Colors.blue,
                //   ),
                //   child: Text(
                //     "Episode 1",
                //   ),
                //   onPressed: () {},
                // )
                InkWell(
                  onTap: ("Episode " + _movie['currentEp']) != episode['epName']
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CMoviesSearchDetails(episode['eplink']),
                            ),
                          );
                        }
                      : null,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ("Episode " + _movie['currentEp']) !=
                              episode['epName']
                          ? const Color(0xff4B97C5)
                          : null,
                    ),
                    child: Text(
                      episode['epName'].toString(),
                      style: const TextStyle(color: Colors.white),
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
        ],
      ),
    );
  }

  SingleChildScrollView cmov(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageWithLoader(_movie['image'] ?? ""),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Text(
              _movie['title'] ?? "",
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
              _movie['synopsis'] ?? "",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Column(
              children: [
                CMoviesListTemplate("\u25A0", "Type:", _movie['type'] ?? ""),
                CMoviesListTemplate(
                  "\u25A0",
                  "Release:",
                  _movie['releaseDate'] ?? "",
                ),
                CMoviesListTemplate("\u25A0", "Genre:", _movie['genre'] ?? ""),
                CMoviesListTemplate(
                  "\u25A0",
                  "Director:",
                  _movie['director'] ?? "",
                ),
                CMoviesListTemplate("\u25A0", "IMDB:", _movie['imdb'] ?? ""),
                CMoviesListTemplate(
                  "\u25A0",
                  "Country:",
                  _movie['country'] ?? "",
                ),
                CMoviesListTemplate(
                    "\u25A0", "Duration:", _movie['duration'] ?? ""),
                CMoviesListTemplate(
                  "\u25A0",
                  "Quality:",
                  _movie['quality'] ?? "",
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
                       _movie['downloadLink'].toString(),context);
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              WebViewPlayer(url: _movie['iframe'])));
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text("Play"),
              ),
            ],
          ),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: [
              for (var episode in _movie["episodeList"] ?? [])

                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     primary: Color(0xff4B97C5),
                //     elevation: 10,
                //     shadowColor: Colors.blue,
                //   ),
                //   child: Text(
                //     "Episode 1",
                //   ),
                //   onPressed: () {},
                // )
                InkWell(
                  onTap: ("Episode " + _movie['currentEp']) != episode['epName']
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CMoviesSearchDetails(episode['eplink']),
                            ),
                          );
                        }
                      : null,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ("Episode " + _movie['currentEp']) !=
                              episode['epName']
                          ? const Color(0xff4B97C5)
                          : null,
                    ),
                    child: Text(
                      episode['epName'].toString(),
                      style: const TextStyle(color: Colors.white),
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
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 200,
            ),
            itemCount: _movie['similarList'].length,
            itemBuilder: (_, index) => CMoviesTemplate(
              fit: BoxFit.fitWidth,
              eqOrQuality: _movie['similarList'][index]['epOrQuality'],
              image: _movie['similarList'][index]['image'],
              title: _movie['similarList'][index]['title'],
              onClick: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CMoviesSearchDetails(
                      _movie['similarList'][index]['link']),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getDetails() async {
    setState(() => _isLoading = true);

    try {
      if (!_streamController.isClosed) {
        _streamController.add(await DataFetcher().fetchRawData(widget.link));
      }
    } catch (err) {
      if (!_streamController.isClosed) _streamController.addError(err);
    }
  }
}
