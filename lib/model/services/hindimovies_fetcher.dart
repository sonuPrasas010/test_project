import '../hindimovies.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class HindiMoviesFetcher {
  final List<HindiMovies> _hindiMovies = [];

  http.Response? _response;
  dynamic _responseJson;
  dynamic _jsonData;
  void clearData() {
    _hindiMovies.clear();
  }

  Future<List<HindiMovies>> fetchHindiLinks4U(String url) async {
    _response = await http.get(Uri.parse(url));
    if (_response!.statusCode == 200) {
      _responseJson = json.decode(_response!.body);

      for (_jsonData in _responseJson) {
        _hindiMovies.add(HindiMovies.fromJson(_jsonData));
      }
      return _hindiMovies;
    } else
      throw Exception('Failed to load movies');
  }

  Future<List<HindiMovies>> fetchTheMovieFlix(String url) async {
    _response = await http.get(Uri.parse(url));
    if (_response!.statusCode == 200) {
      _responseJson = json.decode(_response!.body);
      for (_jsonData in _responseJson) {
        _hindiMovies.add(HindiMovies.fromJson(_jsonData));
      }
      return _hindiMovies;
    } else
      throw Exception('Failed to load movies');
  }
}
