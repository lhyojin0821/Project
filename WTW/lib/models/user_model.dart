class UserModel {
  String id;
  String email;
  String name;
  // List? userMovieId;
  List? userMovie;
  bool? favorite;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    // this.userMovieId
    this.userMovie,
    this.favorite,
  });

  static late UserModel current;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] == null ? '' : json['id'],
      email: json['email'] == null ? '' : json['email'],
      name: json['name'] == null ? '' : json['name'],
      // userMovieId: json['userMovieId'] == null ? [] : json['userMovieId']
      userMovie: json['userMovie'] == null ? [{}] : json['userMovie'],
      favorite: json['favorite'],
    );
  }
  Map<String, dynamic> toMap() => {
        'id': id,
        'email': email,
        'name': name,
        // 'userMovieId': userMovieId,
        'userMovie': userMovie,
        'favorite': favorite,
      };
}
