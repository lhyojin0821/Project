import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/tv_models/tv_detail_model.dart';
import 'package:tms/models/tv_models/tv_model.dart';
import 'package:tms/providers/tv_provider/tv_detail_provider.dart';

class TvInfo extends StatefulWidget {
  final TvModel tvData;
  TvInfo({required this.tvData});

  @override
  _TvInfoState createState() => _TvInfoState(this.tvData);
}

class _TvInfoState extends State<TvInfo> {
  late TvModel tvData;

  _TvInfoState(this.tvData);

  late TvDetailProvider _tvController;

  final formatCurrency = new NumberFormat.simpleCurrency(decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    this._tvController = Provider.of<TvDetailProvider>(
      context,
      listen: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FutureBuilder(
            future: this._tvController.tvDetail(tvId: tvData.id),
            builder:
                (BuildContext context, AsyncSnapshot<TvDetailModel> snapshot) {
              if (snapshot.hasData) {
                return Consumer<TvDetailProvider>(
                  builder: (context, value, child) {
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10.0, top: 20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 16.0,
                                  ),
                                ),
                                this.tvData.voteAverage.toString().isEmpty
                                    ? Container(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          'Preparation',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white),
                                        ),
                                      )
                                    : Container(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          this.tvData.voteAverage.toString(),
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 20.0, left: 10.0),
                            child: Text(
                              'OVERVIEW',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          this.tvData.overView.isEmpty
                              ? Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Center(
                                    child: Text(
                                      'Preparation',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    this.tvData.overView,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                          Container(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "FIRST AIR DATE",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    snapshot.data!.firstAirDate
                                            .toString()
                                            .isEmpty
                                        ? Container(
                                            padding: EdgeInsets.only(top: 5.0),
                                            child: Text(
                                              'Preparation',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0),
                                            ),
                                          )
                                        : Container(
                                            padding: EdgeInsets.only(top: 5.0),
                                            child: Text(
                                              snapshot.data!.firstAirDate
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0),
                                            ),
                                          ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "LAST AIR DATE",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    snapshot.data!.lastAirDate
                                            .toString()
                                            .isEmpty
                                        ? Container(
                                            padding: EdgeInsets.only(top: 5.0),
                                            child: Text(
                                              'Preparation',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0),
                                            ),
                                          )
                                        : Container(
                                            padding: EdgeInsets.only(top: 5.0),
                                            child: Text(
                                              snapshot.data!.lastAirDate
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0),
                                            ),
                                          ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "NETWORK",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    snapshot.data!.networks[0].name.isEmpty
                                        ? Container(
                                            padding: EdgeInsets.only(top: 5.0),
                                            child: Text(
                                              'Preparation',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0),
                                            ),
                                          )
                                        : Container(
                                            padding: EdgeInsets.only(top: 5.0),
                                            child: Text(
                                              snapshot.data!.networks[0].name
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0),
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0, top: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 15.0),
                                  child: Text(
                                    'GENRES',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                snapshot.data!.genres.isEmpty
                                    ? Container(
                                        child: Center(
                                          child: Text(
                                            'Preparation',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 38.0,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              snapshot.data!.genres.length,
                                          separatorBuilder:
                                              (BuildContext context, int i) {
                                            return VerticalDivider(
                                              color: Colors.transparent,
                                              width: 12.0,
                                            );
                                          },
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return snapshot.data!.genres[i].name
                                                    .isEmpty
                                                ? Container(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      border: Border.all(
                                                        width: 1.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'Preparation',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 10.0,
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      border: Border.all(
                                                        width: 1.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      snapshot
                                                          .data!.genres[i].name,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 10.0,
                                                      ),
                                                    ),
                                                  );
                                          },
                                        )),
                              ],
                            ),
                          )
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
        ],
      ),
    );
  }
}
