import 'dart:convert';
import 'package:wtw/models/movie_detail_model.dart';
import 'package:wtw/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieRepo {
  String mainUrl = 'https://api.themoviedb.org/3';
  String apiKey = 'api_key=d14708f2fca792ff1266207b85ee13f4';

  Future<MovieDetailModel> getMovie(int movieId) async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/movie/$movieId?$apiKey'))
          .timeout(Duration(seconds: 8),
              onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return MovieDetailModel.fromJson({});
      }
      if (res.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(res.body);
        MovieDetailModel movies = MovieDetailModel.fromJson(result);
        return movies;
      }
    } catch (e) {
      print('MovieDetail $e');
    }
    return MovieDetailModel.fromJson({});
  }

  Future<List<MovieModel>> getNowPlayingMovie() async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/movie/popular?&page=1&$apiKey'))
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
