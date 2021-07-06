class SearchModel {
  final String posterPath;
  final String backdropPath;
  final String name;
  final int id;
  final double voteAverage;
  final String overView;

  SearchModel({
    required this.posterPath,
    required this.backdropPath,
    required this.name,
    required this.id,
    required this.voteAverage,
    required this.overView,
  });

  factory SearchModel.fromJson({required Map<String, dynamic> json}) =>
      SearchModel(
        posterPath:
            json["poster_path"] == null ? '' : json['poster_path'].toString(),
        backdropPath: json["backdrop_path"] == null
            ? ''
            : json['backdrop_path'].toString(),
        name: json["name"] == null ? '' : json['name'],
        id: json["id"] == null ? 0 : json['id'],
        voteAverage: json["vote_average"] == null
            ? 0.0
            : json['vote_average'].toDouble(),
        overView: json["overview"] == null ? '' : json['overview'],
      );
}
