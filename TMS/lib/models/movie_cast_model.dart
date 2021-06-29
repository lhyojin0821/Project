class MovieCastModel {
  int id;
  String character;
  String name;
  String profilePath;

  MovieCastModel({required this.id, required this.character, required this.name, required this.profilePath});

  factory MovieCastModel.fromJson({required Map<String, dynamic> json}) {
    return MovieCastModel(id: json['id'], character: json['character'], name: json['name'], profilePath: json['profile_path']);
  }
}
