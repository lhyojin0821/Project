import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wtw/models/movie_model/movie_detail_model.dart';
import 'package:wtw/models/movie_model/movie_model.dart';
import 'package:wtw/models/movie_model/movie_video_model.dart';

class MovieRepo {
  String mainUrl = 'https://api.themoviedb.org/3';
  String apiKey = 'api_key=d14708f2fca792ff1266207b85ee13f4';

  Future<MovieDetailModel> getMovieDetail(int? movieId) async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/movie/$movieId?$apiKey&language=ko-KR'))
          .timeout(Duration(seconds: 8),
              onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return MovieDetailModel.fromJson({});
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      MovieDetailModel movies = MovieDetailModel.fromJson(result);
      return movies;
    } catch (e) {
      print('MovieDetail $e');
    }
    return MovieDetailModel.fromJson({});
  }

  Future<List<MovieModel>> getMovieRecommendation(
    int genreId,
    int pageId,
  ) async {
    try {
      http.Response res = await http
          .get(Uri.parse(
              '$mainUrl/discover/movie?$apiKey&sort_by=popularity.desc&language=en-US&with_genres=$genreId&page=$pageId&primary_release_date.gte=2010-01-01&primary_release_date.lte=2021-07-01&include_adult=false'))
          .timeout(Duration(seconds: 8),
              onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      return resultList.map<MovieModel>((dynamic e) {
        return MovieModel.fromJson(json: e);
      }).toList();
    } catch (e) {
      print('getRecommendation $e');
    }
    return [];
  }

  Future<List<MovieModel>> getMovieNowPlaying() async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/movie/now_playing?$apiKey&language=ko-KR'))
          .timeout(Duration(seconds: 8),
              onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      return resultList.map<MovieModel>((dynamic e) {
        return MovieModel.fromJson(json: e);
      }).toList();
    } catch (e) {
      print('MovieNowPlaying $e');
    }
    return [];
  }

  Future<List<MovieVideoModel>> getMovieVideo(int movieId) async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/movie/$movieId/videos?$apiKey'))
          .timeout(Duration(seconds: 8),
              onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      return resultList.map<MovieVideoModel>((dynamic e) {
        return MovieVideoModel.fromJson(json: e);
      }).toList();
    } catch (e) {
      print('MovieVideo $e');
    }
    return [];
  }
}
