import 'package:flutter/foundation.dart';
import 'package:wtw/models/movie_model/movie_video_model.dart';
import 'package:wtw/repository/movie_repo.dart';

class MovieVideoProvider with ChangeNotifier {
  MovieRepo _movieRepo = new MovieRepo();

  Future<List<MovieVideoModel>> movieVideoDetail({required int movieId}) async {
    List<MovieVideoModel> movieVideoList =
        await _movieRepo.getMovieVideo(movieId);
    notifyListeners();
    return movieVideoList;
  }
}
