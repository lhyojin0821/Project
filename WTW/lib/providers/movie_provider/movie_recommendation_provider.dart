import 'package:flutter/foundation.dart';
import 'package:wtw/models/movie_model/movie_model.dart';
import 'package:wtw/repository/movie_repo.dart';

class MovieRecommendationProvider with ChangeNotifier {
  MovieRepo _movieRepo = new MovieRepo();

  Future<List<MovieModel>> movieRecommendation(
    int genreId,
    int pageId,
  ) async {
    List<MovieModel> movieRecommendationList =
        await _movieRepo.getMovieRecommendation(
      genreId,
      pageId,
    );
    notifyListeners();
    return movieRecommendationList;
  }
}
