import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wtw/screens/main_screen.dart';
import 'package:wtw/widgets/login_widget.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            if (!snapshot.hasData) {
              return LoginWidget();
            } else {
              return MainScreen();
            }
          }),
    );
  }
}
