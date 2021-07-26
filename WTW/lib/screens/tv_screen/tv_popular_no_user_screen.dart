import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wtw/models/tv_model/tv_detail_model.dart';
import 'package:wtw/providers/tv_provider/tv_detail_provider.dart';
import 'package:wtw/providers/tv_provider/tv_popular_provider.dart';
import 'package:wtw/screens/main_screen.dart';
import 'package:wtw/widgets/tv_widget/tv_video_widget.dart';

class TvPopularNoUserScreen extends StatefulWidget {
  final int tvId;

  TvPopularNoUserScreen({
    required this.tvId,
  });

  @override
  _TvPopularNoUserScreenState createState() => _TvPopularNoUserScreenState(
        this.tvId,
      );
}

class _TvPopularNoUserScreenState extends State<TvPopularNoUserScreen> {
  final int tvId;
  _TvPopularNoUserScreenState(
    this.tvId,
  );

  late TvDetailProvider _tvDetailProvider;
  @override
  void initState() {
    this._tvDetailProvider = Provider.of<TvDetailProvider>(
      context,
      listen: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: this._tvDetailProvider.tvs(this.tvId),
        builder: (BuildContext context, AsyncSnapshot<TvDetailModel> snapshot) {
          if (snapshot.hasData) {
            return Consumer<TvPopularProvider>(
                builder: (context, value, child) {
              return SafeArea(
                  child: Stack(
                children: [
                  snapshot.data!.posterPath.isEmpty
                      ? Center(
                          child: Container(
                              margin: EdgeInsets.only(bottom: 100.0),
                              child: FaIcon(
                                FontAwesomeIcons.solidImage,
                                color: Colors.white,
                                size: 50.0,
                              )))
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            color: Colors.grey[400],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    "https://image.tmdb.org/t/p/original/${snapshot.data!.posterPath}"),
                          ),
                        ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.9),
                              Colors.black.withOpacity(0.2)
                            ],
                            stops: [
                              0.0,
                              0.5
                            ])),
                  ),
                  Positioned(
                    top: 20.0,
                    left: 10.0,
                    child: Container(
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                              return MainScreen();
                            }));
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.arrowLeft,
                            color: Colors.white,
                            size: 25.0,
                          )),
                    ),
                  ),
                  Positioned(
                      top: 20.0,
                      right: 10.0,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            color: Colors.black45),
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.yellow,
                              size: 15.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            snapshot.data!.voteAverage.toString().isEmpty
                                ? Text(
                                    '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    snapshot.data!.voteAverage.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ],
                        ),
                      )),
                  Positioned(
                    bottom: 50.0,
                    left: 10.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          snapshot.data!.name.isEmpty
                              ? Text(
                                  '',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                )
                              : Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        snapshot.data!.name.length > 20
                                            ? '${snapshot.data!.name.substring(0, 20)}...'
                                            : '${snapshot.data!.name}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.favorite_border_outlined,
                                          size: 24.0,
                                        ),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 10.0,
                          ),
                          snapshot.data!.overView.isEmpty
                              ? FaIcon(
                                  FontAwesomeIcons.solidMehBlank,
                                  color: Colors.white,
                                )
                              : Text(
                                  snapshot.data!.overView,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 15,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0,
                                  ),
                                ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    color: Colors.white,
                                    size: 14.0,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  snapshot.data!.lastAirDate.isEmpty
                                      ? Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          '${snapshot.data!.lastAirDate} ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ],
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.tv,
                                    color: Colors.white,
                                    size: 12.0,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  snapshot.data!.networks.isEmpty
                                      ? Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          snapshot.data!.networks[0].name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  TvVideoWidget(tvData: snapshot.data!),
                ],
              ));
            });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
