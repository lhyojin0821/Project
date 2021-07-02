import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/movie_models/movie_model.dart';
import 'package:tms/providers/movie_provider/movie_detail_provider.dart';
import 'package:tms/widgets/movie_main_widget/movie_genre_list.dart';

class MovieSimilar extends StatefulWidget {
  final MovieModel movieData;
  MovieSimilar({required this.movieData});
  @override
  _MovieSimilarState createState() => _MovieSimilarState(this.movieData);
}

class _MovieSimilarState extends State<MovieSimilar> {
  final MovieModel movieData;
  _MovieSimilarState(this.movieData);

  late MovieDetailProvider _movieController;
  MovieGenreList _movieWidget = MovieGenreList();

  @override
  void initState() {
    this._movieController = Provider.of<MovieDetailProvider>(
      context,
      listen: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: this._movieController.similar(movieId: movieData.id),
        builder: (BuildContext context, AsyncSnapshot<List<MovieModel>> snapshot) {
          if (snapshot.hasData) {
            print(movieData.id);
            print(snapshot.data!.length);
            return Consumer<MovieDetailProvider>(
              builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 10.0,
                        top: 20.0,
                      ),
                      child: Text(
                        'SIMILAR MOVIES',
                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ),
                    snapshot.data!.isEmpty
                        ? Center(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Similar Movies in preparation...',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(snapshot.data!.length, (index) => _movieWidget.movieWidget(snapshot.data![index], context)),
                            ),
                          ),
                  ],
                );
              },
            );
          } else {
            return Center(
              child: Text(''),
            );
          }
        },
      ),
    );
  }
}
