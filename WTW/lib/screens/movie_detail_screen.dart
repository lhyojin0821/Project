import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtw/models/movie_model.dart';
import 'package:wtw/providers/movie_provider.dart';
import 'package:wtw/screens/main_screen.dart';

class MovieDetailScreen extends StatefulWidget {
  final int selectedScore;
  final int selectedGenre;
  MovieDetailScreen({required this.selectedGenre, required this.selectedScore});

  @override
  _MovieDetailScreenState createState() =>
      _MovieDetailScreenState(this.selectedGenre, this.selectedScore);
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  int selectedScore;
  int selectedGenre;
  int index = 0;

  _MovieDetailScreenState(this.selectedGenre, this.selectedScore);

  late MovieProvider _movieProvider;

  @override
  void initState() {
    this._movieProvider = Provider.of<MovieProvider>(
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
        future:
            this._movieProvider.movies(this.selectedGenre, this.selectedScore),
        builder:
            (BuildContext context, AsyncSnapshot<List<MovieModel>> snapshot) {
          if (snapshot.hasData) {
            return Consumer<MovieProvider>(builder: (context, value, child) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Colors.grey[400],
                      image: DecorationImage(
                          image: NetworkImage(
                            "https://images.unsplash.com/photo-1625575841926-c8c1288908c0?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
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
                              Colors.black.withOpacity(0.0)
                            ],
                            stops: [
                              0.0,
                              0.5
                            ])),
                  ),
                  Positioned(
                    top: 50.0,
                    left: 20.0,
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
                            size: 30.0,
                          )),
                    ),
                  ),
                  Positioned(
                      bottom: 98.0,
                      left: 55.0,
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            color: Colors.black45),
                        child: Row(
                          children: [
                            Icon(
                              Icons.ac_unit,
                              color: Colors.yellow,
                              size: 25.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '9.0',
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
                              'luca',
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
                              'overview',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
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
                                      Icons.lock_clock_outlined,
                                      color: Colors.white,
                                      size: 15.0,
                                    ),
                                    SizedBox(
                                      width: 3.0,
                                    ),
                                    Text(
                                      '90min',
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
                                      width: 3.0,
                                    ),
                                    Text(
                                      '0000-00-00'.substring(0, 10),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                ],
              );
            });
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
