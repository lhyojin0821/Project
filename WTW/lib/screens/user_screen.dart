import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtw/models/user_model.dart';
import 'package:wtw/providers/auth_provider.dart';
import 'package:wtw/providers/movie_provider/movie_detail_provider.dart';
import 'package:wtw/providers/movie_provider/movie_video_provider.dart';
import 'package:wtw/providers/tv_provider/tv_detail_provider.dart';
import 'package:wtw/providers/tv_provider/tv_video_provider.dart';
import 'package:wtw/screens/login/wrapper.dart';
import 'package:wtw/screens/movie_screen/user_movie_detail_screen.dart';
import 'package:wtw/screens/tv_screen/user_tv_detail_screen.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Color subColor = Color(0xff141414);
  Color mainColor = Color(0xffe50815);
  late AuthProvider _userProvider;

  @override
  void initState() {
    this._userProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthProvider>(context);
    final user = UserModel.current;
    return Container(
      color: this.subColor,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              leading: Container(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              title: Container(
                child: Text(
                  user.name,
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              ),
              subtitle: Container(
                child: Text(
                  user.email,
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              ),
              trailing: Container(
                child: IconButton(
                  icon: Icon(
                    Icons.power_settings_new_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              '로그아웃',
                              style: TextStyle(fontSize: 12.0),
                            ),
                            content: Text(
                              '로그아웃 하시겠습니까?',
                              style: TextStyle(fontSize: 10.0),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    await loginProvider.logout();
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return Wrapper();
                                    }));
                                  },
                                  child: Text(
                                    '로그아웃',
                                    style: TextStyle(fontSize: 10.0),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    '취소',
                                    style: TextStyle(fontSize: 10.0),
                                  ))
                            ],
                          );
                        });
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        '찜한 콘텐츠 목록',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    user.userMovie!.isEmpty ? Container() : userMovie(),
                    SizedBox(
                      height: 10.0,
                    ),
                    // userMovie(user),
                    user.userTv!.isEmpty ? Container() : userTv(),
                  ],
                ),
              ),
            ),
          )

          // userMovie(user),
        ],
      ),
    );
  }

  Widget userMovie() {
    return FutureBuilder(
        future: this._userProvider.getUser(),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData) {
            return Consumer<AuthProvider>(builder: (context, value, child) {
              return Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 10.0,
                          top: 20.0,
                          bottom: 10.0,
                        ),
                        child: Text(
                          'MOVIE',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            snapshot.data!.userMovie!.length,
                            (index) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return MultiProvider(
                                    providers: [
                                      ChangeNotifierProvider(
                                          create: (BuildContext context) =>
                                              MovieDetailProvider()),
                                      ChangeNotifierProvider(
                                          create: (BuildContext context) =>
                                              MovieVideoProvider()),
                                    ],
                                    child: UserMovieDetailScreen(
                                        userMovieId: snapshot.data!
                                            .userMovie![index]['userMovieId']),
                                  );
                                }));
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                width: 150,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/original/${snapshot.data!.userMovie![index]['userMovieUrl']}',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget userTv() {
    return FutureBuilder(
        future: this._userProvider.getUser(),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData) {
            return Consumer<AuthProvider>(builder: (context, value, child) {
              return Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 10.0,
                          top: 20.0,
                          bottom: 10.0,
                        ),
                        child: Text(
                          'TV',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            snapshot.data!.userTv!.length,
                            (index) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return MultiProvider(
                                      providers: [
                                        ChangeNotifierProvider(
                                            create: (BuildContext context) =>
                                                TvDetailProvider()),
                                        ChangeNotifierProvider(
                                            create: (BuildContext context) =>
                                                TvVideoProvider()),
                                      ],
                                      child: UserTvDetailScreen(
                                          userTvId: snapshot.data!
                                              .userTv![index]['userTvId']));
                                }));
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                width: 150,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/original/${snapshot.data!.userTv![index]['userTvUrl']}',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
