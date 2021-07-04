class TvVideoModel {
  final String id;
  final String key;
  final String name;
  final String site;
  final String type;

  TvVideoModel({required this.id, required this.key, required this.name, required this.site, required this.type});

  factory TvVideoModel.fromJson({required Map<String, dynamic> json}) {
    return TvVideoModel(
      id: json['id'] == null ? '' : json['id'].toString(),
      key: json['key'] == null ? '' : json['key'].toString(),
      name: json['name'] == null ? '' : json['name'].toString(),
      site: json['site'] == null ? '' : json['site'].toString(),
      type: json['type'] == null ? '' : json['type'].toString(),
    );
  }
}
