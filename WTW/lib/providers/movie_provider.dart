import 'package:flutter/foundation.dart';
import 'package:wtw/models/movie_model.dart';
import 'package:wtw/repository/repo.dart';

class MovieProvider with ChangeNotifier {
  MovieRepo _movieRepo = new MovieRepo();

  Future<List<MovieModel>> movies(int genre, int minImdb) async {
    List<MovieModel> movieList = await _movieRepo.getMovie(genre, minImdb);
    notifyListeners();
    return movieList;
  }
}
