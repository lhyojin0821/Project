import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/search_model.dart';
import 'package:tms/models/tv_models/tv_model.dart';
import 'package:tms/providers/tv_provider/tv_detail_provider.dart';
import 'package:tms/widgets/tv_main_widget/tv_tile.dart';

class SearchTvSimilar extends StatefulWidget {
  final SearchModel tvData;
  SearchTvSimilar({required this.tvData});
  @override
  _SearchTvSimilarState createState() => _SearchTvSimilarState(this.tvData);
}

class _SearchTvSimilarState extends State<SearchTvSimilar> {
  final SearchModel tvData;
  _SearchTvSimilarState(this.tvData);

  late TvDetailProvider _tvController;

  @override
  void initState() {
    this._tvController = Provider.of<TvDetailProvider>(
      context,
      listen: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: this._tvController.similar(tvId: tvData.id),
        builder: (BuildContext context, AsyncSnapshot<List<TvModel>> snapshot) {
          if (snapshot.hasData) {
            return Consumer<TvDetailProvider>(
              builder: (context, value, child) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 10.0,
                          top: 20.0,
                        ),
                        child: Text(
                          'SIMILAR MOVIES',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                      ),
                      snapshot.data!.isEmpty
                          ? Container(
                              padding: EdgeInsets.all(20.0),
                              child: Center(
                                  child: Text(
                                'Preparation',
                                style: TextStyle(color: Colors.white),
                              )),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  snapshot.data!.length,
                                  (index) => TvTile(snapshot.data![index]),
                                  // _movieWidget.movieWidget(snapshot.data![index], context)
                                ),
                              ),
                            ),
                    ],
                  ),
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
