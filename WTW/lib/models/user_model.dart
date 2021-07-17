class UserModel {
  String id;
  String email;
  String name;
  List<int>? userMovieId;

  UserModel(
      {required this.id,
      required this.email,
      required this.name,
      this.userMovieId});

  static late UserModel current;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'] == null ? '' : json['id'],
        email: json['email'] == null ? '' : json['email'],
        name: json['name'] == null ? '' : json['name'],
        userMovieId: json['userMovieId'] == null ? [] : json['userMovieId']);
  }
  Map<String, dynamic> toMap() => {
        'id': id,
        'email': email,
        'name': name,
        'userMovieId': userMovieId,
      };
}
