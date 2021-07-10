import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtw/providers/movie_provider/movie_provider.dart';
import 'package:wtw/providers/tv_provider/tv_provider.dart';
import 'package:wtw/screens/lading_screen.dart';
import 'package:wtw/screens/main_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => MovieProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => TvProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LandingScreen(),
      ),
    );
  }
}
