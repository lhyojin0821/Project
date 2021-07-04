class TvModel {
  final int id;
  final String backdropPath;
  final List<int> genreIds;
  final String originalLanguage;
  final String originalName;
  final String overView;
  final double popularity;
  final String posterPath;
  final String firstAirDate;
  final String name;
  final double voteAverage;
  final int voteCount;

  TvModel({
    required this.id,
    required this.backdropPath,
    required this.genreIds,
    required this.originalLanguage,
    required this.originalName,
    required this.overView,
    required this.popularity,
    required this.posterPath,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    required this.firstAirDate,
  });

  factory TvModel.fromJson({required Map<String, dynamic> json}) => TvModel(
        id: json["id"] == null ? '' : json['id'],
        backdropPath:
            json["backdrop_path"] == null ? '' : json['backdrop_path'],
        genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
        originalLanguage:
            json["original_language"] == null ? '' : json['original_language'],
        originalName:
            json["original_name"] == null ? '' : json['original_name'],
        overView: json["overview"] == null ? '' : json['overview'],
        popularity:
            json["popularity"] == null ? 0.0 : json['popularity'].toDouble(),
        posterPath: json["poster_path"] == null ? '' : json['poster_path'],
        firstAirDate:
            json["first_air_date"] == null ? '' : json['first_air_date'],
        name: json["name"] == null ? '' : json['name'],
        voteAverage: json["vote_average"] == null
            ? 0.0
            : json['vote_average'].toDouble(),
        voteCount: json["vote_count"] == null ? 0 : json['vote_count'],
      );
}
