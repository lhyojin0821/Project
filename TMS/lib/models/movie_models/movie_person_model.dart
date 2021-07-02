class MoviePersonModel {
  final String id;
  final String gender;
  final String name;
  final String profilePath;
  final String knownForDepartment;
  final String popularity;

  MoviePersonModel({required this.id, required this.gender, required this.name, required this.profilePath, required this.knownForDepartment, required this.popularity});

  factory MoviePersonModel.fromJson({required Map<String, dynamic> json}) {
    return MoviePersonModel(
      id: json['id'].toString(),
      gender: json['gender'].toString(),
      name: json['name'],
      profilePath: json['profile_path'],
      knownForDepartment: json['known_for_department'].toString(),
      popularity: json['popularity'].toString(),
    );
  }
}
