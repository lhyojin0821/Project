import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/tv_models/tv_detail_model.dart';
import 'package:tms/models/tv_models/tv_model.dart';
import 'package:tms/models/tv_models/tv_video_model.dart';
import 'package:tms/providers/tv_provider/tv_detail_provider.dart';
import 'package:tms/providers/tv_provider/tv_video_provider.dart';
import 'package:tms/widgets/tv_detail_widget/tv_casts.dart';
import 'package:tms/widgets/tv_detail_widget/tv_info.dart';
import 'package:tms/widgets/tv_detail_widget/tv_similar.dart';
import 'package:tms/widgets/tv_main_widget/tv_video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TvDetailScreen extends StatefulWidget {
  final TvModel tvData;
  TvDetailScreen({required this.tvData});

  @override
  _TvDetailScreenState createState() => _TvDetailScreenState(this.tvData);
}

class _TvDetailScreenState extends State<TvDetailScreen> {
  late TvModel tvData;
  _TvDetailScreenState(this.tvData);

  late TvDetailProvider _tvController;
  late TvVideoProvider _videoController;

  @override
  void initState() {
    this._tvController = Provider.of<TvDetailProvider>(
      context,
      listen: false,
    );
    this._videoController = Provider.of<TvVideoProvider>(
      context,
      listen: false,
    );
    super.initState();
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
                this._tvController.tvDetail(tvId: tvData.id),
                this.tvData,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _videoImage(Future<TvDetailModel> tvDetail, TvModel tvData) {
    return Container(
      child: Column(
        children: [
          FutureBuilder(
            future: tvDetail,
            builder: (BuildContext context, AsyncSnapshot<TvDetailModel> snapshot) {
              if (snapshot.hasData) {
                return Consumer<TvDetailProvider>(
                  builder: (context, value, child) {
                    return Stack(
                      children: [
                        ClipPath(
                          child: ClipRRect(
                            child: tvData.backdropPath.isEmpty
                                ? Container(
                                    height: MediaQuery.of(context).size.height / 2,
                                    width: MediaQuery.of(context).size.width,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: 'https://image.tmdb.org/t/p/original/${tvData.backdropPath}',
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
                              this._videoController.tvVideoDetail(tvId: tvData.id),
                              this.tvData,
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
          TvInfo(tvData: this.tvData),
          TvSimilar(tvData: this.tvData),
          TvCast(tvData: this.tvData),
        ],
      ),
    );
  }

  Widget _videoPlay(
    Future<List<TvVideoModel>> videoPlay,
    TvModel tvData,
  ) {
    return FutureBuilder(
      future: videoPlay,
      builder: (BuildContext context, AsyncSnapshot<List<TvVideoModel>> snapshot) {
        if (snapshot.hasData) {
          return Consumer<TvVideoProvider>(
            builder: (context, value, child) {
              return Container(
                padding: EdgeInsets.only(top: 150.0),
                child: GestureDetector(
                  onTap: () async {
                    snapshot.data!.isEmpty
                        ? Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return Scaffold(
                              backgroundColor: Colors.black,
                              body: Stack(
                                children: [
                                  Center(
                                      child: Text(
                                    'video preparation..',
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
                        : Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return TvVideoPlayer(
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
                          tvData.name,
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
