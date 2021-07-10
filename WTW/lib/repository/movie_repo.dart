import 'dart:convert';
import 'package:wtw/models/movie_model/movie_detail_model.dart';
import 'package:wtw/models/movie_model/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:wtw/models/movie_model/movie_video_model.dart';

class MovieRepo {
  String mainUrl = 'https://api.themoviedb.org/3';
  String apiKey = 'api_key=d14708f2fca792ff1266207b85ee13f4';
  List<int> movieList = [];

  Future<MovieDetailModel> getMovie({int? movieId}) async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/movie/$movieId?$apiKey'))
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

  Future<List<MovieModel>> getMovieId() async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/movie?$apiKey'))
          .timeout(Duration(seconds: 8),
              onTimeout: () async => new http.Response('{}', 404));
      Map<String, dynamic> result = jsonDecode(res.body);

      List resultList = result['results'];
      this.movieList = resultList.map<int>((e) => e['id']).toList();
      print(this.movieList);
      // List<int> _movieIdList = movieIds.movieList;
      // var _movieIds = _movieIdList.join('');
      // int movieId = int.parse(_movieIds);
    } catch (e) {
      print('MovieDetail $e');
    }
    return [];
  }

  Future<List<MovieModel>> getNowPlayingMovie() async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/movie/now_playing?$apiKey'))
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
// class MovieRepo {
//   String mainUrl = 'https://api.reelgood.com/';
//   String subUrl = 'v3.0/content/random/';
//
//   Future<List<MovieModel>> getMovie(int genre, int minImdb) async {
//     try {
//       Map<String, dynamic> queryParams = {
//         "availability": "onAnySource",
//         "content_kind": "movie",
//         "genre": genre,
//         "minimum_imdb": minImdb,
//         "sources": "netflix",
//         "region": "us",
//         "nocache": "true"
//       };
//       http.Response res = await http
//           .get(Uri.https(this.mainUrl, this.subUrl, queryParams))
//           .timeout(Duration(seconds: 8),
//               onTimeout: () async => new http.Response('{}', 404));
//       print(res.body);
//       if (res.statusCode == 404) {
//         return [];
//       }
//       print(res.body);
//       Map<String, dynamic> result = jsonDecode(res.body);
//       List resultList = result['movies'];
//       return resultList.map<MovieModel>((dynamic e) {
//         return MovieModel.fromJson(json: e);
//       }).toList();
//     } catch (e) {
//       print('Movie : $e');
//     }
//     return [];
//   }
// }

/// ------------------------
// class MovieRepo {
//   String mainUrl = 'https://api.reelgood.com/';
//   String subUrl = 'v3.0/content/random/';
//   Future<MovieModel> getMovie(int genre, int minImdb) async {
//     try {
//       Map<String, dynamic> queryParams = {
//         "availability": "onAnySource",
//         "content_kind": "movie",
//         "genre": genre,
//         "minimum_imdb": minImdb,
//         "sources": "netflix",
//         "region": "us",
//         "nocache": "true"
//       };
//
//       http.Response res = await http
//           .get(Uri.https(this.mainUrl, this.subUrl, queryParams))
//           .timeout(Duration(seconds: 8),
//               onTimeout: () async => new http.Response('{}', 404));
//       print(res.body);
//       if (res.statusCode == 404) {
//         return MovieModel.fromJson(json: {});
//       }
//       Map<String, dynamic> result = jsonDecode(res.body);
//       print(result);
//       MovieModel movies = MovieModel.fromJson(json: result);
//       return movies;
//     } catch (e) {
//       print('Movie : $e');
//     }
//     return MovieModel.fromJson(json: {});
//   }
// }
