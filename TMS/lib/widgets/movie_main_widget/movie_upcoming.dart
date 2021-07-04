import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/movie_models/movie_model.dart';
import 'package:tms/providers/movie_provider/movie_provider.dart';
import 'package:tms/widgets/movie_main_widget/movie_tile.dart';

class MovieUpcoming extends StatefulWidget {
  @override
  _MovieUpcomingState createState() => _MovieUpcomingState();
}

class _MovieUpcomingState extends State<MovieUpcoming> {
  late MovieProvider _movieController;

  @override
  void initState() {
    this._movieController = Provider.of<MovieProvider>(
      context,
      listen: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: this._movieController.upcoming(),
        builder:
            (BuildContext context, AsyncSnapshot<List<MovieModel>> snapshot) {
          if (snapshot.hasData) {
            return Consumer<MovieProvider>(
              builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 10.0,
                        top: 20.0,
                      ),
                      child: Text(
                        'UPCOMING MOVIES',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          snapshot.data!.length,
                          (index) => MovieTile(snapshot.data![index]),
                          // _movieWidget.movieWidget(
                          // snapshot.data![index], context)
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
