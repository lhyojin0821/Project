import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtw/providers/auth_provider.dart';
import 'package:wtw/providers/movie_provider/movie_nowplaying_provider.dart';
import 'package:wtw/providers/tv_provider/tv_popular_provider.dart';
import 'package:wtw/screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _init = Firebase.initializeApp();
    return FutureBuilder(
        future: _init,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Column(
              children: [
                Icon(Icons.error),
                Center(
                  child: Text('something went wrong!'),
                ),
              ],
            );
          } else if (snapshot.hasData) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<AuthProvider>.value(
                  value: AuthProvider(),
                ),
                StreamProvider<User?>.value(
                  value: AuthProvider().user,
                  initialData: null,
                  catchError: (_, err) => null,
                ),
                ChangeNotifierProvider(
                    create: (BuildContext context) =>
                        MovieNowPlayingProvider()),
                ChangeNotifierProvider(
                    create: (BuildContext context) => TvPopularProvider()),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: SplashScreen(),
              ),
            );
          }
          return Container();
        });
  }
}
