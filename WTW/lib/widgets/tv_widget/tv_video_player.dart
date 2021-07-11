import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TvVideoPlayer extends StatefulWidget {
  final YoutubePlayerController controller;
  TvVideoPlayer({required this.controller});

  @override
  _TvVideoPlayerState createState() => _TvVideoPlayerState(controller);
}

class _TvVideoPlayerState extends State<TvVideoPlayer> {
  final YoutubePlayerController controller;
  _TvVideoPlayerState(this.controller);

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
