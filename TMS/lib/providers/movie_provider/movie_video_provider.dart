import 'package:flutter/foundation.dart';
import 'package:tms/models/movie_models/movie_video_model.dart';
import 'package:tms/repository/movie_repo.dart';

class MovieVideoProvider with ChangeNotifier {
  MovieRepo _movieRepo = new MovieRepo();

  Future<List<MovieVideoModel>> movieVideoDetail({required int movieId}) async {
    List<MovieVideoModel> movieVideoList = await _movieRepo.getMovieVideo(movieId);
    notifyListeners();
    return movieVideoList;
  }
}
