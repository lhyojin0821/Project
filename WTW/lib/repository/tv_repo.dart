import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wtw/models/tv_model/tv_detail_model.dart';
import 'package:wtw/models/tv_model/tv_model.dart';
import 'package:wtw/models/tv_model/tv_video_model.dart';

class TvRepo {
  String mainUrl = 'https://api.themoviedb.org/3';
  String apiKey = 'api_key=d14708f2fca792ff1266207b85ee13f4';

  Future<TvDetailModel> getTvDetail(int? tvId) async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/tv/$tvId?$apiKey&language=ko-KR'))
          .timeout(Duration(seconds: 8),
              onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return TvDetailModel.fromJson({});
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      TvDetailModel tvs = TvDetailModel.fromJson(result);
      return tvs;
    } catch (e) {
      print('TvDetail $e');
    }
    return TvDetailModel.fromJson({});
  }

  Future<List<TvModel>> getTvRecommendation(
    int genreId,
    int pageId,
  ) async {
    try {
      http.Response res = await http
          .get(Uri.parse(
              '$mainUrl/discover/tv?$apiKey&sort_by=popularity.desc&language=en-US&with_genres=$genreId&page=$pageId&first_air_date.gte=2000-01-01&first_air_date.lte=2021-07-01&include_adult=false&without_genres=16'))
          .timeout(Duration(seconds: 8),
              onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      return resultList.map<TvModel>((dynamic e) {
        return TvModel.fromJson(json: e);
      }).toList();
    } catch (e) {
      print('getTvRecommendation $e');
    }
    return [];
  }

  Future<List<TvModel>> getTvPopular() async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/tv/popular?$apiKey&language=ko-KR'))
          .timeout(Duration(seconds: 8),
              onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      return resultList.map<TvModel>((dynamic e) {
        return TvModel.fromJson(json: e);
      }).toList();
    } catch (e) {
      print('TvPopular $e');
    }
    return [];
  }

  Future<List<TvVideoModel>> getTvVideo(int tvId) async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/tv/$tvId/videos?$apiKey'))
          .timeout(Duration(seconds: 8),
              onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['results'];
      return resultList.map<TvVideoModel>((dynamic e) {
        return TvVideoModel.fromJson(json: e);
      }).toList();
    } catch (e) {
      print('TvVideo $e');
    }
    return [];
  }
}
