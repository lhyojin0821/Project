import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/movie_models/movie_model.dart';
import 'package:tms/models/search_model.dart';
import 'package:tms/providers/movie_provider/movie_detail_provider.dart';
import 'package:tms/widgets/movie_main_widget/movie_tile.dart';

class SearchMovieSimilar extends StatefulWidget {
  final SearchModel movieData;
  SearchMovieSimilar({required this.movieData});
  @override
  _SearchMovieSimilarState createState() =>
      _SearchMovieSimilarState(this.movieData);
}

class _SearchMovieSimilarState extends State<SearchMovieSimilar> {
  final SearchModel movieData;
  _SearchMovieSimilarState(this.movieData);

  late MovieDetailProvider _movieController;

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
        builder:
            (BuildContext context, AsyncSnapshot<List<MovieModel>> snapshot) {
          if (snapshot.hasData) {
            return Consumer<MovieDetailProvider>(
              builder: (context, value, child) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 10.0,
                          top: 20.0,
                        ),
                        child: Text(
                          'SIMILAR MOVIES',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                      ),
                      snapshot.data!.isEmpty
                          ? Container(
                              padding: EdgeInsets.all(20.0),
                              child: Center(
                                  child: Text(
                                'Preparation',
                                style: TextStyle(color: Colors.white),
                              )),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  snapshot.data!.length,
                                  (index) => MovieTile(snapshot.data![index]),
                                  // _movieWidget.movieWidget(snapshot.data![index], context)
                                ),
                              ),
                            ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
