import 'package:flutter/foundation.dart';
import 'package:wtw/models/tv_model/tv_video_model.dart';
import 'package:wtw/repository/tv_repo.dart';

class TvVideoProvider with ChangeNotifier {
  TvRepo _tvRepo = new TvRepo();

  Future<List<TvVideoModel>> tvVideoDetail({required int tvId}) async {
    List<TvVideoModel> tvVideoList = await _tvRepo.getTvVideo(tvId);
    notifyListeners();
    return tvVideoList;
  }
}
