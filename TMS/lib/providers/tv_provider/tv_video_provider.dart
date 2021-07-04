import 'package:flutter/foundation.dart';
import 'package:tms/models/tv_models/tv_video_model.dart';
import 'package:tms/repository/tv_repo.dart';

class TvVideoProvider with ChangeNotifier {
  TvRepo _tvRepo = new TvRepo();
  Future<List<TvVideoModel>> tvVideoDetail({required int tvId}) async {
    List<TvVideoModel> tvVideoList = await _tvRepo.getTvVideo(tvId);
    notifyListeners();
    return tvVideoList;
  }
}
