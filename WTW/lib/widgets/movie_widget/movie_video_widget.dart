import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wtw/models/movie_model/movie_detail_model.dart';
import 'package:wtw/models/movie_model/movie_video_model.dart';
import 'package:wtw/providers/movie_provider/movie_video_provider.dart';
import 'package:wtw/widgets/movie_widget/movie_video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieVideoWidget extends StatefulWidget {
  final MovieDetailModel movieData;
  MovieVideoWidget({required this.movieData});

  @override
  _MovieVideoWidgetState createState() =>
      _MovieVideoWidgetState(this.movieData);
}

class _MovieVideoWidgetState extends State<MovieVideoWidget> {
  final MovieDetailModel movieData;
  _MovieVideoWidgetState(this.movieData);
  late MovieVideoProvider _movieVideoProvider;

  @override
  void initState() {
    this._movieVideoProvider = Provider.of<MovieVideoProvider>(
      context,
      listen: false,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          this._movieVideoProvider.movieVideoDetail(movieId: this.movieData.id),
      builder: (BuildContext context,
          AsyncSnapshot<List<MovieVideoModel>> snapshot) {
        if (snapshot.hasData) {
          return Consumer<MovieVideoProvider>(
            builder: (context, value, child) {
              return Center(
                child: Container(
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.of(context).push(
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
                    child: Container(
                      child: FaIcon(
                        FontAwesomeIcons.solidPlayCircle,
                        size: 50.0,
                        color: Colors.white,
                      ),
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
