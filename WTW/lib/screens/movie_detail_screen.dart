import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtw/models/movie_detail_model.dart';
import 'package:wtw/providers/movie_provider.dart';
import 'package:wtw/repository/repo.dart';
import 'package:wtw/screens/main_screen.dart';

class MovieDetailScreen extends StatefulWidget {
  final int selectedScore;
  final int selectedGenre;
  final int movieId;

  MovieDetailScreen({
    required this.selectedGenre,
    required this.selectedScore,
    required this.movieId,
  });

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState(
        this.selectedGenre,
        this.selectedScore,
        this.movieId,
      );
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  int selectedScore;
  int selectedGenre;
  int movieId;
  late int movieIndex;
  late List<int> movieIds;
  late MovieRepo _movieRepo = new MovieRepo();

  _MovieDetailScreenState(
    this.selectedGenre,
    this.selectedScore,
    this.movieId,
  );

  late MovieProvider _movieProvider;

  @override
  void initState() {
    this._movieProvider = Provider.of<MovieProvider>(
      context,
      listen: false,
    );
    this.movieIds = this._movieRepo.movieList;
    this.movieIndex = this.movieIds.indexWhere((id) => id == movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: this._movieProvider.movies(this.movieId),
        builder:
            (BuildContext context, AsyncSnapshot<MovieDetailModel> snapshot) {
          if (snapshot.hasData) {
            return Consumer<MovieProvider>(builder: (context, value, child) {
              return SafeArea(
                child: this.movieIndex != -1
                    ? Stack(
                        children: [
                          snapshot.data!.posterPath.isEmpty
                              ? Container()
                              : Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    color: Colors.grey[400],
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          "https://image.tmdb.org/t/p/original/${snapshot.data!.posterPath}",
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.9),
                                      Colors.black.withOpacity(0.0)
                                    ],
                                    stops: [
                                      0.0,
                                      0.5
                                    ])),
                          ),
                          Positioned(
                            top: 50.0,
                            left: 20.0,
                            child: Container(
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return MainScreen();
                                    }));
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_left_outlined,
                                    color: Colors.white,
                                    size: 30.0,
                                  )),
                            ),
                          ),
                          Positioned(
                              top: 20.0,
                              right: 10.0,
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    color: Colors.black45),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.credit_score_outlined,
                                      color: Colors.yellow,
                                      size: 25.0,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      snapshot.data!.voteAverage.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )),
                          Positioned(
                              bottom: 50.0,
                              left: 10.0,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.title,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      snapshot.data!.overView,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.lock_clock_outlined,
                                              color: Colors.white,
                                              size: 15.0,
                                            ),
                                            SizedBox(
                                              width: 3.0,
                                            ),
                                            Text(
                                              snapshot.data!.runtime.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today_outlined,
                                              color: Colors.white,
                                              size: 15.0,
                                            ),
                                            SizedBox(
                                              width: 3.0,
                                            ),
                                            Text(
                                              '${snapshot.data!.releaseDate} min',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )),
                        ],
                      )
                    : Center(child: CircularProgressIndicator()),
              );
            });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
