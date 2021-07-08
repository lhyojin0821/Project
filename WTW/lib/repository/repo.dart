import 'dart:convert';
import 'package:wtw/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieRepo {
  String mainUrl = 'https://api.reelgood.com/';
  String subUrl = 'v3.0/content/random';

  Future<List<MovieModel>> getMovie(int genre, int minImdb) async {
    try {
      Map<String, dynamic> params = {
        "availability": "onAnySource",
        "content_kind": "movie",
        "genre": genre,
        "minimum_imdb": minImdb,
        "source": "netflix",
        "region": "kr",
        "nocache": true,
      };
      http.Response res = await http
          .get(Uri.https('$mainUrl', '$subUrl', params))
          .timeout(Duration(seconds: 8),
              onTimeout: () async => new http.Response('{}', 404));
      if (res.statusCode == 404) {
        return [];
      }
      print(res.body);
      Map<String, dynamic> result = jsonDecode(res.body);
      List resultList = result['availability'];
      return resultList.map<MovieModel>((dynamic e) {
        return MovieModel.fromJson(json: e);
      }).toList();
    } catch (e) {
      print('Movie : $e');
    }
    return [];
  }
}
