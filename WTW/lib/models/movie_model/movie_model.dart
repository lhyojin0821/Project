class MovieModel {
  final int id;
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final String originalLanguage;
  final String originalTitle;
  final String overView;
  final double popularity;
  final String posterPath;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;

  MovieModel({
    required this.id,
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overView,
    required this.popularity,
    required this.posterPath,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
  });

  factory MovieModel.fromJson({required Map<String, dynamic> json}) =>
      MovieModel(
        id: json["id"] == null ? 0 : json['id'],
        adult: json["adult"] == null ? false : json['adult'],
        backdropPath:
            json["backdrop_path"] == null ? '' : json['backdrop_path'],
        genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
        originalLanguage:
            json["original_language"] == null ? '' : json['original_language'],
        originalTitle:
            json["original_title"] == null ? '' : json['original_title'],
        overView: json["overview"] == null ? '' : json['overview'],
        popularity:
            json["popularity"] == null ? 0.0 : json['popularity'].toDouble(),
        posterPath: json["poster_path"] == null ? '' : json['poster_path'],
        title: json["title"] == null ? '' : json['title'],
        video: json["video"] == null ? false : json['video'],
        voteAverage: json["vote_average"] == null
            ? 0.0
            : json['vote_average'].toDouble(),
        voteCount: json["vote_count"] == null ? 0 : json['vote_count'],
        releaseDate: json["release_date"] == null ? '' : json['release_date'],
      );
}
