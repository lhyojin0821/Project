import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/tv_models/tv_model.dart';
import 'package:tms/providers/tv_provider/tv_genre_provider.dart';

class TvGenreList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Consumer<TvGenreProvider>(
              builder: (context, controller, child) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(controller.tvs.length, (index) => movieWidget(controller.tvs[index], context)),
                  ),
                );
              },
              child: TvGenreList(),
            ),
          )
        ],
      ),
    );
  }

  Widget movieWidget(TvModel tv, BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                      'Image preparation..',
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
                      imageUrl: 'https://image.tmdb.org/t/p/original/${tv.posterPath}',
                    ),
                  ),
                  Container(
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
                      tv.voteAverage == 0
                          ? Center(
                              child: Container(),
                            )
                          : Container(
                              child: Icon(
                                Icons.star,
                                size: 14.0,
                                color: Colors.yellow,
                              ),
                            ),
                      tv.voteAverage == 0
                          ? Center(
                              child: Container(),
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
