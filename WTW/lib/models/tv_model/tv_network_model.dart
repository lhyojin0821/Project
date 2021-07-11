class TvNetWorkModel {
  final int id;
  final String name;
  final String logoPath;

  TvNetWorkModel(
      {required this.id, required this.name, required this.logoPath});

  factory TvNetWorkModel.fromJson({required Map<String, dynamic> json}) {
    return TvNetWorkModel(
      id: json['id'],
      name: json['name'] == null ? '' : json['name'],
      logoPath: json['logo_path'] == null ? '' : json['logo_path'],
    );
  }
}
