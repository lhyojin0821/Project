import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wtw/screens/main_screen.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Color subColor = Color(0xff141414);
  Color mainColor = Color(0xffe50815);
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
      backgroundColor: this.subColor,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 80.0),
          child: Form(
            child: Column(
              children: [
                Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "WTW",
                      style: TextStyle(
                          color: this.mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0),
                    ),
                  ],
                )),
                Column(
                  children: [
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
                        contentPadding:
                            EdgeInsets.only(left: 10.0, right: 10.0),
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
                      height: 10.0,
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
                        contentPadding:
                            EdgeInsets.only(left: 10.0, right: 10.0),
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
                  ],
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 90.0,
                        height: 40.0,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFFf14436),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                )),
                            onPressed: this.signInWithGoogle,
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
                      SizedBox(
                        width: 10.0,
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
                              return MainScreen();
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
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ElevatedButton(
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
