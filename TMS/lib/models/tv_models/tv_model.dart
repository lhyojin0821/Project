class TvModel {
  int id;
  List originCountry;
  String backdropPath;
  List<int> genreIds;
  String originalLanguage;
  String originalName;
  String overView;
  double popularity;
  String posterPath;
  DateTime? firstAirDate;
  String name;
  double voteAverage;
  int voteCount;

  TvModel({
    required this.id,
    required this.originCountry,
    required this.backdropPath,
    required this.genreIds,
    required this.originalLanguage,
    required this.originalName,
    required this.overView,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvModel.fromJson({required Map<String, dynamic> json}) => TvModel(
        id: json["id"],
        originCountry: json["origin_country"],
        backdropPath: json["backdrop_path"] ?? '',
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overView: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        firstAirDate: json["first_air_date"] != null ? DateTime.parse(json["first_air_date"]) : null,
        name: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}
