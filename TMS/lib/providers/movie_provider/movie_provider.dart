import 'package:flutter/foundation.dart';
import 'package:tms/models/movie_models/movie_model.dart';
import 'package:tms/repository/movie_repo.dart';

class MovieProvider with ChangeNotifier {
  MovieRepo _movieRepo = MovieRepo();

  Future<List<MovieModel>> nowPlaying() async {
    List<MovieModel> nowPlayingList = await _movieRepo.getNowPlayingMovie();
    notifyListeners();
    return nowPlayingList;
  }

  Future<List<MovieModel>> topRated() async {
    List<MovieModel> topRatedList = await _movieRepo.getTopRated();
    notifyListeners();
    return topRatedList;
  }

  Future<List<MovieModel>> popular() async {
    List<MovieModel> popular = await _movieRepo.getPopular();
    notifyListeners();
    return popular;
  }

  Future<List<MovieModel>> upcoming() async {
    List<MovieModel> upcoming = await _movieRepo.getUpcoming();
    notifyListeners();
    return upcoming;
  }
}
