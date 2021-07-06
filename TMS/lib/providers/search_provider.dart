import 'package:flutter/foundation.dart';
import 'package:tms/models/search_model.dart';
import 'package:tms/repository/movie_repo.dart';

class SearchProvider with ChangeNotifier {
  MovieRepo _movieRepo = MovieRepo();

  Future<List<SearchModel>> searchMovie({required String movieName}) async {
    List<SearchModel> searchList = await _movieRepo.getSearchMovie(movieName);
    if (searchList.isNotEmpty) notifyListeners();
    return searchList;
  }

  Future<List<SearchModel>> searchTv({required String movieName}) async {
    List<SearchModel> searchList = await _movieRepo.getSearchTv(movieName);
    if (searchList.isNotEmpty) notifyListeners();
    return searchList;
  }
}
