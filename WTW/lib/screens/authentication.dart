import 'package:flutter/material.dart';
import 'package:wtw/screens/login_screen.dart';
import 'package:wtw/screens/register_screen.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isToggle = false;
  void toggleScreen() {
    setState(() {
      this.isToggle = !this.isToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this.isToggle) {
      return RegisterScreen(
        toggleScreen: toggleScreen,
      );
    } else {
      return LoginScreen(toggleScreen: toggleScreen);
    }
  }
}
