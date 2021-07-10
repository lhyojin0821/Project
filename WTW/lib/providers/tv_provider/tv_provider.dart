import 'package:flutter/foundation.dart';
import 'package:wtw/models/tv_model/tv_model.dart';
import 'package:wtw/repository/tv_repo.dart';

class TvProvider with ChangeNotifier {
  TvRepo _tvRepo = TvRepo();

  Future<List<TvModel>> popular() async {
    List<TvModel> popularList = await _tvRepo.getPopular();
    notifyListeners();
    return popularList;
  }
}
