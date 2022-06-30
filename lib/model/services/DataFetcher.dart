import 'dart:convert';
import 'package:http/http.dart' as http;

import '../cmovies.dart';
import '../hindimovies.dart';
import '../yts_movies.dart';

class DataFetcher {
  http.Response? response;
  dynamic jsonData;

  dynamic responseJson;
  Future<Map<String, dynamic>> fetchRawData(String url) async {
    response = await /*rootBundle.loadString(url);*/
        http.get(Uri.parse(url));

    return json.decode(response!.body);
  }

  Future<Map<String, dynamic>> fetchHomeMovies(String url) async {
    try {
      response = /*await rootBundle.loadString("lib/assets/json/home.json");*/
          await http.get(
        Uri.parse(
          url,
        ),
      );

      responseJson = json.decode(response!.body);
      final List<CMovies> sliderList = [];
      final List<CMovies> cinemaMovies = [];
      final List<HindiMovies> hindiMovies = [];
      final List<YTSMovies> ytsMovies = [];
      final List<CMovies> tvSeries = [];
      for (jsonData in responseJson['sliderList']) {
        // adding slider list
        sliderList.add(CMovies.fromJson(jsonData));
      }
      for (jsonData in responseJson['cinemaMovies']) {
        // here cinema movies means popular movies cmovies.com
        cinemaMovies.add(CMovies.fromJson(jsonData));
      }
      for (jsonData in responseJson['doubbedMovies']) {
        //adding doubbed movies
        hindiMovies.add(HindiMovies.fromJson(jsonData));
      }
      for (jsonData in responseJson['torrentMovies']) {
        //adding to map
        ytsMovies.add(YTSMovies.fromJson(jsonData));
      }

      for (jsonData in responseJson['tvSeries']) {
        //adding to map
        tvSeries.add(CMovies.fromJson(jsonData));
      }
      // returning map as future
      return {
        "sliderList": sliderList,
        "cinemaMovies": cinemaMovies,
        "hindiMovies": hindiMovies,
        "ytsMovies": ytsMovies,
        'tvSeries': tvSeries
      };
    } catch (e) {
      throw ("Failed to fetch movies with $e");
    }
  }
}
