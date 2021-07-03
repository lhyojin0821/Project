import 'dart:convert';
import 'package:tms/models/tv_models/tv_cast_model.dart';
import 'package:tms/models/tv_models/tv_detail_model.dart';
import 'package:tms/models/tv_models/tv_genre_model.dart';
import 'package:tms/models/tv_models/tv_model.dart';
import 'package:http/http.dart' as http;
import 'package:tms/models/tv_models/tv_person_model.dart';
import 'package:tms/models/tv_models/tv_video_model.dart';

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
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<TvGenreModel>> getGenreList() async {
    try {
      http.Response res = await http.get(Uri.parse('$mainUrl/genre/tv/list?$apiKey')).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['genres'];
      return resultList.map<TvGenreModel>((dynamic e) {
        return TvGenreModel.fromJson(json: e);
      }).toList();
    } catch (e) {
      print(e);
    }
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
      return resultList.map<TvModel>((dynamic e) {
        return TvModel.fromJson(json: e);
      }).toList();
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<TvPersonModel>> getPerson() async {
    try {
      http.Response res = await http.get(Uri.parse('$mainUrl/trending/person/week?$apiKey')).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      return resultList.map<TvPersonModel>((dynamic e) {
        return TvPersonModel.fromJson(json: e);
      }).toList();
    } catch (e) {}
    return [];
  }

  Future<List<TvModel>> getPopular() async {
    try {
      http.Response res = await http.get(Uri.parse('$mainUrl/tv/popular?$apiKey')).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      return resultList.map<TvModel>((dynamic e) {
        return TvModel.fromJson(json: e);
      }).toList();
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<TvModel>> getAiringToday() async {
    try {
      http.Response res = await http.get(Uri.parse('$mainUrl/tv/airing_today?$apiKey')).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      return resultList.map<TvModel>((dynamic e) {
        return TvModel.fromJson(json: e);
      }).toList();
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<TvModel>> getTopRated() async {
    try {
      http.Response res = await http.get(Uri.parse('$mainUrl/tv/top_rated?$apiKey')).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      return resultList.map<TvModel>((dynamic e) {
        return TvModel.fromJson(json: e);
      }).toList();
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<TvDetailModel> getTvDetail(int tvId) async {
    try {
      http.Response res = await http.get(Uri.parse('$mainUrl/tv/$tvId?$apiKey')).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return TvDetailModel.fromJson({});
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      TvDetailModel tvDetail = TvDetailModel.fromJson(result);
      return tvDetail;
    } catch (e) {
      print('tvDetail: $e');
    }
    return TvDetailModel.fromJson({});
  }

  Future<List<TvVideoModel>> getTvVideo(int tvId) async {
    try {
      http.Response res = await http.get(Uri.parse('$mainUrl/tv/$tvId/videos?$apiKey')).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      return resultList.map<TvVideoModel>((dynamic e) {
        return TvVideoModel.fromJson(json: e);
      }).toList();
    } catch (e) {
      print('video: $e');
    }
    return [];
  }

  Future<List<TvCastModel>> getTvCast(int tvId) async {
    try {
      http.Response res = await http.get(Uri.parse('$mainUrl/tv/$tvId/credits?$apiKey')).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List castList = result['cast'];
      return castList.map<TvCastModel>((dynamic e) {
        return TvCastModel.fromJson(json: e);
      }).toList();
    } catch (e) {
      print('cast: $e');
    }
    return [];
  }

  Future<List<TvModel>> getSimilarTvs(int tvId) async {
    try {
      http.Response res = await http.get(Uri.parse('$mainUrl/tv/$tvId/similar?$apiKey&language=en-US&page=1')).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      return resultList.map<TvModel>((dynamic e) {
        return TvModel.fromJson(json: e);
      }).toList();
    } catch (e) {
      print('similar: $e');
    }
    return [];
  }
}
