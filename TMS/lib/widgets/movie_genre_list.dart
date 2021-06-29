import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/movie_model.dart';
import 'package:tms/providers/movie_genre_provider.dart';
import 'package:tms/widgets/movie_detail_video.dart';
import 'package:tms/widgets/movie_genre.dart';

class MovieGenreList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Consumer<MovieGenreProvider>(
              builder: (context, controller, child) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(controller.movies.length, (index) => movieWidget(controller.movies[index], context)),
                  ),
                );
              },
              child: MovieGenre(),
            ),
          )
        ],
      ),
    );
  }

  Widget movieWidget(MovieModel movie, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return MovieDetailVideo(movieData: movie);
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5.0),
        padding: EdgeInsets.only(right: 10.0),
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network("https://image.tmdb.org/t/p/w200/" + movie.posterPath),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                movie.title,
                style: TextStyle(
                  fontSize: 12.0,
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
                Container(
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
