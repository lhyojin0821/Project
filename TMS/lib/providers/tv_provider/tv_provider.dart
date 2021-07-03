import 'package:flutter/foundation.dart';
import 'package:tms/models/tv_models/tv_model.dart';
import 'package:tms/models/tv_models/tv_person_model.dart';
import 'package:tms/repository/tv_repo.dart';

class TvProvider with ChangeNotifier {
  TvRepo _tvRepo = TvRepo();

  Future<List<TvModel>> onTheAir() async {
    List<TvModel> onTheAirList = await _tvRepo.getOnTheAir();
    notifyListeners();
    return onTheAirList;
  }

  Future<List<TvPersonModel>> tvPerson() async {
    List<TvPersonModel> personList = await _tvRepo.getPerson();
    notifyListeners();
    return personList;
  }

  Future<List<TvModel>> popular() async {
    List<TvModel> popularList = await _tvRepo.getPopular();
    notifyListeners();
    return popularList;
  }

  Future<List<TvModel>> airingToday() async {
    List<TvModel> airingTodayList = await _tvRepo.getAiringToday();
    notifyListeners();
    return airingTodayList;
  }

  Future<List<TvModel>> topRated() async {
    List<TvModel> topRatedList = await _tvRepo.getTopRated();
    notifyListeners();
    return topRatedList;
  }
}
