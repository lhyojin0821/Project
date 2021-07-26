import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wtw/models/select_model.dart';
import 'package:wtw/providers/tv_provider/tv_detail_provider.dart';
import 'package:wtw/providers/tv_provider/tv_recommendation_provider.dart';
import 'package:wtw/providers/tv_provider/tv_video_provider.dart';
import 'package:wtw/screens/tv_screen/tv_detail_no_user_screen.dart';
import 'package:wtw/screens/tv_screen/tv_detail_screen.dart';
import 'package:wtw/widgets/tv_widget/tv_tile_widget.dart';

class TvMainScreen extends StatefulWidget {
  @override
  _TvMainScreenState createState() => _TvMainScreenState();
}

class _TvMainScreenState extends State<TvMainScreen> {
  late SelectModel _selectedGenre;
  late List<SelectModel> genres;
  late int randomPage;

  Color subColor = Color(0xff141414);
  Color mainColor = Color(0xffe50815);

  @override
  void initState() {
    this.genres = [
      SelectModel(title: '장르', value: 0),
      SelectModel(title: '액션 & 모험', value: 10759),
      SelectModel(title: '코미디', value: 35),
      SelectModel(title: '범죄', value: 80),
      SelectModel(title: '드라마', value: 18),
      SelectModel(title: '가족', value: 10751),
      SelectModel(title: '미스터리', value: 9648),
      SelectModel(title: '판타지', value: 10765),
      SelectModel(title: '전쟁 & 정치', value: 10768),
    ];
    this.randomPage = new Random().nextInt(20) + 1;
    this._selectedGenre = this.genres[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.subColor,
      padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
      child: Column(
        children: [
          _selectWidget(context),
          TvTileWidget(),
        ],
      ),
    );
  }

  Widget _selectWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 45.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: this.mainColor,
              border: Border.all(color: this.mainColor, width: 1.0)),
          child: Theme(
            data: ThemeData(canvasColor: this.subColor),
            child: new DropdownButton<SelectModel>(
              icon: Container(
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
              ),
              isExpanded: false,
              underline: Container(),
              hint: Text(
                "",
                style: TextStyle(fontSize: 12.0, color: Colors.white),
              ),
              value: this._selectedGenre,
              onChanged: (SelectModel? newValue) {
                setState(() {
                  this._selectedGenre = newValue!;
                  print(newValue.value);
                });
              },
              items: genres.map((SelectModel filter) {
                return new DropdownMenuItem<SelectModel>(
                    value: filter,
                    child: Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 100.0,
                        child: Center(
                          child: new Text(
                            filter.title,
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ));
              }).toList(),
            ),
          ),
        ),
        SizedBox(
          width: 15.0,
        ),
        Container(
          height: 45.0,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: this.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                if (this._selectedGenre.value != 0 &&
                    FirebaseAuth.instance.currentUser != null) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) {
                    return MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                            create: (BuildContext context) =>
                                TvRecommendationProvider()),
                        ChangeNotifierProvider(
                            create: (BuildContext context) =>
                                TvDetailProvider()),
                        ChangeNotifierProvider(
                            create: (BuildContext context) =>
                                TvVideoProvider()),
                      ],
                      child: TvDetailScreen(
                        selectedGenre: this._selectedGenre.value,
                        pageId: this.randomPage,
                      ),
                    );
                  }));
                } else if (this._selectedGenre.value != 0 &&
                    FirebaseAuth.instance.currentUser == null) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) {
                    return MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                            create: (BuildContext context) =>
                                TvRecommendationProvider()),
                        ChangeNotifierProvider(
                            create: (BuildContext context) =>
                                TvDetailProvider()),
                        ChangeNotifierProvider(
                            create: (BuildContext context) =>
                                TvVideoProvider()),
                      ],
                      child: TvDetailNoUserScreen(
                        selectedGenre: this._selectedGenre.value,
                        pageId: this.randomPage,
                      ),
                    );
                  }));
                }
              },
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.dice,
                    color: Colors.white,
                    size: 16.0,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text("추천",
                      style: new TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              )),
        )
      ],
    );
  }
}
