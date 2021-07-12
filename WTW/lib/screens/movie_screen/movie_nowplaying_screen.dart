import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wtw/models/movie_model/movie_detail_model.dart';
import 'package:wtw/providers/movie_provider/movie_detail_provider.dart';
import 'package:wtw/providers/movie_provider/movie_nowplaying_provider.dart';
import 'package:wtw/screens/main_screen.dart';
import 'package:wtw/widgets/movie_widget/movie_video_widget.dart';

class MovieNowPlayingScreen extends StatefulWidget {
  final int movieId;

  MovieNowPlayingScreen({
    required this.movieId,
  });

  @override
  _MovieNowPlayingScreenState createState() => _MovieNowPlayingScreenState(
        this.movieId,
      );
}

class _MovieNowPlayingScreenState extends State<MovieNowPlayingScreen> {
  final int movieId;

  _MovieNowPlayingScreenState(
    this.movieId,
  );

  late MovieDetailProvider _movieDetailProvider;
  @override
  void initState() {
    this._movieDetailProvider = Provider.of<MovieDetailProvider>(
      context,
      listen: false,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: this._movieDetailProvider.movies(this.movieId),
        builder:
            (BuildContext context, AsyncSnapshot<MovieDetailModel> snapshot) {
          if (snapshot.hasData) {
            return Consumer<MovieNowPlayingProvider>(
                builder: (context, value, child) {
              return SafeArea(
                  child: Stack(
                children: [
                  snapshot.data!.posterPath.isEmpty
                      ? Center(
                          child: Container(
                              margin: EdgeInsets.only(bottom: 100.0),
                              child: FaIcon(
                                FontAwesomeIcons.solidImage,
                                color: Colors.white,
                                size: 50.0,
                              )))
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
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.9),
                              Colors.black.withOpacity(0.2)
                            ],
                            stops: [
                              0.0,
                              0.5
                            ])),
                  ),
                  Positioned(
                    top: 20.0,
                    left: 10.0,
                    child: Container(
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                              return MainScreen();
                            }));
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.arrowLeft,
                            color: Colors.white,
                            size: 25.0,
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
                            FaIcon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.yellow,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            snapshot.data!.voteAverage.toString().isEmpty
                                ? Text(
                                    '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
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
                          snapshot.data!.title.isEmpty
                              ? Text(
                                  '',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
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
                          snapshot.data!.overView.isEmpty
                              ? FaIcon(
                                  FontAwesomeIcons.solidMehBlank,
                                  color: Colors.white,
                                )
                              : Text(
                                  snapshot.data!.overView,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 10,
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
                                    Icons.timer,
                                    color: Colors.white,
                                    size: 15.0,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  snapshot.data!.runtime.toString().isEmpty
                                      ? Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          '${snapshot.data!.runtime.toString()} min',
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
                                  FaIcon(
                                    FontAwesomeIcons.calendar,
                                    color: Colors.white,
                                    size: 15.0,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  snapshot.data!.releaseDate.isEmpty
                                      ? Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          '${snapshot.data!.releaseDate} ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.favorite_border,
                                    ),
                                    color: Colors.white,
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  MovieVideoWidget(movieData: snapshot.data!),
                ],
              ));
            });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
