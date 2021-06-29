import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/movie_detail_model.dart';
import 'package:tms/models/movie_model.dart';
import 'package:tms/models/movie_video_model.dart';
import 'package:tms/providers/movie_detail_provider.dart';
import 'package:tms/providers/movie_video_provider.dart';
import 'package:tms/widgets/movie_video_player.dart';
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
      body: Column(
        children: [
          _videoImage(),
        ],
      ),
    );
  }

  Widget _videoImage() {
    return FutureBuilder(
      future: this._movieController.movieDetail(movieId: movieData.id),
      builder: (BuildContext context, AsyncSnapshot<List<MovieDetailModel>> snapshot) {
        if (snapshot.hasData) {
          return Consumer<MovieDetailProvider>(
            builder: (context, value, child) {
              return Stack(
                children: [
                  ClipPath(
                    child: ClipRRect(
                      child: CachedNetworkImage(
                        imageUrl: 'https://image.tmdb.org/t/p/original/${this.movieData.backdropPath}',
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
                      _videoPlay(),
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
    );
  }

  Widget _videoPlay() {
    return FutureBuilder(
      future: this._videoController.movieVideoDetail(movieId: movieData.id),
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
                          this.movieData.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                          overflow: TextOverflow.ellipsis,
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
