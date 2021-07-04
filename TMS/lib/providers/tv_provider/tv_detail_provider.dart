import 'package:flutter/foundation.dart';
import 'package:tms/models/tv_models/tv_cast_model.dart';
import 'package:tms/models/tv_models/tv_detail_model.dart';
import 'package:tms/models/tv_models/tv_model.dart';
import 'package:tms/repository/tv_repo.dart';

class TvDetailProvider with ChangeNotifier {
  TvRepo _tvRepo = TvRepo();

  Future<TvDetailModel> tvDetail({required int tvId}) async {
    TvDetailModel tvDetail = await _tvRepo.getTvDetail(tvId);
    notifyListeners();
    return tvDetail;
  }

  Future<List<TvCastModel>> tvCast({required int tvId}) async {
    List<TvCastModel> tvCastList = await _tvRepo.getTvCast(tvId);
    notifyListeners();
    return tvCastList;
  }

  Future<List<TvModel>> similar({required int tvId}) async {
    List<TvModel> similarList = await _tvRepo.getSimilarTvs(tvId);
    notifyListeners();
    return similarList;
  }

  // Future<List<TvVideoModel>> tvVideoDetail({required int tvId}) async {
  //   List<TvVideoModel> tvVideoList = await _tvRepo.getTvVideo(tvId);
  //   notifyListeners();
  //   return tvVideoList;
  // }
}
