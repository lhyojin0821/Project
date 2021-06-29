import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/movie_person_model.dart';
import 'package:tms/providers/movie_person_provider.dart';

class MoviePerson extends StatefulWidget {
  @override
  _MoviePersonState createState() => _MoviePersonState();
}

class _MoviePersonState extends State<MoviePerson> {
  late MoviePersonProvider _movieController;

  @override
  void initState() {
    super.initState();
    this._movieController = Provider.of<MoviePersonProvider>(
      context,
      listen: false,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: this._movieController.moviePerson(),
          builder: (BuildContext context, AsyncSnapshot<List<MoviePersonModel>> snapshot) {
            if (snapshot.hasData) {
              return Consumer<MoviePersonProvider>(
                builder: (context, value, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 20.0, bottom: 10.0),
                        child: Text(
                          'TRENDING PERSONS ON THIS WEEK',
                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 12.0),
                        ),
                      ),
                      Container(
                        height: 110.0,
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
                                        borderRadius: BorderRadius.circular(100.0),
                                      ),
                                      elevation: 3.0,
                                      child: ClipRRect(
                                        child: CachedNetworkImage(
                                          imageUrl: 'https://image.tmdb.org/t/p/w200${snapshot.data![i].profilePath}',
                                          imageBuilder: (BuildContext context, imgProvider) {
                                            return Container(
                                              width: 80.0,
                                              height: 80.0,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100.0),
                                                image: DecorationImage(fit: BoxFit.cover, image: imgProvider),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Center(
                                      child: Text(
                                        snapshot.data![i].name.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8.0,
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
      ],
    );
  }
}
