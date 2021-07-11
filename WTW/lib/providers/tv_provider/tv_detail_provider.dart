import 'package:flutter/foundation.dart';
import 'package:wtw/models/tv_model/tv_detail_model.dart';
import 'package:wtw/repository/tv_repo.dart';

class TvDetailProvider with ChangeNotifier {
  TvRepo _tvRepo = new TvRepo();

  Future<TvDetailModel> tvs(int tvId) async {
    TvDetailModel tvList = await _tvRepo.getTvDetail(tvId);
    notifyListeners();
    return tvList;
  }
}
