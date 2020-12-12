import 'dart:convert';
import 'package:flutter_login/src/models/cast.dart';
import 'package:flutter_login/src/models/trending.dart';
import 'package:flutter_login/src/models/videoTrailer.dart';
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
      return listMovies;
    } else {
      return null;
    }
  }

  //metodo para obtener el cast
  Future<List<CastElement>> getCast(String id) async {
    String URL_CAST =
        "https://api.themoviedb.org/3/movie/${id}/credits?api_key=e0feb69b02a40d2c55e1670aff939730&language=en-US";
    final response = await http.get(URL_CAST);
    if (response.statusCode == 200) {
      var cast = jsonDecode(response.body)['cast'] as List;
      List<CastElement> listCast =
          cast.map((cast) => CastElement.fromJson(cast)).toList();
      return listCast;
    } else {
      return null;
    }
  }

  //Metodo para obtener video
  Future<List<Resultv>> getVideo(String id) async {
    String URL_VIDEO =
        "https://api.themoviedb.org/3/movie/${id}/videos?api_key=e0feb69b02a40d2c55e1670aff939730&language=en-US";
    final response = await http.get(URL_VIDEO);
    if (response.statusCode == 200) {
      var video = jsonDecode(response.body)['results'] as List;
      List<Resultv> listVideo =
          video.map((video) => Resultv.fromJson(video)).toList();
      //print(video);
      return listVideo;
    } else {
      return null;
    }
  }
}
