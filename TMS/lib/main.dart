import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tms/providers/movie_provider/movie_genre_provider.dart';
import 'package:tms/providers/movie_provider/movie_provider.dart';

import 'package:tms/providers/search_provider.dart';
import 'package:tms/providers/tv_provider/tv_genre_provider.dart';
import 'package:tms/providers/tv_provider/tv_provider.dart';
import 'package:tms/screens/randing_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => MovieProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => MovieGenreProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => TvProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => TvGenreProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => SearchProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LandingScreen(),
      ),
    );
  }
}
