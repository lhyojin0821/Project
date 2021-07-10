import 'package:flutter/material.dart';
import 'package:wtw/widgets/movie_widget/movie_select_widget.dart';
import 'package:wtw/widgets/tv_widget/tv_select_widget.dart';

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
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings),
            ),
          ],
          centerTitle: true,
          backgroundColor: this.mainColor,
          title: Text(
            '뭐 볼까?',
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
            MovieSelectWidget(),
            TvSelectWidget(),
          ],
        ));
  }
}
