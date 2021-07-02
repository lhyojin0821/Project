import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:tms/models/tv_models/tv_genre_model.dart';
import 'package:tms/models/tv_models/tv_model.dart';
import 'package:http/http.dart' as http;

class TvRepo {
  String mainUrl = 'https://api.themoviedb.org/3';
  String apiKey = 'api_key=d14708f2fca792ff1266207b85ee13f4';

  Future<List<TvModel>> getOnTheAir() async {
    try {
      http.Response res = await http.get(Uri.parse('$mainUrl/tv/on_the_air?$apiKey&page=1')).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      return resultList.map<TvModel>((dynamic e) {
        return TvModel.fromJson(json: e);
      }).toList();
    } catch (e) {}
    return [];
  }

  Future<List<TvGenreModel>> getTvGenreList() async {
    try {
      http.Response res = await http.get(Uri.parse('$mainUrl/genre/movie/list?$apiKey')).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['genres'];
      return resultList.map<TvGenreModel>((dynamic e) {
        return TvGenreModel.fromJson(json: e);
      }).toList();
    } catch (e) {}
    return [];
  }

  Future<List<TvModel>> getLoadTvListWithGenre(int genreId) async {
    try {
      http.Response res = await http.get(Uri.parse('$mainUrl/discover/tv?with_genres=$genreId&primary_release_date.lte=2021-07-01&page=1&$apiKey')).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      print(resultList);
      return resultList.map<TvModel>((dynamic e) {
        return TvModel.fromJson(json: e);
      }).toList();
    } catch (e) {}
    return [];
  }
}
