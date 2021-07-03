import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/tv_models/tv_model.dart';
import 'package:tms/providers/tv_provider/tv_provider.dart';
import 'package:tms/widgets/tv_main_widget/tv_genre_list.dart';

class TvAiringToday extends StatefulWidget {
  @override
  _TvAiringTodayState createState() => _TvAiringTodayState();
}

class _TvAiringTodayState extends State<TvAiringToday> {
  late TvProvider _tvController;
  TvGenreList _tvWidget = TvGenreList();

  @override
  void initState() {
    this._tvController = Provider.of<TvProvider>(
      context,
      listen: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: this._tvController.airingToday(),
        builder: (BuildContext context, AsyncSnapshot<List<TvModel>> snapshot) {
          if (snapshot.hasData) {
            return Consumer<TvProvider>(
              builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 10.0,
                        top: 20.0,
                        bottom: 10.0,
                      ),
                      child: Text(
                        'AIRING TODAY TV PROGRAMS',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(snapshot.data!.length, (index) => _tvWidget.movieWidget(snapshot.data![index], context)),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return Center(
              child: Text(''),
            );
          }
        },
      ),
    );
  }
}
