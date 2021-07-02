import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tms/models/tv_models/tv_model.dart';

class TvRepo {
  String mainUrl = 'https://api.themoviedb.org/3';
  String apiKey = 'api_key=d14708f2fca792ff1266207b85ee13f4';

  Future<List<TvModel>> getOnTheAir() async {
    try {
      http.Response res = await http
          .get(
            Uri.parse('$mainUrl/tv/on_the_air?$apiKey&page=6'),
          )
          .timeout(Duration(seconds: 8), onTimeout: () async => new http.Response('{}', 404));
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
}
