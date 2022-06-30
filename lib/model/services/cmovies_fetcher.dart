import 'dart:convert';

import 'package:http/http.dart' as http;
 
import '../cmovies.dart';

class CMoviesFetcher {
  final List<CMovies> _cMovies = [];
  http.Response? response;
  dynamic _responseJson;
  dynamic _jsonData;
  void clearData() {
    _cMovies.clear();
  }

  Future<List<CMovies>> fetchCMovies(String url) async {
    try {
      response =
          await /*rootBundle.loadString(
        "lib/assets/json/cmoviesList.json");*/
          http.get(Uri.parse(url));
      // if (response!. /*isNotEmpty*/ statusCode == 200) {
        _responseJson = json.decode(response!.body);

        for (_jsonData in _responseJson['moviesList']) {
          // print(jsonData);
          _cMovies.add(CMovies.fromJson(_jsonData));
        }
        return _cMovies;
      // }
    } catch (e) {
      throw Exception('Failed to load movies with $e');
    }
  }
}
