import 'package:flutter/foundation.dart';
import 'package:tms/models/movie_detail_model.dart';
import 'package:tms/repository/movie_repo.dart';

class MovieDetailProvider with ChangeNotifier {
  Future<List<MovieDetailModel>> movieDetail({required int movieId}) async {
    List<MovieDetailModel> movieDetail = await new MovieRepo().getMovieDetail(movieId);
    notifyListeners();
    return movieDetail;
  }
}
