class TvModel {
  int id;
  String backdropPath;
  List<int> genreIds;
  String originalLanguage;
  String originalName;
  String overView;
  double popularity;
  String posterPath;
  DateTime? firstAirData;
  String name;
  double voteAverage;
  int voteCount;

  TvModel({
    required this.id,
    required this.backdropPath,
    required this.genreIds,
    required this.originalLanguage,
    required this.originalName,
    required this.overView,
    required this.popularity,
    required this.posterPath,
    required this.firstAirData,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvModel.fromJson({required Map<String, dynamic> json}) => TvModel(
        id: json["id"] == null ? 0 : json['id'],
        backdropPath: json["backdrop_path"] == null ? '' : json['backdrop_path'],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        originalLanguage: json["original_language"] == null ? '' : json['original_language'],
        originalName: json["original_name"] == null ? '' : json['original_name'],
        overView: json["overview"] == null ? '' : json['overview'],
        popularity: json["popularity"] == null ? 0.0 : json['popularity'].toDouble(),
        posterPath: json["poster_path"] == null ? '' : json['poster_path'],
        firstAirData: json["first_air_date"] != null ? DateTime.parse(json["first_air_date"]) : null,
        name: json["name"] == null ? '' : json['name'],
        voteAverage: json["vote_average"] == null ? 0.0 : json['vote_average'].toDouble(),
        voteCount: json["vote_count"] == null ? 0 : json['vote_count'],
      );
}
