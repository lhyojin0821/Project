import 'package:flutter/foundation.dart';
import 'package:tms/models/movie_models/movie_model.dart';
import 'package:tms/models/tv_models/tv_genre_model.dart';
import 'package:tms/repository/tv_repo.dart';

class TvGenreProvider with ChangeNotifier {
  TvRepo _tvRepo = TvRepo();
  List tvs = <MovieModel>[];
  int genreId = -1;

  Future<List<TvGenreModel>> loadGenre() async {
    var genreList = await this._tvRepo.getGenreList();
    if (genreList.isNotEmpty) {
      this.genreId = genreList.first.id.toInt();
      _loadTvListWithGenre();
    }
    return genreList;
  }

  void _loadTvListWithGenre() async {
    this.tvs = await _tvRepo.getLoadTvListWithGenre(genreId);
    notifyListeners();
    return;
  }

  void changeGenreList(TvGenreModel genre) {
    this.genreId = genre.id;
    notifyListeners();
    _loadTvListWithGenre();
  }
}
