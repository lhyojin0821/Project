import 'package:flutter/foundation.dart';
import 'package:tms/models/movie_models/movie_cast_model.dart';
import 'package:tms/models/movie_models/movie_detail_model.dart';
import 'package:tms/models/movie_models/movie_model.dart';
import 'package:tms/repository/movie_repo.dart';

class MovieDetailProvider with ChangeNotifier {
  MovieRepo _movieRepo = MovieRepo();

  Future<MovieDetailModel> movieDetail({required int movieId}) async {
    MovieDetailModel movieDetail = await _movieRepo.getMovieDetail(movieId);
    notifyListeners();
    return movieDetail;
  }

  Future<List<MovieCastModel>> movieCast({required int movieId}) async {
    List<MovieCastModel> movieCast = await _movieRepo.getMovieCast(movieId);
    notifyListeners();
    return movieCast;
  }

  Future<List<MovieModel>> similar({required int movieId}) async {
    List<MovieModel> similarList = await _movieRepo.getSimilarMovies(movieId);
    notifyListeners();
    return similarList;
  }
}
