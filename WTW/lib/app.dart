import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wtw/screens/login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Firebase load fail'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen();
          }
          return CircularProgressIndicator();
        });
  }
}
