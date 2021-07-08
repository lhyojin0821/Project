import 'package:flutter/material.dart';
import 'package:wtw/models/select_model.dart';
import 'package:wtw/screens/movie_detail_screen.dart';

class MovieWidget extends StatefulWidget {
  @override
  _MovieWidgetState createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<MovieWidget> {
  late SelectedModel _selectedGenre;
  late SelectedModel _selectedScore;
  late List<SelectedModel> genres;
  late List<SelectedModel> scores;

  Color subColor = Color(0xff141414);
  Color mainColor = Color(0xffe50815);

  @override
  void initState() {
    this.genres = [
      SelectedModel(title: '모든 장르', value: 0),
      SelectedModel(title: '액션', value: 5),
      SelectedModel(title: '드라마', value: 3),
      SelectedModel(title: '코미디', value: 9),
      SelectedModel(title: '공포', value: 19),
      SelectedModel(title: '애니메이션', value: 6),
      SelectedModel(title: '만화', value: 39),
    ];

    this.scores = [
      SelectedModel(title: '모든 점수', value: 0),
      SelectedModel(title: '5', value: 5),
      SelectedModel(title: '6', value: 6),
      SelectedModel(title: '7', value: 7),
      SelectedModel(title: '8', value: 8),
    ];
    this._selectedGenre = this.genres[0];
    this._selectedScore = this.scores[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.subColor,
      padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
      child: Row(
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
                  "IMDB 점수",
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
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return MovieDetailScreen(
                            selectedGenre: this._selectedGenre.value,
                            selectedScore: this._selectedScore.value);
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
      ),
    );
  }
}
