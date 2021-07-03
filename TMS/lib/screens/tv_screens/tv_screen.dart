import 'package:flutter/material.dart';
import 'package:tms/widgets/tv_main_widget/tv_airing_today.dart';
import 'package:tms/widgets/tv_main_widget/tv_genre.dart';
import 'package:tms/widgets/tv_main_widget/tv_on_the_air.dart';
import 'package:tms/widgets/tv_main_widget/tv_person.dart';
import 'package:tms/widgets/tv_main_widget/tv_popular.dart';
import 'package:tms/widgets/tv_main_widget/tv_top_rated.dart';

class TvScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[900],
        title: Text('TV'),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                OnTheAir(),
                TvGenre(),
                TvPerson(),
                TvPopular(),
                TvAiringToday(),
                TvTopRated(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
