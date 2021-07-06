import 'dart:convert';
import 'package:tms/models/movie_models/movie_cast_model.dart';
import 'package:tms/models/movie_models/movie_detail_model.dart';
import 'package:tms/models/movie_models/movie_genre_model.dart';
import 'package:tms/models/movie_models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:tms/models/movie_models/movie_person_model.dart';
import 'package:tms/models/movie_models/movie_video_model.dart';
import 'package:tms/models/search_model.dart';

class MovieRepo {
  String mainUrl = 'https://api.themoviedb.org/3';
  String apiKey = 'api_key=d14708f2fca792ff1266207b85ee13f4';

  Future<List<MovieModel>> getNowPlayingMovie() async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/movie/now_playing?&page=1&$apiKey'))
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

  Future<List<MovieGenreModel>> getGenreList() async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/genre/movie/list?$apiKey'))
          .timeout(Duration(seconds: 8),
              onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['genres'];
      return resultList.map<MovieGenreModel>((dynamic e) {
        return MovieGenreModel.fromJson(json: e);
      }).toList();
    } catch (e) {
      print('MovieGenreList $e');
    }
    return [];
  }

  Future<List<MovieModel>> getLoadMovieListWithGenre(int genreId) async {
    try {
      http.Response res = await http
          .get(Uri.parse(
              '$mainUrl/discover/movie?with_genres=$genreId&primary_release_date.lte=2021-07-01&page=1&$apiKey'))
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
      print('MovieListWithGenre $e');
    }
    return [];
  }

  Future<List<MoviePersonModel>> getPerson() async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/trending/person/week?$apiKey'))
          .timeout(Duration(seconds: 8),
              onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      return resultList.map<MoviePersonModel>((dynamic e) {
        return MoviePersonModel.fromJson(json: e);
      }).toList();
    } catch (e) {
      print('MoviePerson $e');
    }
    return [];
  }

  Future<List<MovieModel>> getTopRated() async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/movie/top_rated?$apiKey&page=1'))
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
      print('MovieTopRated $e');
    }
    return [];
  }

  Future<MovieDetailModel> getMovieDetail(int movieId) async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/movie/$movieId?$apiKey'))
          .timeout(Duration(seconds: 8),
              onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return MovieDetailModel.fromJson({});
      }
      Map<String, dynamic> result = jsonDecode(res.body);

      MovieDetailModel movieDetail = MovieDetailModel.fromJson(result);
      return movieDetail;
    } catch (e) {
      print('MovieDetail $e');
    }
    return MovieDetailModel.fromJson({});
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

  Future<List<MovieCastModel>> getMovieCast(int movieId) async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/movie/$movieId/credits?$apiKey'))
          .timeout(Duration(seconds: 8),
              onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List castList = result['cast'];
      return castList.map<MovieCastModel>((dynamic e) {
        return MovieCastModel.fromJson(json: e);
      }).toList();
    } catch (e) {
      print('MovieCast $e');
    }
    return [];
  }

  Future<List<MovieModel>> getSimilarMovies(int movieId) async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/movie/$movieId/similar?$apiKey&page=1'))
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
      print('SimilarMovie $e');
    }
    return [];
  }

  Future<List<MovieModel>> getPopular() async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/movie/popular?$apiKey&page=1'))
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
      print('MoviePopular $e');
    }
    return [];
  }

  Future<List<MovieModel>> getUpcoming() async {
    try {
      http.Response res = await http
          .get(Uri.parse(
              '$mainUrl/movie/upcoming?primary_release_date.gte=2021-07-01&$apiKey&page=1'))
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
      print('MovieUpcoming $e');
    }
    return [];
  }

  Future<List<SearchModel>> getSearchMovie(String movieName) async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/search/movie?$apiKey&query=$movieName'))
          .timeout(Duration(seconds: 8),
              onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);

      List resultList = result['results'];
      // if (resultList[0]['poster_path'] != null)
      return resultList.map<SearchModel>((dynamic e) {
        return SearchModel.fromJson(json: e);
      }).toList();
    } catch (e) {
      print('SearchMovie : $e');
    }
    return [];
  }

  Future<List<SearchModel>> getSearchTv(String movieName) async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/search/tv?$apiKey&query=$movieName'))
          .timeout(Duration(seconds: 8),
              onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      if (resultList.isNotEmpty)
        return resultList.map<SearchModel>((dynamic e) {
          return SearchModel.fromJson(json: e);
        }).toList();
    } catch (e) {
      print('SearchTv : $e');
    }
    return [];
  }
}
