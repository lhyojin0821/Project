import 'package:flutter/material.dart';
import 'package:tms/screens/movie_screens/movie_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KakaoLogin extends StatefulWidget {
  @override
  _KakaoLoginState createState() => _KakaoLoginState();
}

class _KakaoLoginState extends State<KakaoLogin> {
  late String key = '2494f3a15ff25809d37ac8ebb915cea6';
  late String rUrl = 'http://192.168.0.15:3000/kakaoLogin';
  late String url =
      'https://kauth.kakao.com/oauth/authorize?client_id=$key&redirect_uri=$rUrl&response_type=code';
  // 'https://kauth.kakao.com/oauth/authorize?client_id=2494f3a15ff25809d37ac8ebb915cea6&redirect_uri=http://172.30.1.30:3000/kakaoLogin&response_type=code'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: WebView(
          initialUrl: this.url,
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: {
            JavascriptChannel(
                name: 'tms',
                onMessageReceived: (JavascriptMessage msg) {
                  if (msg.message == '1') {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return MovieScreen();
                    }));
                  }
                }),
          },
        ),
      ),
    ));
  }
}
