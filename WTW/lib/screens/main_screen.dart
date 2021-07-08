import 'package:flutter/material.dart';
import 'package:wtw/widgets/movie_widget.dart';

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
    this._tabController = new TabController(length: 2, vsync: this);
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
          centerTitle: true,
          backgroundColor: this.mainColor,
          title: Text(
            '무엇을 볼 것인가?',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            controller: this._tabController,
            tabs: [
              Container(padding: EdgeInsets.all(10.0), child: Text('MOVIE')),
              Container(padding: EdgeInsets.all(10.0), child: Text('TV')),
            ],
          ),
        ),
        body: TabBarView(
          controller: this._tabController,
          children: [
            MovieWidget(),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.black.withOpacity(0.0)
                      ],
                      stops: [
                        0.0,
                        0.5
                      ])),
            ),
          ],
        ));
  }
}
