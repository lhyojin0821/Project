class MovieDetailModel {
  final int id;
  final List companies;
  final String releaseDate;
  final int runtime;
  final String posterPath;
  final double voteAverage;
  final String overView;
  final String title;

  MovieDetailModel(
      {required this.id,
      required this.companies,
      required this.releaseDate,
      required this.runtime,
      required this.posterPath,
      required this.voteAverage,
      required this.overView,
      required this.title});

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json["id"] == null ? 0 : json['id'],
      companies: (json["production_companies"]),
      releaseDate: json["release_date"],
      runtime: json["runtime"],
      posterPath: json["poster_path"],
      voteAverage:
          json["vote_average"] == null ? 0.0 : json['vote_average'].toDouble(),
      overView: json["overview"] == null ? '' : json['overview'],
      title: json["title"] == null ? '' : json['title'],
    );
  }
}
