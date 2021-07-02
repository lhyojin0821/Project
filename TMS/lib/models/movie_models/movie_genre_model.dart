class MovieGenreModel {
  int id;
  String name;

  MovieGenreModel({required this.id, required this.name});

  factory MovieGenreModel.fromJson({required Map<String, dynamic> json}) {
    return MovieGenreModel(id: json['id'], name: json['name']);
  }
}
