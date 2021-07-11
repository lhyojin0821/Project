import 'package:flutter/foundation.dart';
import 'package:wtw/models/tv_model/tv_model.dart';
import 'package:wtw/repository/tv_repo.dart';

class TvPopularProvider with ChangeNotifier {
  TvRepo _tvRepo = new TvRepo();

  Future<List<TvModel>> popular() async {
    List<TvModel> popularList = await _tvRepo.getTvPopular();
    notifyListeners();
    return popularList;
  }
}
