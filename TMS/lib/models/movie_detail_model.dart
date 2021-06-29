import 'package:flutter/foundation.dart';
import 'package:tms/models/movie_genre_model.dart';

class MovieDetailModel {
  int id;
  bool adult;
  String budget;
  List<MovieGenreModel> genres;
  String releaseDate;
  int runtime;

  String? trailerId;

  MovieDetailModel({required this.id, required this.adult, required this.budget, required this.genres, required this.releaseDate, required this.runtime});

  factory MovieDetailModel.fromJson({required dynamic json}) {
    return MovieDetailModel(id: json["id"], adult: json["adult"], budget: json["budget"], genres: json["genres"].map((i) => new MovieGenreModel.fromJson(json: i)).toList(), releaseDate: json["release_date"], runtime: json["runtime"]);
  }
}
