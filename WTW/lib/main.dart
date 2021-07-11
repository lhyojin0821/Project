import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtw/providers/movie_provider/movie_nowplaying_provider.dart';
import 'package:wtw/providers/tv_provider/tv_popular_provider.dart';
import 'package:wtw/screens/lading_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => MovieNowPlayingProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => TvPopularProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LandingScreen(),
      ),
    );
  }
}
