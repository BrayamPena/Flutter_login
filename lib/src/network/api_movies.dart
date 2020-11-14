import 'dart:convert';
import 'package:flutter_login/src/models/trending.dart';
import 'package:http/http.dart' show Client;

class ApiMovies {
  final String URL_TRENDING =
      "https://api.themoviedb.org/3/movie/popular?api_key=e0feb69b02a40d2c55e1670aff939730&language=es-MX&page=1";
  Client http = Client();

  Future<List<Result>> getTrending() async {
    final response = await http.get(URL_TRENDING);
    if (response.statusCode == 200) {
      var movies = jsonDecode(response.body)['results'] as List;
      List<Result> listMovies =
          movies.map((movie) => Result.fromJSON(movie)).toList();
      print(movies);
      return listMovies;
    } else {
      return null;
    }
  }
}
