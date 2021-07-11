import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieVideoPlayer extends StatefulWidget {
  final YoutubePlayerController controller;
  MovieVideoPlayer({required this.controller});

  @override
  _MovieVideoPlayerState createState() => _MovieVideoPlayerState(controller);
}

class _MovieVideoPlayerState extends State<MovieVideoPlayer> {
  final YoutubePlayerController controller;
  _MovieVideoPlayerState(this.controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: YoutubePlayer(
              controller: this.controller,
              showVideoProgressIndicator: true,
            ),
          ),
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
  }
}
