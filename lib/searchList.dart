import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './detailsPage/cmoviesDetails.dart';
import './detailsPage/hindiDoubbedSearchDetails.dart';
import './model/hindimovies.dart';
import './model/services/cmovies_fetcher.dart';
import './model/services/hindimovies_fetcher.dart';
import './template/custom_loading_indicator.dart';
import './utility.dart';
import './detailsPage/ytsMovieDetails.dart';
import './model/cmovies.dart';
import './model/services/yts_fetcher.dart';
import './model/yts_movies.dart';
import 'template/search_template.dart';

class SearchList extends StatefulWidget {
  const SearchList({Key? key}) : super(key: key);

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  String showingResults = "";
  bool _isLoading = false;
  final List<YTSMovies> _ytsMovies = [];
  final List<CMovies> _cMovies = [];
  final List<HindiMovies> _hindiMovies = [];
  final YTSFetcher _ytsFetcher = YTSFetcher();
  final CMoviesFetcher _cMoviesFetcher = CMoviesFetcher();
  final HindiMoviesFetcher _hindiMoviesFetcher = HindiMoviesFetcher();
  late StreamController<List<dynamic>> _streamController;
  late TextEditingController _searchController;
  late ScrollController _scrollController;
  int page = 1;

  @override
  void initState() {
    _searchController = TextEditingController();
    _streamController = StreamController();
    _scrollController = ScrollController();
    super.initState();
    _streamController.stream.listen((event) {
      // dynamic a = 1;
      // print(a.runtimeType);
      // print(event.runtimeType);
      print([...event]);
      if (event.runtimeType.toString() == "List<CMovies>") {
        event.forEach((element) {
          _cMovies.add(element);
          print("Cmovies Length :${_cMovies.length}");
        });
        _cMoviesFetcher.clearData();
      }
      if (event.runtimeType.toString() == "List<YTSMovies>") {
        print("check: gotcha");
        event.forEach((element) {
          _ytsMovies.add(element);
          print("YTSMovies Length :${_ytsMovies.length}");
        });
        _ytsFetcher.clearData();
      }
      if (event.runtimeType.toString() == "List<HindiMovies>") {
        event.forEach((element) {
          _hindiMovies.add(element);
          print("Hindi Length :${_hindiMovies.length}");
        });
        _hindiMoviesFetcher.clearData();
      }
      _isLoading = false;
      page++;

      setState(() {});
    }).onError((handleError) {
      print(handleError);
      setState(() => _isLoading = false);
    });

    _scrollController.addListener(() {
      if (!_isLoading &&
          Utility.checkScrollPosition(_scrollController.position.pixels,
              _scrollController.position.maxScrollExtent)) {
        print("Checking of is loading");

        page++;
        if (_cMovies.isNotEmpty) {
          print("checking: cmovies Length${_cMovies.length}");

          getMoviesTorrent(2);
        } else if (_ytsMovies.isNotEmpty) {
          print("checking: Yts Length${_ytsMovies.length}");
          getMoviesTorrent(1);
        } else if (_hindiMovies.isNotEmpty) {
          print("checking: hindi Length${_hindiMovies.length}");
          getMoviesTorrent(3);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: _searchController,
                          style: const TextStyle(color: Colors.white),
                          enableSuggestions: true,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            labelText: 'Search',
                            suffixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            disabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            labelStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            suffixStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            prefixStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            contentPadding: const EdgeInsets.all(8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 5,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                page = 1;
                                _cMovies.clear();
                                _ytsMovies.clear();
                                _hindiMovies.clear();
                                getMoviesTorrent(1);
                              },
                              icon: const Icon(
                                Icons.search,
                                size: 12,
                              ),
                              label: const AutoSizeText(
                                'Torrent',
                                minFontSize: 10,
                                maxFontSize: 15,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                page = 1;
                                _cMovies.clear();
                                _ytsMovies.clear();
                                _hindiMovies.clear();
                                getMoviesTorrent(2);
                              },
                              icon: const Icon(
                                Icons.search,
                                size: 12,
                              ),
                              label: const AutoSizeText(
                                'Server 2',
                                minFontSize: 10,
                                maxFontSize: 15,
                              ),
                            ),
                            // ElevatedButton.icon(
                            //   onPressed: () {
                            //     page = 1;
                            //     _cMovies.clear();
                            //     _ytsMovies.clear();
                            //     _hindiMovies.clear();
                            //     getMoviesTorrent(3);
                            //   },
                            //   icon: const Icon(
                            //     Icons.search,
                            //     size: 12,
                            //   ),
                            //   label: const AutoSizeText(
                            //     'Hindi',
                            //     minFontSize: 10,
                            //     maxFontSize: 15,
                            //     overflow: TextOverflow.ellipsis,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                        child: Text(
                          'Search Results for: $showingResults',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff4B97C5),
                          ),
                        ),
                      ),
                      if (page == 1 && _isLoading)
                        const CustomLoadingIndicator(),
                    ],
                  );
                },
                childCount: 1,
              ),
            ),
            if (!_isLoading ||
                _cMovies.isNotEmpty ||
                _ytsMovies.isNotEmpty ||
                _hindiMovies.isNotEmpty)
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  // maxCrossAxisExtent: 210.0,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                  childAspectRatio: 1.0,
                  mainAxisExtent: 300,
                  crossAxisCount: 2,
                ),
                delegate: SliverChildBuilderDelegate(
                  (_, index) {
                    print("Grocery Item: $index");
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
                      child: _hindiMovies.isNotEmpty
                          ? SearchTemplate(
                              imageUrl: _hindiMovies[index].image,
                              title: _hindiMovies[index].title,
                              url: _hindiMovies[index].link,
                              year: "",
                              pag: () => Get.to(() => HindiDobbedSearchDetails(
                                  _hindiMovies[index].link)),
                            )
                          : _cMovies.isNotEmpty
                              ? SearchTemplate(
                                  imageUrl: _cMovies[index].image,
                                  title: _cMovies[index].title,
                                  url: _cMovies[index].link,
                                  year: _cMovies[index].epOrQuality,
                                  pag: () => Get.to(() =>
                                      CMoviesDetails(_cMovies[index].link)),
                                )
                              : SearchTemplate(
                                  imageUrl: _ytsMovies[index].image,
                                  title: _ytsMovies[index].title,
                                  url: _ytsMovies[index].link,
                                  year: _ytsMovies[index].year,
                                  pag: () => Get.to(() =>
                                      YTSDetailsPage(_ytsMovies[index].link)),
                                ),
                    );
                  },
                  childCount: _cMovies.isNotEmpty
                      ? _cMovies.length
                      : _hindiMovies.isNotEmpty
                          ? _hindiMovies.length
                          : _ytsMovies.length,
                ),
              ),
            if (page > 1 && _isLoading)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (_, int) =>
                        const Center(child: CircularProgressIndicator()),
                    childCount: 1),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> getMoviesTorrent(int serverNo) async {
    try {
      setState(() {
        _isLoading = true;
      });
      _streamController.add(
        serverNo == 1
            ? await _ytsFetcher.fetchYtsMovies(
                "https://tormovie.online/apis/torrentList.php?search-term=${_searchController.text}&page=$page")
            : serverNo == 2
                ? await _cMoviesFetcher.fetchCMovies(
                    "https://tormovie.online/apis/search/vidcloudSearch.php?search-term=${_searchController.text}&page=$page")
                : await _hindiMoviesFetcher.fetchTheMovieFlix(
                    "https://tormovie.online/apis/search/doubbed_search.php?search-term=${_searchController.text}&page=$page"),
      );
    } catch (e) {
      _streamController.addError(e);
    }
  }
}
