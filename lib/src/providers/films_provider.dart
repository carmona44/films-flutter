import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actors_model.dart';

import 'package:peliculas/src/models/film_model.dart';

class FilmsProvider {
  String _apikey = 'f29c01c855347b933b5865d81c3aa281';
  String _url = 'api.themoviedb.org';
  String _lang = 'es-ES';
  int _page = 0;
  bool _loading = false;
  List<Film> _popularFilms = new List();

  final _popularStreamController = StreamController<List<Film>>.broadcast();

  Function(List<Film>) get popularsSink => _popularStreamController.sink.add;
  Stream<List<Film>> get popularsStream => _popularStreamController.stream;

  void _disposeStreams() {
    _popularStreamController?.close();
  }

  Future<List<Film>> _buildResponse(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final films = new Films.fromJsonList(decodedData['results']);

    return films.items;
  }

  Future<List<Film>> getNowPlaying() async {
    final url = Uri.https(
        _url, '3/movie/now_playing', {'api_key': _apikey, 'language': _lang});

    return await _buildResponse(url);
  }

  Future<List<Film>> getPopular() async {
    if (_loading) {
      return [];
    }
    _loading = true;
    _page++;
    final url = Uri.https(_url, '3/movie/popular',
        {'api_key': _apikey, 'language': _lang, 'page': _page.toString()});

    final resp = await _buildResponse(url);
    _popularFilms.addAll(resp);
    popularsSink(_popularFilms);
    _loading = false;

    return resp;
  }

  Future<List<Actor>> getCast(String actorId) async {
    final url = Uri.https(_url, '3/movie/$actorId/credits',
        {'api_key': _apikey, 'language': _lang});

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = Cast.fromJsonList(decodedData['cast']);

    return cast.actors;
  }
}
