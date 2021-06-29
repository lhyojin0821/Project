import 'package:flutter/foundation.dart';
import 'package:tms/models/movie_video_model.dart';
import 'package:tms/repository/movie_repo.dart';

class MovieVideoProvider with ChangeNotifier {
  Future<List<MovieVideoModel>> movieVideoDetail({required int movieId}) async {
    List<MovieVideoModel> movieVideo = await new MovieRepo().getMovieVideo(movieId);
    notifyListeners();
    return movieVideo;
  }
}
