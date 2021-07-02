import 'package:flutter/foundation.dart';
import 'package:tms/models/movie_models/movie_genre_model.dart';

import 'package:tms/models/movie_models/movie_model.dart';
import 'package:tms/repository/movie_repo.dart';

class MovieGenreProvider with ChangeNotifier {
  MovieRepo _movieRepo = MovieRepo();
  List movies = <MovieModel>[];
  int genreId = -1;

  Future<List<MovieGenreModel>> loadGenre() async {
    var genreList = await this._movieRepo.getGenreList();
    if (genreList.isNotEmpty) {
      this.genreId = genreList.first.id.toInt();
      _loadMovieListWithGenre();
    }
    return genreList;
  }

  void _loadMovieListWithGenre() async {
    this.movies = await _movieRepo.getLoadMovieListWithGenre(genreId);
    notifyListeners();
    return;
  }

  void changeGenreList(MovieGenreModel genre) {
    this.genreId = genre.id;
    notifyListeners();
    _loadMovieListWithGenre();
  }
}
