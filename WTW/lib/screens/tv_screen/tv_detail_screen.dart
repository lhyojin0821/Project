import 'package:flutter/material.dart';
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
    return FutureBuilder(
      future: this._tvDetailProvider.tvs(data[0].id),
      builder: (BuildContext context, AsyncSnapshot<TvDetailModel> snapshot) {
        if (snapshot.hasData) {
          return Consumer<TvDetailProvider>(builder: (context, value, child) {
            return SafeArea(
                child: Stack(
              children: [
                snapshot.data!.posterPath.isEmpty
                    ? Container()
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                        icon: Icon(
                          Icons.keyboard_arrow_left_outlined,
                          color: Colors.white,
                          size: 40.0,
                        )),
                  ),
                ),
                Positioned(
                    top: 20.0,
                    right: 10.0,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.black45),
                      child: Row(
                        children: [
                          Icon(
                            Icons.credit_score_outlined,
                            color: Colors.yellow,
                            size: 25.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
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
                        Text(
                          snapshot.data!.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
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
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: Colors.white,
                                  size: 15.0,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
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
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: Colors.white,
                                  size: 15.0,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
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
                                Icon(
                                  Icons.network_wifi,
                                  color: Colors.white,
                                  size: 15.0,
                                ),
                                SizedBox(
                                  width: 3.0,
                                ),
                                Text(
                                  '${snapshot.data!.networks[0].name} ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
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
                TvVideoWidget(tvData: snapshot.data!.id),
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
