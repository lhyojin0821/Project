import 'package:tms/models/movie_models/movie_genre_model.dart';

class MovieDetailModel {
  final int id;
  final int budget;
  final List<MovieGenreModel> genres;
  final List companies;
  final String releaseDate;
  final int runtime;

  MovieDetailModel(
      {required this.id,
      required this.budget,
      required this.genres,
      required this.companies,
      required this.releaseDate,
      required this.runtime});

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json["id"] == null ? 0 : json['id'],
      budget: json["budget"] == null ? 0 : json['budget'],
      genres: (json["genres"] as List)
          .map((i) => new MovieGenreModel.fromJson(json: i))
          .toList(),
      companies: (json["production_companies"]),
      releaseDate: json["release_date"],
      runtime: json["runtime"],
    );
  }
}
