import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtw/providers/auth_provider.dart';
import 'package:wtw/screens/guest_screen.dart';
import 'package:wtw/screens/login/register_screen.dart';
import 'package:wtw/screens/login/wrapper.dart';
import 'package:wtw/screens/movie_screen/movie_main_screen.dart';
import 'package:wtw/screens/tv_screen/tv_main_screen.dart';
import 'package:wtw/screens/user_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Color subColor = Color(0xff141414);
  Color mainColor = Color(0xffe50815);

  @override
  void initState() {
    this._tabController = new TabController(length: 3, vsync: this);
    Provider.of<AuthProvider>(context, listen: false)
        .getUser()
        .whenComplete(() => {setState(() {})});
    super.initState();
  }

  @override
  void dispose() {
    this._tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('What To Watch'),
          centerTitle: true,
          backgroundColor: this.mainColor,
          bottom: TabBar(
            indicatorColor: Colors.white,
            controller: this._tabController,
            tabs: [
              Container(
                  margin: EdgeInsets.only(bottom: 15.0),
                  child: Icon(
                    Icons.movie_creation_rounded,
                    color: Colors.white,
                  )),
              Container(
                  margin: EdgeInsets.only(bottom: 15.0),
                  child: Icon(
                    Icons.tv_rounded,
                    color: Colors.white,
                  )),
              Container(
                  margin: EdgeInsets.only(bottom: 15.0),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
        body: TabBarView(
          controller: this._tabController,
          children: [
            MovieMainScreen(),
            TvMainScreen(),
            FirebaseAuth.instance.currentUser == null
                ? GuestScreen()
                : UserScreen(),
          ],
        ));
  }
}
