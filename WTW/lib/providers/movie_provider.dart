import 'package:flutter/foundation.dart';
import 'package:wtw/models/movie_detail_model.dart';
import 'package:wtw/models/movie_model.dart';
import 'package:wtw/repository/repo.dart';

class MovieProvider with ChangeNotifier {
  MovieRepo _movieRepo = new MovieRepo();

  Future<MovieDetailModel> movies(int movieId) async {
    MovieDetailModel movieList = await _movieRepo.getMovie(movieId: movieId);
    notifyListeners();
    return movieList;
  }

  Future<List<MovieModel>> nowPlaying() async {
    List<MovieModel> nowPlayingList = await _movieRepo.getNowPlayingMovie();
    notifyListeners();
    return nowPlayingList;
  }
}
