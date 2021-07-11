import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtw/models/tv_model/tv_video_model.dart';
import 'package:wtw/providers/tv_provider/tv_video_provider.dart';
import 'package:wtw/widgets/tv_widget/tv_video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TvVideoWidget extends StatefulWidget {
  final int tvData;
  TvVideoWidget({required this.tvData});

  @override
  _TvVideoWidgetState createState() => _TvVideoWidgetState(this.tvData);
}

class _TvVideoWidgetState extends State<TvVideoWidget> {
  final int tvData;
  _TvVideoWidgetState(this.tvData);
  late TvVideoProvider _tvVideoProvider;

  @override
  void initState() {
    this._tvVideoProvider = Provider.of<TvVideoProvider>(
      context,
      listen: false,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this._tvVideoProvider.tvVideoDetail(tvId: this.tvData),
      builder:
          (BuildContext context, AsyncSnapshot<List<TvVideoModel>> snapshot) {
        if (snapshot.hasData) {
          return Consumer<TvVideoProvider>(
            builder: (context, value, child) {
              return Center(
                child: Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return TvVideoPlayer(
                          controller: YoutubePlayerController(
                              initialVideoId: snapshot.data![0].key,
                              flags: YoutubePlayerFlags(
                                autoPlay: true,
                              )),
                        );
                      }));
                    },
                    child: Container(
                      child: Icon(
                        Icons.play_circle_outline,
                        size: 60.0,
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
