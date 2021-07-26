import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wtw/models/tv_model/tv_model.dart';
import 'package:wtw/providers/tv_provider/tv_detail_provider.dart';
import 'package:wtw/providers/tv_provider/tv_popular_provider.dart';
import 'package:wtw/providers/tv_provider/tv_video_provider.dart';
import 'package:wtw/screens/tv_screen/tv_popular_no_user_screen.dart';
import 'package:wtw/screens/tv_screen/tv_popular_screen.dart';

class TvTileWidget extends StatefulWidget {
  @override
  _TvTileWidgetState createState() => _TvTileWidgetState();
}

class _TvTileWidgetState extends State<TvTileWidget> {
  late TvPopularProvider _tvPopularProvider;
  Color subColor = Color(0xff141414);
  Color mainColor = Color(0xffe50815);

  @override
  void initState() {
    this._tvPopularProvider = Provider.of<TvPopularProvider>(
      context,
      listen: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: FutureBuilder(
          future: this._tvPopularProvider.popular(),
          builder:
              (BuildContext context, AsyncSnapshot<List<TvModel>> snapshot) {
            if (snapshot.hasData) {
              return Consumer<TvPopularProvider>(
                  builder: (context, value, child) {
                return CarouselSlider.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int i, int? b) {
                    return GestureDetector(
                      onTap: () {
                        if (FirebaseAuth.instance.currentUser != null) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return MultiProvider(
                              providers: [
                                ChangeNotifierProvider(
                                    create: (BuildContext context) =>
                                        TvPopularProvider()),
                                ChangeNotifierProvider(
                                    create: (BuildContext context) =>
                                        TvDetailProvider()),
                                ChangeNotifierProvider(
                                    create: (BuildContext context) =>
                                        TvVideoProvider()),
                              ],
                              child:
                                  TvPopularScreen(tvId: snapshot.data![i].id),
                            );
                          }));
                        } else if (FirebaseAuth.instance.currentUser == null) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return MultiProvider(
                              providers: [
                                ChangeNotifierProvider(
                                    create: (BuildContext context) =>
                                        TvPopularProvider()),
                                ChangeNotifierProvider(
                                    create: (BuildContext context) =>
                                        TvDetailProvider()),
                                ChangeNotifierProvider(
                                    create: (BuildContext context) =>
                                        TvVideoProvider()),
                              ],
                              child: TvPopularNoUserScreen(
                                  tvId: snapshot.data![i].id),
                            );
                          }));
                        }
                      },
                      child: Stack(
                        children: [
                          snapshot.data![i].posterPath.isEmpty
                              ? Container(
                                  child: Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.solidImage,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "https://image.tmdb.org/t/p/original/${snapshot.data![i].posterPath}"),
                                  ),
                                ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.9),
                                      Colors.black.withOpacity(0.0)
                                    ],
                                    stops: [
                                      0.0,
                                      0.5
                                    ])),
                          ),
                          Positioned(
                              top: 10.0,
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
                                      size: 14.0,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    snapshot.data![i].voteAverage
                                            .toString()
                                            .isEmpty
                                        ? Text(
                                            '',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Text(
                                            snapshot.data![i].voteAverage
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                  ],
                                ),
                              )),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: snapshot.data![i].name.isEmpty
                                ? FaIcon(
                                    FontAwesomeIcons.solidMehBlank,
                                    color: Colors.white,
                                  )
                                : Text(
                                    snapshot.data![i].name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 1.5,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(microseconds: 500),
                    pauseAutoPlayOnTouch: true,
                    viewportFraction: 0.8,
                    enlargeCenterPage: true,
                  ),
                );
              });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
