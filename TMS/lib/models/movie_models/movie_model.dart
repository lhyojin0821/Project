class MovieModel {
  int id;
  bool adult;
  String backdropPath;
  List<int> genreIds;
  String originalLanguage;
  String originalTitle;
  String overView;
  double popularity;
  String posterPath;
  DateTime? releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

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
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieModel.fromJson({required Map<String, dynamic> json}) => MovieModel(
        id: json["id"],
        adult: json["adult"],
        backdropPath: json["backdrop_path"] ?? '',
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overView: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"] != null ? DateTime.parse(json["release_date"]) : null,
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}
