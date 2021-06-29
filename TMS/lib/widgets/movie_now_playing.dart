import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/movie_model.dart';
import 'package:tms/providers/movie_provider.dart';
import 'package:tms/widgets/movie_detail_video.dart';

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
    return Column(
      children: [
        FutureBuilder(
          future: this._movieController.nowPlaying(),
          builder: (BuildContext context, AsyncSnapshot<List<MovieModel>> snapshot) {
            if (snapshot.hasData) {
              return Consumer<MovieProvider>(
                builder: (context, value, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int i, int? b) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return MovieDetailVideo(movieData: snapshot.data![i]);
                                  },
                                ),
                              );
                            },
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl: 'https://image.tmdb.org/t/p/original/${snapshot.data![i].backdropPath}',
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 3,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 15,
                                    left: 15,
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
    );
  }
}
