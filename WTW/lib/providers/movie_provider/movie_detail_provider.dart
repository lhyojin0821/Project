import 'package:flutter/foundation.dart';
import 'package:wtw/models/movie_model/movie_detail_model.dart';
import 'package:wtw/repository/movie_repo.dart';

class MovieDetailProvider with ChangeNotifier {
  MovieRepo _movieRepo = new MovieRepo();

  Future<MovieDetailModel> movies(int movieId) async {
    MovieDetailModel movieList = await _movieRepo.getMovie(movieId: movieId);
    notifyListeners();
    return movieList;
  }
}
