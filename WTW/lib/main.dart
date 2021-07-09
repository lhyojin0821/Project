import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtw/providers/movie_provider.dart';
import 'package:wtw/screens/main_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MovieProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      ),
    );
  }
}
