import 'package:flutter/foundation.dart';
import 'package:tms/models/movie_person_model.dart';

import 'package:tms/repository/movie_repo.dart';

class MoviePersonProvider with ChangeNotifier {
  MovieRepo _movieRepo = MovieRepo();

  Future<List<MoviePersonModel>> moviePerson() async {
    List<MoviePersonModel> personList = await _movieRepo.getPerson();
    notifyListeners();
    return personList;
  }
}
