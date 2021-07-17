import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wtw/models/tv_model/tv_detail_model.dart';
import 'package:wtw/models/tv_model/tv_model.dart';
import 'package:wtw/providers/tv_provider/tv_detail_provider.dart';
import 'package:wtw/providers/tv_provider/tv_recommendation_provider.dart';
import 'package:wtw/screens/main_screen.dart';
import 'package:wtw/widgets/tv_widget/tv_video_widget.dart';

class TvDetailScreen extends StatefulWidget {
  final int selectedGenre;
  final int pageId;

  TvDetailScreen({
    required this.selectedGenre,
    required this.pageId,
  });

  @override
  _TvDetailScreenState createState() => _TvDetailScreenState(
        this.selectedGenre,
        this.pageId,
      );
}

class _TvDetailScreenState extends State<TvDetailScreen> {
  int selectedGenre;
  int pageId;

  _TvDetailScreenState(
    this.selectedGenre,
    this.pageId,
  );

  late TvRecommendationProvider _recommendationProvider;
  late TvDetailProvider _tvDetailProvider;
  @override
  void initState() {
    this._recommendationProvider = Provider.of<TvRecommendationProvider>(
      context,
      listen: false,
    );
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
        future: this._recommendationProvider.tvRecommendation(
              this.selectedGenre,
              this.pageId,
            ),
        builder: (BuildContext context, AsyncSnapshot<List<TvModel>> snapshot) {
          if (snapshot.hasData) {
            return Consumer<TvRecommendationProvider>(
                builder: (context, value, child) {
              return _detailScreen(snapshot.data!);
            });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _detailScreen(List<TvModel> data) {
    return data.isEmpty
        ? Container(
            color: Color(0xff141414),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.images,
                    color: Colors.white,
                  ),
                  Container(
                    height: 50.0,
                    margin: EdgeInsets.only(top: 20.0),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return MainScreen();
                        }));
                      },
                      child: Text(
                        '서버오류, 재시도',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Color(0xffe50815),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : FutureBuilder(
            future: this._tvDetailProvider.tvs(data[0].id),
            builder:
                (BuildContext context, AsyncSnapshot<TvDetailModel> snapshot) {
              if (snapshot.hasData) {
                return Consumer<TvDetailProvider>(
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
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                color: Colors.grey[400],
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "https://image.tmdb.org/t/p/original/${snapshot.data!.posterPath}",
                                    ),
                                    fit: BoxFit.cover),
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
                                  size: 20.0,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                snapshot.data!.voteAverage.toString().isEmpty
                                    ? Text(
                                        '',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        snapshot.data!.voteAverage.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
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
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      snapshot.data!.name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
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
                                      maxLines: 8,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                      ),
                                    ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.calendar,
                                        color: Colors.white,
                                        size: 15.0,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      snapshot.data!.firstAirDate.isEmpty
                                          ? Text(
                                              '',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              '${snapshot.data!.firstAirDate} ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
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
                                        FontAwesomeIcons.calendarWeek,
                                        color: Colors.white,
                                        size: 15.0,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      snapshot.data!.lastAirDate.isEmpty
                                          ? Text(
                                              '',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              '${snapshot.data!.lastAirDate} ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
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
                                        size: 15.0,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      snapshot.data!.networks.isEmpty
                                          ? Text(
                                              '',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              '${snapshot.data!.networks[0].name} ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.favorite_border,
                                        ),
                                        color: Colors.white,
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
                return Container();
              }
            },
          );
  }
}
