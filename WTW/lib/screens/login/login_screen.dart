import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtw/providers/auth_provider.dart';
import 'package:wtw/screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  final Function? toggleScreen;
  const LoginScreen({Key? key, this.toggleScreen}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color subColor = Color(0xff141414);
  Color mainColor = Color(0xffe50815);
  FocusNode idNode = new FocusNode();
  FocusNode pwNode = new FocusNode();
  late TextEditingController idCt;
  late TextEditingController pwCt;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    this.idCt = new TextEditingController();
    this.pwCt = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    this.idCt.dispose();
    this.pwCt.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthProvider>(context);
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: this.subColor,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: this._formKey,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Text(
                      "WTW",
                      style: TextStyle(
                          color: this.mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0),
                    )),
                    Container(
                        margin: EdgeInsets.only(bottom: 50.0),
                        child: Text(
                          "What To Watch",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 8.0),
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: 8.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        controller: this.idCt,
                        focusNode: this.idNode,
                        validator: (val) =>
                            val!.isNotEmpty ? null : '정확한 이메일 주소를 입력 하세요.',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(fontSize: 8.0),
                          prefixIcon: Icon(Icons.email, color: Colors.white38),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                              borderRadius: BorderRadius.circular(15.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                              borderRadius: BorderRadius.circular(15.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15.0)),
                          labelText: "E-Mail",
                          hintStyle: TextStyle(
                              fontSize: 8.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                          labelStyle: TextStyle(
                              fontSize: 8.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                        autocorrect: false,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: 8.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        controller: this.pwCt,
                        focusNode: this.pwNode,
                        validator: (val) =>
                            val!.length < 6 ? '비밀번호는 6자 이상이여야 합니다.' : null,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(fontSize: 8.0),
                          fillColor: Colors.black,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white38,
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                              borderRadius: BorderRadius.circular(15.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                              borderRadius: BorderRadius.circular(15.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15.0)),
                          labelText: "Password",
                          hintStyle: TextStyle(
                              fontSize: 8.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                          labelStyle: TextStyle(
                              fontSize: 8.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                        autocorrect: false,
                        obscureText: true,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 35.0,
                          margin: EdgeInsets.only(top: 20.0),
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: MaterialButton(
                              color: Color(0xffe50815),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              onPressed: () async {
                                if (this._formKey.currentState!.validate()) {
                                  print('email : ${this.idCt.text}');
                                  print('password : ${this.pwCt.text}');
                                  await loginProvider.login(
                                      this.idCt.text.trim(),
                                      this.pwCt.text.trim());
                                }
                              },
                              child: loginProvider.isLoading
                                  ? Container(
                                      width: 30.0,
                                      height: 30.0,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ))
                                  : Text("로그인",
                                      style: new TextStyle(
                                          fontSize: 8.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          height: 35.0,
                          margin: EdgeInsets.only(top: 20.0),
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: MaterialButton(
                              color: Colors.grey[600],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              onPressed: () async {
                                await Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                  return MainScreen();
                                }));
                              },
                              child: Text("둘러보기",
                                  style: new TextStyle(
                                      fontSize: 8.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                        ),
                      ],
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "WTW 회원이 아니신가요?",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 8.0),
                            ),
                          ),
                          Container(
                            child: TextButton(
                              onPressed: () => widget.toggleScreen!(),
                              child: Text(
                                '회원가입',
                                style: TextStyle(fontSize: 9.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    if (loginProvider.errorMessage != null)
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: Colors.amberAccent,
                        child: ListTile(
                          title: Text(loginProvider.errorMessage!),
                          leading: Icon(Icons.error),
                          trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => loginProvider.setMessage(null),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
