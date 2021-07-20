class UserModel {
  String id;
  String email;
  String name;
  List? userMovie;
  List? userTv;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.userMovie,
    this.userTv,
  });

  static late UserModel current;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] == null ? '' : json['id'],
      email: json['email'] == null ? '' : json['email'],
      name: json['name'] == null ? '' : json['name'],
      userMovie: json['userMovie'] == null ? [] : json['userMovie'],
      userTv: json['userTv'] == null ? [] : json['userTv'],
    );
  }
  Map<String, dynamic> toMap() => {
        'id': id,
        'email': email,
        'name': name,
        'userMovie': userMovie,
        'userTv': userTv,
      };
}
