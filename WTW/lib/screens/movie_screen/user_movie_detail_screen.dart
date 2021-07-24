import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wtw/models/movie_model/movie_detail_model.dart';
import 'package:wtw/models/user_model.dart';
import 'package:wtw/providers/movie_provider/movie_detail_provider.dart';
import 'package:wtw/repository/db_repo.dart';
import 'package:wtw/widgets/movie_widget/movie_video_widget.dart';

class UserMovieDetailScreen extends StatefulWidget {
  final int userMovieId;

  UserMovieDetailScreen({required this.userMovieId});

  @override
  _UserMovieDetailScreenState createState() =>
      _UserMovieDetailScreenState(this.userMovieId);
}

class _UserMovieDetailScreenState extends State<UserMovieDetailScreen> {
  int userMovieId;
  _UserMovieDetailScreenState(this.userMovieId);

  late MovieDetailProvider _movieDetailProvider;
  @override
  void initState() {
    this._movieDetailProvider = Provider.of<MovieDetailProvider>(
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
        future: this._movieDetailProvider.movies(this.userMovieId),
        builder:
            (BuildContext context, AsyncSnapshot<MovieDetailModel> snapshot) {
          if (snapshot.hasData) {
            List checkList = user.userMovie!
                .where((element) => element['userMovieId'] == snapshot.data!.id)
                .toList();
            bool check;
            if (checkList.length == 0) {
              check = false;
            } else {
              check = true;
            }
            return Consumer<MovieDetailProvider>(
                builder: (context, value, child) {
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
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            color: Colors.grey[400],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    "https://image.tmdb.org/t/p/original/${snapshot.data!.posterPath}"),
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
                            size: 25.0,
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
                              size: 15.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            snapshot.data!.voteAverage.toString().isEmpty
                                ? Text(
                                    '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    snapshot.data!.voteAverage.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
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
                          snapshot.data!.title.isEmpty
                              ? Text(
                                  '',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                )
                              : Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        snapshot.data!.title.length > 20
                                            ? '${snapshot.data!.title.substring(0, 20)}...'
                                            : '${snapshot.data!.title}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      child: IconButton(
                                        onPressed: () async {
                                          List list = user.userMovie!
                                              .where((element) =>
                                                  element['userMovieId'] ==
                                                  snapshot.data!.id)
                                              .toList();
                                          bool isExist;
                                          if (list.length == 0) {
                                            isExist = false;
                                          } else {
                                            isExist = true;
                                          }
                                          if (isExist) {
                                            user.userMovie!.removeWhere(
                                                (element) =>
                                                    element['userMovieId'] ==
                                                    snapshot.data!.id);
                                          } else {
                                            user.userMovie!.add({
                                              'userMovieId': snapshot.data!.id,
                                              'userMovieUrl':
                                                  snapshot.data!.posterPath
                                            });
                                          }
                                          await DbRepo().saveUser(UserModel(
                                            id: user.id,
                                            email: user.email,
                                            name: user.name,
                                            userMovie: user.userMovie!,
                                            userTv: user.userTv!,
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
                                                size: 24.0,
                                              )
                                            : Icon(
                                                Icons.favorite_border_outlined,
                                                size: 24.0,
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
                                    fontSize: 10.0,
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
                                    Icons.timer,
                                    color: Colors.white,
                                    size: 16.0,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  snapshot.data!.runtime.toString().isEmpty
                                      ? Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          '${snapshot.data!.runtime.toString()} min',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0,
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
                                  snapshot.data!.releaseDate.isEmpty
                                      ? Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          '${snapshot.data!.releaseDate} ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  MovieVideoWidget(movieData: snapshot.data!),
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
