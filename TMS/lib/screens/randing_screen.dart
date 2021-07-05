import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tms/screens/movie_screens/movie_screen.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => MovieScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}