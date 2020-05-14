import 'dart:convert';

import 'package:http/http.dart' as http;
import 'Movie.dart';
import 'SearchResponse.dart';

class OmdbRepository {
  final apiKey = "9b3a881c";
  const OmdbRepository();

  Future<List<Movie>> searchMovies(String byName) async {
    final response = await http.get('http://www.omdbapi.com/?s=$byName&apikey=$apiKey');
    final jsonValue = json.decode(response.body);
    return SearchResponse.fromJson(jsonValue).movies;
  }
}