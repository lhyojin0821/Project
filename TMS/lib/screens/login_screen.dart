import 'package:flutter/material.dart';
import 'package:tms/screens/movie_screens/movie_screen.dart';
import 'package:tms/widgets/login/kakao.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode idNode = new FocusNode();
  FocusNode pwNode = new FocusNode();
  TextEditingController idCt = new TextEditingController();
  TextEditingController pwCt = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
    this.idCt.dispose();
    this.pwCt.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 80.0),
          child: Form(
            child: Column(
              children: [
                Container(
                    height: 200.0,
                    padding: EdgeInsets.only(bottom: 20.0, top: 45.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TMS",
                          style: TextStyle(
                              color: Color(0xffe50815),
                              fontWeight: FontWeight.bold,
                              fontSize: 35.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  controller: this.idCt,
                  focusNode: this.idNode,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.white38),
                    enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white70),
                        borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30.0)),
                    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                    labelText: "E-Mail",
                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  autocorrect: false,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  controller: this.pwCt,
                  focusNode: this.pwNode,
                  decoration: InputDecoration(
                    fillColor: Colors.black,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.white38,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white70),
                        borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30.0)),
                    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                    labelText: "Password",
                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  autocorrect: false,
                  obscureText: true,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: new InkWell(
                      child: new Text(
                        "Forget password?",
                        style: TextStyle(color: Colors.white54, fontSize: 12.0),
                      ),
                      onTap: () {}),
                ),
                Container(
                  padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xffe50815),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )),
                            onPressed: () {},
                            child: Text("LOG IN",
                                style: new TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: 30.0,
                      ),
                      child: Text(
                        "Or connect using",
                        style: TextStyle(color: Colors.white54, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 20.0,
                // ),
                Container(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40.0,
                        width: 90.0,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xfffae100),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                )),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return KakaoLogin();
                              }));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text("Kakao",
                                    style: new TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            )),
                      ),
                      Container(
                        width: 90.0,
                        height: 40.0,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFFf14436),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                )),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text("Google",
                                    style: new TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            )),
                      ),
                      Container(
                        width: 90.0,
                        height: 40.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              )),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 5.0,
                              ),
                              Text("Naver",
                                  style: new TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 90.0,
                        height: 40.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              )),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return MovieScreen();
                            }));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 5.0,
                              ),
                              Text("Guest",
                                  style: new TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        padding: EdgeInsets.only(bottom: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Don't have an account?",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 5.0),
                            ),
                            GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
