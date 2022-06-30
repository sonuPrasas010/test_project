import '../yts_movies.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class YTSFetcher {
  final List<YTSMovies> _ytsMovies = [];
  http.Response? _response;
  dynamic _responseJson;
  dynamic _jsonData;

  void clearData() {
    _ytsMovies.clear();
  }

  Future<List<YTSMovies>> fetchYtsMovies(String url) async {
    try {
      _response = await /* rootBundle.loadString(url);*/
          http.get(
        Uri.parse(url),
      );
      if (_response!. /*isNotEmpty*/ statusCode == 200)
        _responseJson = json.decode(_response!.body);

      for (_jsonData in _responseJson) {
        _ytsMovies.add(YTSMovies.fromJson(_jsonData));
      }

      return _ytsMovies;
    } catch (e) {
      throw Exception('Failed to load movies with $e');
    }
  }
}
