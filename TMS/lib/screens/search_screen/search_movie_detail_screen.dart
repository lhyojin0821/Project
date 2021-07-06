import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/movie_models/movie_detail_model.dart';
import 'package:tms/models/movie_models/movie_video_model.dart';
import 'package:tms/models/search_model.dart';
import 'package:tms/providers/movie_provider/movie_detail_provider.dart';
import 'package:tms/providers/movie_provider/movie_video_provider.dart';
import 'package:tms/widgets/movie_detail_widget/movie_video_player.dart';
import 'package:tms/widgets/search_widget/search_movie_cast.dart';
import 'package:tms/widgets/search_widget/search_movie_info.dart';
import 'package:tms/widgets/search_widget/search_movie_similar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SearchMovieDetailScreen extends StatefulWidget {
  final SearchModel movieData;
  SearchMovieDetailScreen({required this.movieData});

  @override
  _SearchMovieDetailScreenState createState() =>
      _SearchMovieDetailScreenState(this.movieData);
}

class _SearchMovieDetailScreenState extends State<SearchMovieDetailScreen> {
  late SearchModel movieData;
  _SearchMovieDetailScreenState(this.movieData);

  late MovieDetailProvider _movieController;
  late MovieVideoProvider _videoController;

  @override
  void initState() {
    super.initState();
    this._movieController = Provider.of<MovieDetailProvider>(
      context,
      listen: false,
    );
    this._videoController = Provider.of<MovieVideoProvider>(
      context,
      listen: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _videoImage(
                this._movieController.movieDetail(movieId: movieData.id),
                this.movieData,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _videoImage(
      Future<MovieDetailModel> movieDetail, SearchModel movieData) {
    return Container(
      child: Column(
        children: [
          FutureBuilder(
            future: movieDetail,
            builder: (BuildContext context,
                AsyncSnapshot<MovieDetailModel> snapshot) {
              if (snapshot.hasData) {
                return Consumer<MovieDetailProvider>(
                  builder: (context, value, child) {
                    return Stack(
                      children: [
                        ClipPath(
                          child: movieData.backdropPath.isEmpty
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  width: MediaQuery.of(context).size.width,
                                )
                              : ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/original/${movieData.backdropPath}',
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(60.0),
                                    bottomRight: Radius.circular(60.0),
                                  ),
                                ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0.0,
                            ),
                            _videoPlay(
                              this
                                  ._videoController
                                  .movieVideoDetail(movieId: movieData.id),
                              this.movieData,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ),
          SearchMovieInfo(movieData: this.movieData),
          SearchMovieSimilar(movieData: this.movieData),
          SearchMovieCast(movieData: this.movieData),
        ],
      ),
    );
  }

  Widget _videoPlay(
    Future<List<MovieVideoModel>> videoPlay,
    SearchModel movieData,
  ) {
    return FutureBuilder(
      future: videoPlay,
      builder: (BuildContext context,
          AsyncSnapshot<List<MovieVideoModel>> snapshot) {
        if (snapshot.hasData) {
          return Consumer<MovieVideoProvider>(
            builder: (context, value, child) {
              return Container(
                padding: EdgeInsets.only(top: 150.0),
                child: GestureDetector(
                  onTap: () async {
                    snapshot.data!.isEmpty
                        ? Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                            return Scaffold(
                              backgroundColor: Colors.black,
                              body: Stack(
                                children: [
                                  Center(
                                      child: Text(
                                    'Video Preparation',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                  Positioned(
                                    top: 40.0,
                                    right: 2.0,
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(context);
                                      },
                                      icon: Icon(
                                        Icons.close_sharp,
                                        color: Colors.white,
                                        size: 30.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }))
                        : Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                            return MovieVideoPlayer(
                              controller: YoutubePlayerController(
                                  initialVideoId: snapshot.data![0].key,
                                  flags: YoutubePlayerFlags(
                                    autoPlay: true,
                                  )),
                            );
                          }));
                  },
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.play_circle_outline,
                          size: 60.0,
                          color: Colors.white,
                        ),
                        Text(
                          movieData.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
