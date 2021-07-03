import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/tv_models/tv_person_model.dart';
import 'package:tms/providers/tv_provider/tv_provider.dart';

class TvPerson extends StatefulWidget {
  @override
  _TvPersonState createState() => _TvPersonState();
}

class _TvPersonState extends State<TvPerson> {
  late TvProvider _tvController;

  @override
  void initState() {
    super.initState();
    this._tvController = Provider.of<TvProvider>(
      context,
      listen: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: this._tvController.tvPerson(),
        builder: (BuildContext context, AsyncSnapshot<List<TvPersonModel>> snapshot) {
          if (snapshot.hasData) {
            return Consumer<TvProvider>(
              builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 10.0,
                        top: 20.0,
                        bottom: 10.0,
                      ),
                      child: Text(
                        'TRENDING PERSONS ON THIS WEEK',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 6.0),
                      height: 120.0,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (BuildContext context, int i) {
                          return VerticalDivider(
                            color: Colors.transparent,
                            width: 5.0,
                          );
                        },
                        itemBuilder: (BuildContext context, int i) {
                          return Container(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 3.0,
                                    child: ClipRRect(
                                      child: CachedNetworkImage(
                                        imageUrl: 'https://image.tmdb.org/t/p/original${snapshot.data![i].profilePath}',
                                        imageBuilder: (BuildContext context, imgProvider) {
                                          return Container(
                                            width: 80.0,
                                            height: 80.0,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              image: DecorationImage(fit: BoxFit.cover, image: imgProvider),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 80.0,
                                  child: Center(
                                    child: Text(
                                      snapshot.data![i].name.toUpperCase(),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Center(
                                    child: Text(
                                      snapshot.data![i].knownForDepartment,
                                      style: TextStyle(
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
                );
              },
            );
          } else {
            return Center(
              child: Text(''),
            );
          }
        },
      ),
    );
  }
}
