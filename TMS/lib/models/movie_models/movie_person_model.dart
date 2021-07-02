class MoviePersonModel {
  String id;
  String gender;
  String name;
  String profilePath;
  String knownForDepartment;
  String popularity;

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
