class MovieDetailModel {
  final int id;

  final String releaseDate;
  final int runtime;
  final String posterPath;
  final double voteAverage;
  final String overView;
  final String title;
  final bool video;

  MovieDetailModel({
    required this.id,
    required this.releaseDate,
    required this.runtime,
    required this.posterPath,
    required this.voteAverage,
    required this.overView,
    required this.title,
    required this.video,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json["id"] == null ? 0 : json['id'],
      releaseDate: json["release_date"] == null ? '' : json['release_date'],
      runtime: json["runtime"] == null ? 0 : json['runtime'],
      posterPath: json["poster_path"] == null ? '' : json['poster_path'],
      voteAverage:
          json["vote_average"] == null ? 0.0 : json['vote_average'].toDouble(),
      overView: json["overview"] == null ? '' : json['overview'],
      title: json["title"] == null ? '' : json['title'],
      video: json["video"] == null ? false : json['video'],
    );
  }
}
