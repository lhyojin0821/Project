import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/search_model.dart';
import 'package:tms/models/tv_models/tv_cast_model.dart';
import 'package:tms/providers/tv_provider/tv_detail_provider.dart';

class SearchTvCast extends StatefulWidget {
  final SearchModel tvData;
  SearchTvCast({required this.tvData});

  @override
  _SearchTvCastState createState() => _SearchTvCastState(this.tvData);
}

class _SearchTvCastState extends State<SearchTvCast> {
  late SearchModel tvData;

  _SearchTvCastState(this.tvData);

  late TvDetailProvider _tvController;

  @override
  void initState() {
    this._tvController = Provider.of<TvDetailProvider>(
      context,
      listen: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: this._tvController.tvCast(tvId: tvData.id),
        builder:
            (BuildContext context, AsyncSnapshot<List<TvCastModel>> snapshot) {
          if (snapshot.hasData) {
            return Consumer<TvDetailProvider>(
              builder: (context, value, child) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 20.0, left: 10.0),
                        child: Text(
                          "CASTS",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 10.0,
                          left: 5.0,
                        ),
                        height: 150.0,
                        child: snapshot.data!.isEmpty
                            ? Container(
                                child: Center(
                                    child: Text(
                                  'Preparation',
                                  style: TextStyle(color: Colors.white),
                                )),
                              )
                            : ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                separatorBuilder:
                                    (BuildContext context, int i) {
                                  return VerticalDivider(
                                    color: Colors.transparent,
                                    width: 5.0,
                                  );
                                },
                                itemBuilder: (BuildContext context, int i) {
                                  return Container(
                                    child: Column(
                                      children: [
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          elevation: 3.0,
                                          child: ClipRRect(
                                            child: snapshot.data![i].profilePath
                                                    .isEmpty
                                                ? Container(
                                                    width: 80.0,
                                                    height: 80.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'Image preparation',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 10.0),
                                                      ),
                                                    ),
                                                  )
                                                : CachedNetworkImage(
                                                    imageUrl:
                                                        'https://image.tmdb.org/t/p/w200${snapshot.data![i].profilePath}',
                                                    imageBuilder:
                                                        (BuildContext context,
                                                            imgProvider) {
                                                      return Container(
                                                        width: 80.0,
                                                        height: 80.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  imgProvider),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                          ),
                                        ),
                                        snapshot.data![i].name.isEmpty
                                            ? Container(
                                                width: 70.0,
                                                child: Center(
                                                  child: Text(
                                                    'Preparation',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 9.0,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 70.0,
                                                child: Center(
                                                  child: Text(
                                                    snapshot.data![i].name
                                                        .toUpperCase(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 9.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        snapshot.data![i].character.isEmpty
                                            ? Container(
                                                padding:
                                                    EdgeInsets.only(top: 5.0),
                                                width: 70.0,
                                                child: Center(
                                                  child: Text(
                                                    'Preparation',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      height: 1.4,
                                                      color: Colors.grey,
                                                      fontSize: 8.0,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                padding:
                                                    EdgeInsets.only(top: 5.0),
                                                width: 70.0,
                                                child: Center(
                                                  child: Text(
                                                    snapshot.data![i].character,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      height: 1.4,
                                                      color: Colors.grey,
                                                      fontSize: 8.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
