import 'dart:convert';
import 'package:tms/models/movie_cast_model.dart';
import 'package:tms/models/movie_detail_model.dart';
import 'package:tms/models/movie_genre_model.dart';
import 'package:tms/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:tms/models/movie_person_model.dart';
import 'package:tms/models/movie_video_model.dart';

class MovieRepo {
  String mainUrl = 'https://api.themoviedb.org/3';
  String apiKey = 'api_key=d14708f2fca792ff1266207b85ee13f4';

  Future<List<MovieModel>> getNowPlayingMovie() async {
    try {
      http.Response res = await http.get(Uri.parse('$mainUrl/movie/now_playing?$apiKey')).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      return resultList.map<MovieModel>((dynamic e) {
        return MovieModel.fromJson(json: e);
      }).toList();
    } catch (e) {}
    return [];
  }

  Future<List<MovieGenreModel>> getGenreList() async {
    try {
      http.Response res = await http.get(Uri.parse('$mainUrl/genre/movie/list?$apiKey')).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['genres'];
      return resultList.map<MovieGenreModel>((dynamic e) {
        return MovieGenreModel.fromJson(json: e);
      }).toList();
    } catch (e) {}
    return [];
  }

  Future<List<MovieModel>> getLoadMovieListWithGenre(int genreId) async {
    try {
      http.Response res = await http.get(Uri.parse('$mainUrl/discover/movie?with_genres=$genreId&$apiKey')).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      return resultList.map<MovieModel>((dynamic e) {
        return MovieModel.fromJson(json: e);
      }).toList();
    } catch (e) {}
    return [];
  }

  Future<List<MoviePersonModel>> getPerson() async {
    try {
      http.Response res = await http.get(Uri.parse('$mainUrl/trending/person/week?$apiKey')).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      return resultList.map<MoviePersonModel>((dynamic e) {
        return MoviePersonModel.fromJson(json: e);
      }).toList();
    } catch (e) {}
    return [];
  }

  Future<List<MovieModel>> getTopRated() async {
    try {
      http.Response res = await http.get(Uri.parse('$mainUrl/movie/top_rated?$apiKey')).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      return resultList.map<MovieModel>((dynamic e) {
        return MovieModel.fromJson(json: e);
      }).toList();
    } catch (e) {}
    return [];
  }

  Future<MovieDetailModel> getMovieDetail(int movieId) async {
    http.Response res = await http.get(Uri.parse('$mainUrl/movie/$movieId?$apiKey'));
    Map<String, dynamic> result = jsonDecode(res.body);
    MovieDetailModel movieDetail = MovieDetailModel.fromJson(result);
    print(movieDetail);
    return movieDetail;
  }

  Future<List<MovieVideoModel>> getMovieVideo(int movieId) async {
    try {
      http.Response res = await http.get(Uri.parse('$mainUrl/movie/$movieId/videos?$apiKey')).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      return resultList.map<MovieVideoModel>((dynamic e) {
        return MovieVideoModel.fromJson(json: e);
      }).toList();
    } catch (e) {}
    return [];
  }

  Future<List<MovieCastModel>> getMovieCast(int movieId) async {
    try {
      http.Response res = await http.get(Uri.parse('$mainUrl/movie/$movieId/credits/$apiKey')).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];

      return resultList.map<MovieCastModel>((dynamic e) {
        return MovieCastModel.fromJson(json: e);
      }).toList();
    } catch (e) {}
    return [];
  }

  Future<List<MovieModel>> getSimilarMovies(int movieId) async {
    try {
      http.Response res = await http.get(Uri.parse('$mainUrl/movie/$movieId/credits/$apiKey')).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];

      return resultList.map<MovieModel>((dynamic e) {
        return MovieModel.fromJson(json: e);
      }).toList();
    } catch (e) {}
    return [];
  }
}
