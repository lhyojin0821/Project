import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wtw/screens/login/wrapper.dart';

class GuestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff141414),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.images,
              color: Colors.white,
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              height: 40.0,
              margin: EdgeInsets.only(top: 20.0),
              width: MediaQuery.of(context).size.width * 0.3,
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) {
                    return Wrapper();
                  }));
                },
                child: Text(
                  '로그인',
                  style: TextStyle(color: Colors.white),
                ),
                color: Color(0xffe50815),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              child: Text(
                '로그인이 필요한 페이지 입니다.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
