import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wtw/screens/favorite_screen.dart';
import 'package:wtw/screens/login_screen.dart';
import 'package:wtw/screens/movie_screen/movie_main_screen.dart';
import 'package:wtw/screens/tv_screen/tv_main_screen.dart';

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
          actions: [
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return LoginScreen();
                    })));
              },
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ],
          centerTitle: true,
          backgroundColor: this.mainColor,
          title: Text(
            'What to Watch',
            style: TextStyle(color: Colors.white),
          ),
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
                    Icons.favorite_border,
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
            FavoriteScreen(),
          ],
        ));
  }
}
