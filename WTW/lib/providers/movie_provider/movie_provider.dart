import 'package:flutter/foundation.dart';
import 'package:wtw/models/movie_model/movie_model.dart';
import 'package:wtw/repository/movie_repo.dart';

class MovieProvider with ChangeNotifier {
  MovieRepo _movieRepo = new MovieRepo();

  Future<List<MovieModel>> nowPlaying() async {
    List<MovieModel> nowPlayingList = await _movieRepo.getNowPlayingMovie();
    await _movieRepo.getMovieId();
    notifyListeners();
    return nowPlayingList;
  }
}
