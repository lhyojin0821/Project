class MovieVideoModel {
  final String id;
  final String key;
  final String name;
  final String site;
  final String type;

  MovieVideoModel(
      {required this.id,
      required this.key,
      required this.name,
      required this.site,
      required this.type});

  factory MovieVideoModel.fromJson({required Map<String, dynamic> json}) {
    return MovieVideoModel(
      id: json['id'],
      key: json['key'],
      name: json['name'],
      site: json['site'],
      type: json['type'],
    );
  }
}
