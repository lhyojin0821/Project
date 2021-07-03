class TvNetWorksModel {
  final int id;
  final String name;
  final String logoPath;

  TvNetWorksModel({required this.id, required this.name, required this.logoPath});

  factory TvNetWorksModel.fromJson({required Map<String, dynamic> json}) {
    return TvNetWorksModel(
      id: json['id'],
      name: json['name'] == null ? '' : json['name'],
      logoPath: json['logo_path'] == null ? '' : json['logo_path'],
    );
  }
}
