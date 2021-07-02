import 'package:flutter/material.dart';
import 'package:tms/screens/movie_screens/movie_screen.dart';
import 'package:tms/screens/tv_screens/tv_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
        ),
        children: [
          _gridTile(
              text: 'TV',
              imgUrl: 'https://images.unsplash.com/photo-1589569334232-fdc917c38226?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Njl8fG1vdmllfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return TvScreen();
                }));
              }),
          _gridTile(
              text: 'MOVIE',
              imgUrl: 'https://images.unsplash.com/photo-1440404653325-ab127d49abc1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8bW92aWV8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return MovieScreen();
                }));
              }),
        ],
      ),
    );
  }

  Widget _gridTile({
    required String text,
    required String imgUrl,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                text,
                style: TextStyle(color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 320.0,
              height: 320.0,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(60.0), image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(imgUrl))),
            ),
          ],
        ),
      ),
    );
  }
}
