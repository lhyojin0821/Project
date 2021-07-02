import 'package:flutter/foundation.dart';
import 'package:tms/models/movie_models/movie_person_model.dart';
import 'package:tms/repository/movie_repo.dart';

class MoviePersonProvider with ChangeNotifier {
  Future<List<MoviePersonModel>> moviePerson() async {
    List<MoviePersonModel> personList = await MovieRepo().getPerson();
    notifyListeners();
    return personList;
  }
}
