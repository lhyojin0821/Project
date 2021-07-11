import 'package:flutter/foundation.dart';
import 'package:wtw/models/movie_model/movie_model.dart';
import 'package:wtw/repository/movie_repo.dart';

class MovieNowPlayingProvider with ChangeNotifier {
  MovieRepo _movieRepo = new MovieRepo();

  Future<List<MovieModel>> nowPlaying() async {
    List<MovieModel> nowPlayingList = await _movieRepo.getMovieNowPlaying();
    notifyListeners();
    return nowPlayingList;
  }
}
