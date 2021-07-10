import 'dart:convert';
import 'package:wtw/models/tv_model/tv_detail_model.dart';
import 'package:wtw/models/tv_model/tv_model.dart';
import 'package:http/http.dart' as http;

class TvRepo {
  String mainUrl = 'https://api.themoviedb.org/3';
  String apiKey = 'api_key=d14708f2fca792ff1266207b85ee13f4';

  // List<int> tvList = [];

  Future<TvDetailModel> getTv({int? tvId}) async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/tv/$tvId?$apiKey'))
          .timeout(Duration(seconds: 8),
              onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return TvDetailModel.fromJson({});
      }
      Map<String, dynamic> result = jsonDecode(res.body);
      // this.movieList.addAll(result['id']);
      TvDetailModel tvs = TvDetailModel.fromJson(result);
      return tvs;
    } catch (e) {
      print('TvDetail $e');
    }
    return TvDetailModel.fromJson({});
  }

  Future<List<TvModel>> getPopular() async {
    try {
      http.Response res = await http
          .get(Uri.parse('$mainUrl/tv/popular?$apiKey'))
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
}
