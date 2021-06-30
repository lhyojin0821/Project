import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/movie_detail_model.dart';
import 'package:tms/models/movie_model.dart';
import 'package:tms/providers/movie_detail_provider.dart';

class MovieInfo extends StatefulWidget {
  final MovieModel movieData;
  MovieInfo({required this.movieData});

  @override
  _MovieInfoState createState() => _MovieInfoState(this.movieData);
}

class _MovieInfoState extends State<MovieInfo> {
  late MovieModel movieData;

  _MovieInfoState(this.movieData);

  late MovieDetailProvider _movieController;

  @override
  void initState() {
    super.initState();
    this._movieController = Provider.of<MovieDetailProvider>(
      context,
      listen: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FutureBuilder(
            future: this._movieController.movieDetail(movieId: movieData.id),
            builder: (BuildContext context, AsyncSnapshot<MovieDetailModel> snapshot) {
              if (snapshot.hasData) {
                return Consumer<MovieDetailProvider>(
                  builder: (context, value, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10.0, top: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 16.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text(
                                  this.movieData.voteAverage.toString(),
                                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20.0, left: 10.0),
                          child: Text(
                            'OverView'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            this.movieData.overView,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              height: 1.5,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10.0, top: 20.0),
                                  child: Text(
                                    "Budget".toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(snapshot.data!.budget.toString() + '\$'),
                                ),
                              ],
                            ),
                          ],
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
        ],
      ),
    );
  }
}
