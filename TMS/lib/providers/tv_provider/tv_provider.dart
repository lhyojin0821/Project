import 'package:flutter/foundation.dart';
import 'package:tms/models/tv_models/tv_model.dart';
import 'package:tms/repository/tv_repo.dart';

class TvProvider with ChangeNotifier {
  TvRepo _tvRepo = TvRepo();

  Future<List<TvModel>> onTheAir() async {
    List<TvModel> onTheAirList = await _tvRepo.getOnTheAir();
    notifyListeners();
    return onTheAirList;
  }
}
