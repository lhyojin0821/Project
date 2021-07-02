import 'package:flutter/material.dart';
import 'package:tms/widgets/movie_main_widget/movie_genre.dart';
import 'package:tms/widgets/movie_main_widget/movie_now_playing.dart';
import 'package:tms/widgets/movie_main_widget/movie_person.dart';
import 'package:tms/widgets/movie_main_widget/movie_popular.dart';
import 'package:tms/widgets/movie_main_widget/movie_top_rated.dart';
import 'package:tms/widgets/movie_main_widget/movie_upcoming.dart';

class MovieScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[900],
        title: Text('MOVIE'),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                MovieNowPlaying(),
                MovieGenre(),
                MoviePerson(),
                MovieTopRated(),
                MoviePopular(),
                MovieUpcoming(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
