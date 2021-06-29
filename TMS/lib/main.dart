import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/providers/movie_detail_provider.dart';
import 'package:tms/providers/movie_genre_provider.dart';
import 'package:tms/providers/movie_person_provider.dart';
import 'package:tms/providers/movie_provider.dart';
import 'package:tms/providers/movie_video_provider.dart';
import 'package:tms/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => MovieProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => MovieGenreProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => MoviePersonProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => MovieDetailProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => MovieVideoProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      ),
    );
  }
}
