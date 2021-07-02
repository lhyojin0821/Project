class MovieCastModel {
  final String name;
  final String profilePath;
  final String character;

  MovieCastModel({
    required this.name,
    required this.profilePath,
    required this.character,
  });

  factory MovieCastModel.fromJson({required Map<String, dynamic> json}) {
    return MovieCastModel(
      name: json['name'],
      profilePath: json['profile_path'],
      character: json['character'],
    );
  }
}
