import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wtw/main.dart';
import 'package:wtw/screens/login/wrapper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Wrapper()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff141414),
      body: Stack(
        children: [
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('images/logo.png'),
                ))),
          ),
          Container(
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
