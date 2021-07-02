import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/tv_models/tv_genre_model.dart';
import 'package:tms/providers/tv_provider/tv_genre_provider.dart';
import 'package:tms/widgets/tv_main_widget/tv_genre_list.dart';

class TvGenre extends StatefulWidget {
  @override
  _TvGenreState createState() => _TvGenreState();
}

class _TvGenreState extends State<TvGenre> {
  late TvGenreProvider _tvController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this._tvController = Provider.of<TvGenreProvider>(
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
            future: this._tvController.loadGenre(),
            builder: (BuildContext context, AsyncSnapshot<List<TvGenreModel>> snapshot) {
              if (snapshot.hasData) {
                return Consumer<TvGenreProvider>(
                  builder: (context, value, child) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(snapshot.data!.length, (index) => _genreTag(snapshot.data![index])),
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
          TvGenreList(),
        ],
      ),
    );
  }

  Widget _genreTag(TvGenreModel genre) {
    var isSelected = _tvController.genreId == genre.id;
    return GestureDetector(
      onTap: () {
        _tvController.changeGenreList(genre);
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
        child: Container(
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
