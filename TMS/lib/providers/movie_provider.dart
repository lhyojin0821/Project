import 'package:flutter/foundation.dart';
import 'package:tms/models/movie_model.dart';
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
}
