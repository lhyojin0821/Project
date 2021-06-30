import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  final formatCurrency = new NumberFormat.simpleCurrency(decimalDigits: 0);

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
                    return Container(
                      child: Column(
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
                          Container(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "DURATION",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        snapshot.data!.runtime.toString() + ' min',
                                        style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold, fontSize: 12.0),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "RELEASE DATE",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        snapshot.data!.releaseDate.toString(),
                                        style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold, fontSize: 12.0),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "BUDGET",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        this.formatCurrency.format(
                                              snapshot.data!.budget,
                                            ),
                                        style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold, fontSize: 12.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0, top: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    'GENRES',
                                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                    height: 38.0,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.genres.length,
                                      separatorBuilder: (BuildContext context, int i) {
                                        return VerticalDivider(
                                          color: Colors.transparent,
                                          width: 12.0,
                                        );
                                      },
                                      itemBuilder: (BuildContext context, int i) {
                                        return Container(
                                          padding: EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5.0),
                                            border: Border.all(
                                              width: 1.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          child: Text(
                                            snapshot.data!.genres[i].name,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 10.0,
                                            ),
                                          ),
                                        );
                                      },
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
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
