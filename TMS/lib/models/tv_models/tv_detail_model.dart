import 'package:tms/models/tv_models/tv_genre_model.dart';
import 'package:tms/models/tv_models/tv_networks_model.dart';

class TvDetailModel {
  final int id;
  final List<TvGenreModel> genres;
  final List<TvNetWorksModel> networks;
  final String firstAirDate;
  final String lastAirDate;

  TvDetailModel({required this.id, required this.genres, required this.networks, required this.firstAirDate, required this.lastAirDate});

  factory TvDetailModel.fromJson(Map<String, dynamic> json) {
    return TvDetailModel(
      id: json["id"] == null ? 0 : json['id'],
      genres: (json["genres"] as List).map((i) => new TvGenreModel.fromJson(json: i)).toList(),
      networks: (json["networks"] as List).map((i) => new TvNetWorksModel.fromJson(json: i)).toList(),
      firstAirDate: json["first_air_date"] == null ? null : json['first_air_date'],
      lastAirDate: json["last_air_date"] == null ? null : json['last_air_date'],
    );
  }
}
