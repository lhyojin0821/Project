import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/movie_models/movie_person_model.dart';
import 'package:tms/providers/movie_provider/movie_provider.dart';

class MoviePerson extends StatefulWidget {
  @override
  _MoviePersonState createState() => _MoviePersonState();
}

class _MoviePersonState extends State<MoviePerson> {
  late MovieProvider _movieController;

  @override
  void initState() {
    super.initState();
    this._movieController = Provider.of<MovieProvider>(
      context,
      listen: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this._movieController.moviePerson(),
      builder: (BuildContext context,
          AsyncSnapshot<List<MoviePersonModel>> snapshot) {
        if (snapshot.hasData) {
          return Consumer<MovieProvider>(
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
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 3.0,
                                child: ClipRRect(
                                  child: snapshot.data![i].profilePath.isEmpty
                                      ? Container(
                                          width: 80.0,
                                          height: 80.0,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Image preparation',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.0),
                                            ),
                                          ),
                                        )
                                      : CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/original${snapshot.data![i].profilePath}',
                                          imageBuilder: (BuildContext context,
                                              imgProvider) {
                                            return Container(
                                              width: 80.0,
                                              height: 80.0,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: imgProvider),
                                              ),
                                            );
                                          },
                                        ),
                                ),
                              ),
                              snapshot.data![i].name.isEmpty
                                  ? Container(
                                      width: 80.0,
                                      child: Center(
                                        child: Text(
                                          'Preparation',
                                          overflow: TextOverflow.ellipsis,
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
                              snapshot.data![i].knownForDepartment.isEmpty
                                  ? Container(
                                      child: Center(
                                        child: Text(
                                          'Preparation',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 8.0,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
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
          return Container();
        }
      },
    );
  }
}
