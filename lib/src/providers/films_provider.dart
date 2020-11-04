import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/film_model.dart';

class FilmsProvider {
  String _apikey = 'f29c01c855347b933b5865d81c3aa281';
  String _url = 'api.themoviedb.org';
  String _lang = 'es-ES';

  Future<List<Film>> getNowPlaying() async {
    final url = Uri.https(
        _url, '3/movie/now_playing', {'api_key': _apikey, 'language': _lang});

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final films = new Films.fromJsonList(decodedData['results']);

    return films.items;
  }
}
