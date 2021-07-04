import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/movie_models/movie_model.dart';
import 'package:tms/providers/movie_provider/movie_detail_provider.dart';
import 'package:tms/providers/movie_provider/movie_video_provider.dart';
import 'package:tms/screens/movie_screens/movie_detail_screen.dart';

class MovieTile extends StatefulWidget {
  final MovieModel movie;
  MovieTile(this.movie);

  @override
  _MovieTileState createState() => _MovieTileState(this.movie);
}

class _MovieTileState extends State<MovieTile> {
  MovieModel movie;
  _MovieTileState(this.movie);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return MultiProvider(providers: [
                ChangeNotifierProvider(
                    create: (BuildContext context) => MovieDetailProvider()),
                ChangeNotifierProvider(
                    create: (BuildContext context) => MovieVideoProvider()),
              ], child: MovieDetailScreen(movieData: movie));
            },
          ),
        );
      },
      child: movie.posterPath.isEmpty
          ? Container(
              padding: EdgeInsets.only(left: 10.0, top: 10.0),
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Center(
                        child: Text(
                      'Image preparation',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ],
              ),
            )
          : Container(
              padding: EdgeInsets.only(left: 10.0, top: 10.0),
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                    ),
                  ),
                  movie.title.isEmpty
                      ? Container(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            'preparation',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            movie.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                  Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.star,
                          size: 14.0,
                          color: Colors.yellow,
                        ),
                      ),
                      movie.voteAverage.toString().isEmpty
                          ? Center(
                              child: Container(
                                padding: EdgeInsets.only(left: 5.0),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text(
                                movie.voteAverage.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
