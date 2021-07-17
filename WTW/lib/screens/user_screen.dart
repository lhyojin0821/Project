import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtw/models/movie_model/movie_detail_model.dart';
import 'package:wtw/models/user_model.dart';
import 'package:wtw/providers/auth_provider.dart';
import 'package:wtw/providers/movie_provider/movie_detail_provider.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Color subColor = Color(0xff141414);
  Color mainColor = Color(0xffe50815);
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
                  style: TextStyle(color: Colors.white),
                ),
              ),
              subtitle: Container(
                child: Text(
                  user.email,
                  style: TextStyle(color: Colors.white),
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
                            title: Text('Logout'),
                            content: Text('Are you sure you want to logout?'),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    await loginProvider.logout();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Logout')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'))
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
          userMovie(user),
        ],
      ),
    );
  }

  Widget userMovie(UserModel user) {
    return FutureBuilder(
      future: this._movieDetailProvider.movies(user.userMovieId![1]),
      builder:
          (BuildContext context, AsyncSnapshot<MovieDetailModel> snapshot) {
        if (snapshot.hasData) {
          print(user.userMovieId);
          return Consumer<MovieDetailProvider>(
              builder: (context, value, child) {
            return Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: GridView.count(
                    childAspectRatio: 2 / 3,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    crossAxisCount: 3,
                    children: List.generate(
                      user.userMovieId!.length,
                      (index) => ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                'https://image.tmdb.org/t/p/original/${snapshot.data!.posterPath}',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}