import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/tv_models/tv_model.dart';
import 'package:tms/providers/tv_provider/tv_detail_provider.dart';
import 'package:tms/providers/tv_provider/tv_video_provider.dart';
import 'package:tms/screens/tv_screens/tv_detail_screen.dart';

class TvTile extends StatefulWidget {
  final TvModel tv;
  TvTile(this.tv);
  @override
  _TvTileState createState() => _TvTileState(this.tv);
}

class _TvTileState extends State<TvTile> {
  TvModel tv;
  _TvTileState(this.tv);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return MultiProvider(providers: [
                ChangeNotifierProvider(
                    create: (BuildContext context) => TvDetailProvider()),
                ChangeNotifierProvider(
                    create: (BuildContext context) => TvVideoProvider()),
              ], child: TvDetailScreen(tvData: tv));
            },
          ),
        );
      },
      child: tv.posterPath.isEmpty
          ? Container(
              padding: EdgeInsets.only(left: 10.0, top: 10.0),
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Center(
                        child: Text(
                      'Image preparation',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ],
              ),
            )
          : Container(
              padding: EdgeInsets.only(left: 10.0, top: 10.0),
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          'https://image.tmdb.org/t/p/original/${tv.posterPath}',
                    ),
                  ),
                  tv.name.isEmpty
                      ? Container(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            'preparation',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            tv.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                  Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.star,
                          size: 14.0,
                          color: Colors.yellow,
                        ),
                      ),
                      tv.voteAverage.toString().isEmpty
                          ? Center(
                              child: Container(
                                padding: EdgeInsets.only(left: 5.0),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text(
                                tv.voteAverage.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
