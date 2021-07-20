import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wtw/models/tv_model/tv_detail_model.dart';
import 'package:wtw/models/user_model.dart';
import 'package:wtw/providers/tv_provider/tv_detail_provider.dart';
import 'package:wtw/repository/db_repo.dart';
import 'package:wtw/widgets/tv_widget/tv_video_widget.dart';

class UserTvDetailScreen extends StatefulWidget {
  final int userTvId;

  UserTvDetailScreen({required this.userTvId});

  @override
  _UserTvDetailScreenState createState() => _UserTvDetailScreenState(
        this.userTvId,
      );
}

class _UserTvDetailScreenState extends State<UserTvDetailScreen> {
  int userTvId;

  _UserTvDetailScreenState(
    this.userTvId,
  );

  late TvDetailProvider _tvDetailProvider;
  @override
  void initState() {
    this._tvDetailProvider = Provider.of<TvDetailProvider>(
      context,
      listen: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = UserModel.current;
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: this._tvDetailProvider.tvs(this.userTvId),
        builder: (BuildContext context, AsyncSnapshot<TvDetailModel> snapshot) {
          if (snapshot.hasData) {
            List checkList = user.userTv!
                .where((element) => element['userTvId'] == snapshot.data!.id)
                .toList();
            bool check;
            if (checkList.length == 0) {
              check = false;
            } else {
              check = true;
            }
            return Consumer<TvDetailProvider>(builder: (context, value, child) {
              return SafeArea(
                  child: Stack(
                children: [
                  snapshot.data!.posterPath.isEmpty
                      ? Center(
                          child: Container(
                              margin: EdgeInsets.only(bottom: 100.0),
                              child: FaIcon(
                                FontAwesomeIcons.solidImage,
                                color: Colors.white,
                                size: 50.0,
                              )))
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            color: Colors.grey[400],
                            image: DecorationImage(
                                image: NetworkImage(
                                  "https://image.tmdb.org/t/p/original/${snapshot.data!.posterPath}",
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.9),
                              Colors.black.withOpacity(0.2)
                            ],
                            stops: [
                              0.0,
                              0.5
                            ])),
                  ),
                  Positioned(
                    top: 20.0,
                    left: 10.0,
                    child: Container(
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.arrowLeft,
                            color: Colors.white,
                            size: 20.0,
                          )),
                    ),
                  ),
                  Positioned(
                      top: 20.0,
                      right: 10.0,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            color: Colors.black45),
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.yellow,
                              size: 18.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            snapshot.data!.voteAverage.toString().isEmpty
                                ? Text(
                                    '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    snapshot.data!.voteAverage.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ],
                        ),
                      )),
                  Positioned(
                    bottom: 50.0,
                    left: 10.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          snapshot.data!.name.isEmpty
                              ? Text(
                                  '',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                )
                              : Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        snapshot.data!.name,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      child: IconButton(
                                        onPressed: () async {
                                          List list = user.userTv!
                                              .where((element) =>
                                                  element['userTvId'] ==
                                                  snapshot.data!.id)
                                              .toList();
                                          bool isExist;
                                          if (list.length == 0) {
                                            isExist = false;
                                          } else {
                                            isExist = true;
                                          }
                                          if (isExist) {
                                            user.userTv!.removeWhere(
                                                (element) =>
                                                    element['userTvId'] ==
                                                    snapshot.data!.id);
                                          } else {
                                            user.userTv!.add({
                                              'userTvId': snapshot.data!.id,
                                              'userTvUrl':
                                                  snapshot.data!.posterPath
                                            });
                                          }
                                          await DbRepo().saveUser(UserModel(
                                            id: user.id,
                                            email: user.email,
                                            name: user.name,
                                            userMovie: user.userMovie!,
                                            userTv: user.userTv,
                                          ));
                                          print(user.userMovie);
                                          setState(() {
                                            check = !check;
                                          });
                                        },
                                        icon: check
                                            ? Icon(
                                                Icons.favorite,
                                                color: Colors.white,
                                                size: 20.0,
                                              )
                                            : Icon(
                                                Icons.favorite_border_outlined,
                                                size: 20.0,
                                              ),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 10.0,
                          ),
                          snapshot.data!.overView.isEmpty
                              ? FaIcon(
                                  FontAwesomeIcons.solidMehBlank,
                                  color: Colors.white,
                                )
                              : Text(
                                  snapshot.data!.overView,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 15,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                    size: 14.0,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  snapshot.data!.firstAirDate.isEmpty
                                      ? Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          '${snapshot.data!.firstAirDate} ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ],
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    color: Colors.white,
                                    size: 14.0,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  snapshot.data!.lastAirDate.isEmpty
                                      ? Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          '${snapshot.data!.lastAirDate} ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ],
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.tv,
                                    color: Colors.white,
                                    size: 12.0,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  snapshot.data!.networks.isEmpty
                                      ? Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          snapshot.data!.networks[0].name
                                                      .length >
                                                  10
                                              ? '${snapshot.data!.networks[0].name.substring(0, 10)}...'
                                              : '${snapshot.data!.networks[0].name}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                  // IconButton(
                                  //   onPressed: () async {
                                  //     List list = user.userTv!
                                  //         .where((element) =>
                                  //             element['userTvId'] ==
                                  //             snapshot.data!.id)
                                  //         .toList();
                                  //     bool isExist;
                                  //     if (list.length == 0) {
                                  //       isExist = false;
                                  //     } else {
                                  //       isExist = true;
                                  //     }
                                  //     if (isExist) {
                                  //       user.userTv!.removeWhere((element) =>
                                  //           element['userTvId'] ==
                                  //           snapshot.data!.id);
                                  //     } else {
                                  //       user.userTv!.add({
                                  //         'userTvId': snapshot.data!.id,
                                  //         'userTvUrl': snapshot.data!.posterPath
                                  //       });
                                  //     }
                                  //     await DbRepo().saveUser(UserModel(
                                  //       id: user.id,
                                  //       email: user.email,
                                  //       name: user.name,
                                  //       userMovie: user.userMovie!,
                                  //       userTv: user.userTv,
                                  //     ));
                                  //     print(user.userMovie);
                                  //     setState(() {
                                  //       check = !check;
                                  //     });
                                  //   },
                                  //   icon: check
                                  //       ? Icon(
                                  //           Icons.favorite,
                                  //           color: Colors.white,
                                  //           size: 20.0,
                                  //         )
                                  //       : Icon(
                                  //           Icons.favorite_border_outlined,
                                  //           size: 20.0,
                                  //         ),
                                  //   color: Colors.white,
                                  // ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  TvVideoWidget(tvData: snapshot.data!),
                ],
              ));
            });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
