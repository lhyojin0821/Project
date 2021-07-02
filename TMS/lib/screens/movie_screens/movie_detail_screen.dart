import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/movie_models/movie_detail_model.dart';
import 'package:tms/models/movie_models/movie_model.dart';
import 'package:tms/models/movie_models/movie_video_model.dart';
import 'package:tms/providers/movie_provider/movie_detail_provider.dart';
import 'package:tms/providers/movie_provider/movie_video_provider.dart';
import 'package:tms/widgets/movie_detail_widget/movie_casts.dart';
import 'package:tms/widgets/movie_detail_widget/movie_info.dart';
import 'package:tms/widgets/movie_detail_widget/movie_similar.dart';
import 'package:tms/widgets/movie_detail_widget/movie_video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieModel movieData;
  MovieDetailScreen({required this.movieData});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState(this.movieData);
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late MovieModel movieData;
  _MovieDetailScreenState(this.movieData);

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
      backgroundColor: Colors.grey[900],
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

  Widget _videoImage(Future<MovieDetailModel> movieDetail, MovieModel movieData) {
    return Container(
      child: Column(
        children: [
          FutureBuilder(
            future: movieDetail,
            builder: (BuildContext context, AsyncSnapshot<MovieDetailModel> snapshot) {
              if (snapshot.hasData) {
                return Consumer<MovieDetailProvider>(
                  builder: (context, value, child) {
                    return Stack(
                      children: [
                        ClipPath(
                          child: ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/original/${movieData.backdropPath}',
                              height: MediaQuery.of(context).size.height / 2,
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
                              this._videoController.movieVideoDetail(movieId: movieData.id),
                              this.movieData,
                            ),
                          ],
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
          MovieInfo(movieData: this.movieData),
          MovieSimilar(movieData: this.movieData),
          MovieCast(movieData: this.movieData),
        ],
      ),
    );
  }

  Widget _videoPlay(
    Future<List<MovieVideoModel>> videoPlay,
    MovieModel movieData,
  ) {
    return FutureBuilder(
      future: videoPlay,
      builder: (BuildContext context, AsyncSnapshot<List<MovieVideoModel>> snapshot) {
        if (snapshot.hasData) {
          return Consumer<MovieVideoProvider>(
            builder: (context, value, child) {
              return Container(
                padding: EdgeInsets.only(top: 150.0),
                child: GestureDetector(
                  onTap: () async {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
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
                          color: Colors.yellow,
                        ),
                        Text(
                          movieData.title,
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
          return Center(
            child: Text(''),
          );
        }
      },
    );
  }
}
