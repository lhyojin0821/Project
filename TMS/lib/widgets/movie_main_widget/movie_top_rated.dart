import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/movie_models/movie_model.dart';
import 'package:tms/providers/movie_provider/movie_provider.dart';

import 'package:tms/widgets/movie_main_widget/movie_genre_list.dart';

class MovieTopRated extends StatefulWidget {
  @override
  _MovieTopRatedState createState() => _MovieTopRatedState();
}

class _MovieTopRatedState extends State<MovieTopRated> {
  late MovieProvider _movieController;
  MovieGenreList _movieWidget = MovieGenreList();

  @override
  void initState() {
    this._movieController = Provider.of<MovieProvider>(
      context,
      listen: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: this._movieController.topRated(),
        builder: (BuildContext context, AsyncSnapshot<List<MovieModel>> snapshot) {
          if (snapshot.hasData) {
            return Consumer<MovieProvider>(
              builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 10.0,
                        top: 20.0,
                        bottom: 10.0,
                      ),
                      child: Text(
                        'TOP RATED MOVIES',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
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
