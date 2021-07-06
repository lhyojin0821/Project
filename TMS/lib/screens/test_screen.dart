import 'package:flutter/material.dart';
import 'package:tms/screens/movie_screens/movie_screen.dart';
import 'package:tms/screens/tv_screens/tv_screen.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MovieScreen()));
            },
            child: Text('MOVIE'),
          ),
          SizedBox(height: 30.0),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => TvScreen()));
            },
            child: Text('TV'),
          ),
        ],
      ),
    );
  }
}
