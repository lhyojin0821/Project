import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/tv_models/tv_model.dart';
import 'package:tms/providers/tv_provider/tv_provider.dart';

class TvOnTheAir extends StatefulWidget {
  @override
  _TvOnTheAirState createState() => _TvOnTheAirState();
}

class _TvOnTheAirState extends State<TvOnTheAir> {
  late TvProvider _movieController;
  @override
  void initState() {
    this._movieController = Provider.of<TvProvider>(
      context,
      listen: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: this._movieController.onTheAir(),
        builder: (BuildContext context, AsyncSnapshot<List<TvModel>> snapshot) {
          if (snapshot.hasData) {
            return Consumer<TvProvider>(
              builder: (context, value, child) {
                return CarouselSlider.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int i, int? b) {
                    return GestureDetector(
                      onTap: () {},
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/original/${snapshot.data![i].backdropPath}',
                              height: MediaQuery.of(context).size.height,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              bottom: 15.0,
                              left: 15.0,
                            ),
                            child: Text(
                              snapshot.data![i].name,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(microseconds: 500),
                    pauseAutoPlayOnTouch: true,
                    viewportFraction: 0.8,
                    enlargeCenterPage: true,
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Container(),
            );
          }
        },
      ),
    );
  }
}
