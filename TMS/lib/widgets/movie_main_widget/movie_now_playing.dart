import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/movie_models/movie_model.dart';
import 'package:tms/providers/movie_provider/movie_detail_provider.dart';
import 'package:tms/providers/movie_provider/movie_provider.dart';
import 'package:tms/providers/movie_provider/movie_video_provider.dart';
import 'package:tms/screens/movie_screens/movie_detail_screen.dart';

class MovieNowPlaying extends StatefulWidget {
  @override
  _MovieNowPlayingState createState() => _MovieNowPlayingState();
}

class _MovieNowPlayingState extends State<MovieNowPlaying> {
  late MovieProvider _movieController;
  @override
  void initState() {
    super.initState();
    this._movieController = Provider.of<MovieProvider>(
      context,
      listen: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: this._movieController.nowPlaying(),
        builder:
            (BuildContext context, AsyncSnapshot<List<MovieModel>> snapshot) {
          if (snapshot.hasData) {
            return Consumer<MovieProvider>(
              builder: (context, value, child) {
                return CarouselSlider.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int i, int? b) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return MultiProvider(
                                providers: [
                                  ChangeNotifierProvider(
                                      create: (BuildContext context) =>
                                          MovieDetailProvider()),
                                  ChangeNotifierProvider(
                                      create: (BuildContext context) =>
                                          MovieVideoProvider()),
                                ],
                                child: MovieDetailScreen(
                                    movieData: snapshot.data![i]),
                              );
                            },
                          ),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          snapshot.data!.isEmpty
                              ? Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: Center(
                                    child: Text(
                                      'Image preparation',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                )
                              : ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/original/${snapshot.data![i].backdropPath}',
                                    height: MediaQuery.of(context).size.height,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                          snapshot.data![i].title.isEmpty
                              ? Container(
                                  padding: EdgeInsets.only(
                                    bottom: 15.0,
                                    left: 15.0,
                                  ),
                                  child: Text(
                                    'preparation',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.only(
                                    bottom: 15.0,
                                    left: 15.0,
                                  ),
                                  child: Text(
                                    snapshot.data![i].title,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(microseconds: 500),
                    pauseAutoPlayOnTouch: true,
                    viewportFraction: 0.8,
                    enlargeCenterPage: true,
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Container(),
            );
          }
        },
      ),
    );
  }
}
