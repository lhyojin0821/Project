import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/tv_models/tv_model.dart';
import 'package:tms/providers/tv_provider/tv_provider.dart';
import 'package:tms/widgets/tv_main_widget/tv_tile.dart';

class TvTopRated extends StatefulWidget {
  @override
  _TvTopRatedState createState() => _TvTopRatedState();
}

class _TvTopRatedState extends State<TvTopRated> {
  late TvProvider _tvController;

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
        future: this._tvController.topRated(),
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
                        'TOP RATED TV PROGRAMS',
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
                          (index) => TvTile(snapshot.data![index]),
                          // _tvWidget.tvWidget(snapshot.data![index], context)
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
