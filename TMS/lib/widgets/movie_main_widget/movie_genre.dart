import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/movie_models/movie_genre_model.dart';
import 'package:tms/providers/movie_provider/movie_genre_provider.dart';
import 'package:tms/widgets/movie_main_widget/movie_genre_list.dart';

class MovieGenre extends StatefulWidget {
  @override
  _MovieGenreState createState() => _MovieGenreState();
}

class _MovieGenreState extends State<MovieGenre> {
  late MovieGenreProvider _movieController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this._movieController = Provider.of<MovieGenreProvider>(
      context,
      listen: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          FutureBuilder(
            future: this._movieController.loadGenre(),
            builder: (BuildContext context,
                AsyncSnapshot<List<MovieGenreModel>> snapshot) {
              if (snapshot.hasData) {
                return Consumer<MovieGenreProvider>(
                  builder: (context, value, child) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(snapshot.data!.length,
                            (index) => _genreTag(snapshot.data![index])),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          MovieGenreList(),
        ],
      ),
    );
  }

  Widget _genreTag(MovieGenreModel genre) {
    var isSelected = _movieController.genreId == genre.id;
    return GestureDetector(
      onTap: () {
        _movieController.changeGenreList(genre);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.only(left: 10.0, bottom: 5.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          color: isSelected ? Colors.white : Colors.black,
        ),
        child: genre.name.isEmpty
            ? Container(
                child: Text(
                  'preparation',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.black : Colors.white,
                  ),
                ),
              )
            : Container(
                child: Text(
                  genre.name,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.black : Colors.white,
                  ),
                ),
              ),
      ),
    );
  }
}
