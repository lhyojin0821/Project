class MovieModel {
  final String id;
  final String slug;
  final String title;
  final String overview;
  final String tagline;
  final String classification;
  final int runtime;
  final String releaseData;
  final double imdbRate;

  MovieModel({
    required this.id,
    required this.slug,
    required this.title,
    required this.overview,
    required this.tagline,
    required this.classification,
    required this.runtime,
    required this.releaseData,
    required this.imdbRate,
  });

  factory MovieModel.fromJson({required Map<String, dynamic> json}) {
    return MovieModel(
      id: json['id'] == null ? '' : json['id'],
      slug: json['slug'] == null ? '' : json['slug'],
      title: json['title'] == null ? '' : json['title'],
      overview: json['overview'] == null ? '' : json['overview'],
      tagline: json['tagline'] == null ? '' : json['tagline'],
      classification:
          json['classification'] == null ? '' : json['classification'],
      runtime: json['runtime'] == null ? 0 : json['runtime'],
      releaseData: json['release_on'] == null ? '' : json['release_on'],
      imdbRate:
          json['imdb_rating'] == null ? 0.0 : double.parse(json['runtime']),
    );
  }
}
