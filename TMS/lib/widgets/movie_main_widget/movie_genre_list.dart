import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/movie_models/movie_model.dart';
import 'package:tms/providers/movie_provider/movie_genre_provider.dart';
import 'package:tms/screens/movie_screens/movie_detail_screen.dart';

class MovieGenreList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: MovieGenreList(),
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
              return MovieDetailScreen(movieData: movie);
            },
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 10.0, top: 10.0),
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: 'https://image.tmdb.org/t/p/original/${movie.posterPath}',
              ),
            ),
            Container(
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
                movie.voteAverage == 0
                    ? Center(
                        child: Container(),
                      )
                    : Container(
                        child: Icon(
                          Icons.star,
                          size: 14.0,
                          color: Colors.yellow,
                        ),
                      ),
                movie.voteAverage == 0
                    ? Center(
                        child: Container(),
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
