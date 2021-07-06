import 'package:flutter/material.dart';
import 'package:tms/screens/search_screen/search_screen.dart';
import 'package:tms/screens/tv_screens/tv_screen.dart';
import 'package:tms/widgets/movie_main_widget/movie_genre.dart';
import 'package:tms/widgets/movie_main_widget/movie_now_playing.dart';
import 'package:tms/widgets/movie_main_widget/movie_person.dart';
import 'package:tms/widgets/movie_main_widget/movie_popular.dart';
import 'package:tms/widgets/movie_main_widget/movie_top_rated.dart';
import 'package:tms/widgets/movie_main_widget/movie_upcoming.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar:
      // AppBar(
      //     centerTitle: true,
      //     elevation: 0.0,
      //     backgroundColor: Colors.black,
      //     title: this.currentTab == 0 ? Text('MOVIE') : Text('TV')),
      body: IndexedStack(children: [
        _movieScreen(),
        TvScreen(),
        SearchScreen(),
      ], index: currentTab),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentTab = index;
          });
        },
        currentIndex: currentTab,
        selectedFontSize: 12.0,
        unselectedFontSize: 10.0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.movie,
              ),
              label: 'MOVIE'),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'TV'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'SEARCH'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: 'FAVORITE'),
        ],
      ),
    );
  }

  Widget _movieScreen() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              MovieNowPlaying(),
              MovieGenre(),
              MoviePerson(),
              MovieUpcoming(),
              MoviePopular(),
              MovieTopRated(),
            ],
          ),
        ),
      ),
    );
  }
}
