import 'package:wtw/models/tv_model/tv_network_model.dart';

class TvDetailModel {
  final int id;
  final List<TvNetWorkModel> networks;
  final String lastAirDate;
  final String firstAirDate;
  final List runtime;
  final String posterPath;
  final double voteAverage;
  final String overView;
  final String name;

  TvDetailModel(
      {required this.id,
      required this.networks,
      required this.lastAirDate,
      required this.firstAirDate,
      required this.runtime,
      required this.posterPath,
      required this.voteAverage,
      required this.overView,
      required this.name});

  factory TvDetailModel.fromJson(Map<String, dynamic> json) {
    return TvDetailModel(
      id: json["id"] == null ? 0 : json['id'],
      networks: (json["networks"] as List)
          .map((i) => new TvNetWorkModel.fromJson(json: i))
          .toList(),
      lastAirDate: json["last_air_date"] == null ? '' : json['last_air_date'],
      firstAirDate:
          json["first_air_date"] == null ? '' : json['first_air_date'],
      runtime:
          json["episode_run_time"] == null ? [] : (json['episode_run_time']),
      posterPath: json["poster_path"] == null ? '' : json['poster_path'],
      voteAverage:
          json["vote_average"] == null ? 0.0 : json['vote_average'].toDouble(),
      overView: json["overview"] == null ? '' : json['overview'],
      name: json["name"] == null ? '' : json['name'],
    );
  }
}
