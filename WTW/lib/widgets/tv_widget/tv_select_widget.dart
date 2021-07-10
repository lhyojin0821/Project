import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtw/models/select_model.dart';
import 'package:wtw/providers/movie_provider/movie_detail_provider.dart';
import 'package:wtw/screens/movie_screen/movie_detail_screen.dart';
import 'dart:math';

import 'package:wtw/widgets/tv_widget/tv_tile_widget.dart';

class TvSelectWidget extends StatefulWidget {
  @override
  _TvSelectWidgetState createState() => _TvSelectWidgetState();
}

class _TvSelectWidgetState extends State<TvSelectWidget> {
  late SelectedModel _selectedGenre;
  late SelectedModel _selectedScore;
  late List<SelectedModel> genres;
  late List<SelectedModel> scores;
  late int movieId;

  Color subColor = Color(0xff141414);
  Color mainColor = Color(0xffe50815);

  @override
  void initState() {
    this.genres = [
      SelectedModel(title: '액션', value: 10759),
      SelectedModel(title: '애니메이션', value: 16),
      SelectedModel(title: '코메디', value: 35),
      SelectedModel(title: '범죄', value: 80),
      SelectedModel(title: '다큐', value: 99),
      SelectedModel(title: '드라마', value: 18),
    ];
    this.scores = [
      SelectedModel(title: '5', value: 5),
      SelectedModel(title: '6', value: 6),
      SelectedModel(title: '7', value: 7),
      SelectedModel(title: '8', value: 8),
    ];

    this._selectedGenre = this.genres[0];
    this._selectedScore = this.scores[0];
    this.movieId = new Random().nextInt(100000) + 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.subColor,
      padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
      child: Column(
        children: [
          _selectWidget(),
          TvTileWidget(),
        ],
      ),
    );
  }

  Widget _selectWidget() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "장르",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 5.0),
              height: 30.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: this.mainColor,
                  border: Border.all(color: this.mainColor, width: 1.0)),
              child: Theme(
                data: ThemeData(canvasColor: this.subColor),
                child: new DropdownButton<SelectedModel>(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  isExpanded: false,
                  underline: Container(),
                  hint: Text(
                    "",
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                  value: this._selectedGenre,
                  onChanged: (SelectedModel? newValue) {
                    setState(() {
                      this._selectedGenre = newValue!;
                      print(newValue.value);
                    });
                  },
                  items: genres.map((SelectedModel filter) {
                    return new DropdownMenuItem<SelectedModel>(
                        value: filter,
                        child: Row(
                          children: <Widget>[
                            new Text(
                              filter.title,
                              style: new TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                            ),
                          ],
                        ));
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TMDB 점수",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0),
              ),
              SizedBox(
                height: 4.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 5.0),
                height: 30.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: this.mainColor,
                    border: Border.all(color: this.mainColor, width: 1.0)),
                child: Theme(
                  data: ThemeData(canvasColor: this.subColor),
                  child: new DropdownButton<SelectedModel>(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    isExpanded: false,
                    underline: Container(),
                    hint: Text(
                      "",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    ),
                    value: this._selectedScore,
                    onChanged: (SelectedModel? newValue) {
                      setState(() {
                        this._selectedScore = newValue!;
                        print(newValue.value);
                      });
                    },
                    items: scores.map((SelectedModel filter) {
                      return new DropdownMenuItem<SelectedModel>(
                          value: filter,
                          child: Row(
                            children: <Widget>[
                              new Text(
                                filter.title,
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                              ),
                            ],
                          ));
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 1.0, right: 10.0),
              height: 50.0,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: this.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ChangeNotifierProvider(
                        create: (BuildContext context) => MovieDetailProvider(),
                        child: MovieDetailScreen(
                          selectedGenre: this._selectedGenre.value,
                          selectedScore: this._selectedScore.value.ceil(),
                          movieId: this.movieId,
                        ),
                      );
                    }));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.white),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text("검색",
                          style: new TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  )),
            )
          ],
        )
      ],
    );
  }
}
