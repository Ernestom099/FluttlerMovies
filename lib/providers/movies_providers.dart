import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/credits_response.dart';
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = 'eb84eada1120acebd218f8ac4aabaf90';
  final String _language = 'es-MX';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  int _popularPage = 1;
  Map<int, List<Cast>> movieCast = {};

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, int page) async {
    var url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing', 1);

    NowPlayingResponse nowPlayingResponse =
        NowPlayingResponse.fromJson(json.decode(jsonData));

    onDisplayMovies = nowPlayingResponse.movies;
    //onDisplayMovies = [...nowPlayingResponse.movies];

    notifyListeners();
  }

  getPopularMovies() async {
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);

    PopularResponse popularResponse =
        PopularResponse.fromJson(json.decode(jsonData));

    popularMovies = [...popularMovies, ...popularResponse.movies];

    _popularPage++;

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) {
      print('Desde memoria');
      return movieCast[movieId]!;
    }

    print('Pidiendo info del cast en el servidor');
    final jsonData =
        await _getJsonData('3/movie/$movieId/credits', _popularPage);

    CreditsResponse creditsResponse =
        CreditsResponse.fromJson(json.decode(jsonData));

    movieCast[movieId] = creditsResponse.cast;

    return movieCast[movieId]!;
  }
}
