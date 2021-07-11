import 'package:flutter/foundation.dart';
import 'package:wtw/models/tv_model/tv_model.dart';
import 'package:wtw/repository/tv_repo.dart';

class TvRecommendationProvider with ChangeNotifier {
  TvRepo _tvRepo = new TvRepo();

  Future<List<TvModel>> tvRecommendation(
    int genreId,
    int pageId,
  ) async {
    List<TvModel> tvRecommendationList = await _tvRepo.getTvRecommendation(
      genreId,
      pageId,
    );
    notifyListeners();
    return tvRecommendationList;
  }
}
