class TvGenreModel {
  final int id;
  final String name;

  TvGenreModel({required this.id, required this.name});

  factory TvGenreModel.fromJson({required Map<String, dynamic> json}) {
    return TvGenreModel(id: json['id'], name: json['name']);
  }
}
