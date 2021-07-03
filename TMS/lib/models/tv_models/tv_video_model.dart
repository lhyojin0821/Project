import 'package:flutter/foundation.dart';

class TvVideoModel {
  final String id;
  final String key;
  final String name;
  final String site;
  final String type;

  TvVideoModel({required this.id, required this.key, required this.name, required this.site, required this.type});

  factory TvVideoModel.fromJson({required Map<String, dynamic> json}) {
    return TvVideoModel(
      id: json['id'],
      key: json['key'],
      name: json['name'],
      site: json['site'],
      type: json['type'],
    );
  }
}
