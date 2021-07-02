import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/movie_models/movie_cast_model.dart';
import 'package:tms/models/movie_models/movie_model.dart';
import 'package:tms/providers/movie_provider/movie_detail_provider.dart';

class MovieCast extends StatefulWidget {
  final MovieModel movieData;
  MovieCast({required this.movieData});

  @override
  _MovieCastState createState() => _MovieCastState(this.movieData);
}

class _MovieCastState extends State<MovieCast> {
  late MovieModel movieData;

  _MovieCastState(this.movieData);

  late MovieDetailProvider _movieController;

  @override
  void initState() {
    super.initState();
    this._movieController = Provider.of<MovieDetailProvider>(
      context,
      listen: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: this._movieController.movieCast(movieId: movieData.id),
        builder: (BuildContext context, AsyncSnapshot<List<MovieCastModel>> snapshot) {
          if (snapshot.hasData) {
            print(movieData.id);
            print(snapshot.data!.length);
            return Consumer<MovieDetailProvider>(
              builder: (context, value, child) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 20.0, left: 10.0),
                        child: Text(
                          "CASTS",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      snapshot.data!.isEmpty
                          ? Center(
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Casts in preparation...',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(
                                top: 10.0,
                                left: 5.0,
                              ),
                              height: 150.0,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                separatorBuilder: (BuildContext context, int i) {
                                  return VerticalDivider(
                                    color: Colors.transparent,
                                    width: 5.0,
                                  );
                                },
                                itemBuilder: (BuildContext context, int i) {
                                  return Container(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            elevation: 3.0,
                                            child: ClipRRect(
                                              child: CachedNetworkImage(
                                                imageUrl: 'https://image.tmdb.org/t/p/w200${snapshot.data![i].profilePath}',
                                                imageBuilder: (BuildContext context, imgProvider) {
                                                  return Container(
                                                    width: 80.0,
                                                    height: 80.0,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      image: DecorationImage(fit: BoxFit.cover, image: imgProvider),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 70.0,
                                          child: Center(
                                            child: Text(
                                              snapshot.data![i].name.toUpperCase(),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 9.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5.0),
                                          width: 70.0,
                                          child: Center(
                                            child: Text(
                                              snapshot.data![i].character,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                height: 1.4,
                                                color: Colors.grey,
                                                fontSize: 8.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
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
    );
  }
}
