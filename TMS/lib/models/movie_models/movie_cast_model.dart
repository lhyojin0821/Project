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
      name: json['name'] == null ? '' : json['name'].toString(),
      profilePath: json['profile_path'] == null ? '' : json['profile_path'].toString(),
      character: json['character'] == null ? '' : json['character'].toString(),
    );
  }
}
