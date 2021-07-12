import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Color subColor = Color(0xff141414);
  Color mainColor = Color(0xffe50815);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.subColor,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 10.0, crossAxisSpacing: 10.0),
          itemCount: 9,
          itemBuilder: (BuildContext context, int i) {
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/original//szGpS43AM11mGzTdxFQ5wOis3EH.jpg'),
              )),
            );
          }),
    );
  }
}
