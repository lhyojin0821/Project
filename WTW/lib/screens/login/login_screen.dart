import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtw/providers/auth_provider.dart';

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
    return Scaffold(
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
                        fontSize: 50.0),
                  )),
                  Container(
                      margin: EdgeInsets.only(bottom: 50.0),
                      child: Text(
                        "What To Watch",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0),
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      controller: this.idCt,
                      focusNode: this.idNode,
                      validator: (val) => val!.isNotEmpty
                          ? null
                          : 'Please enter a email address',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
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
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      controller: this.pwCt,
                      focusNode: this.pwNode,
                      validator: (val) =>
                          val!.length < 6 ? 'Enter more than 6 char' : null,
                      decoration: InputDecoration(
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
                  ),
                  Container(
                    height: 50.0,
                    margin: EdgeInsets.only(top: 20.0),
                    width: MediaQuery.of(context).size.width * 0.8,
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
                                this.idCt.text.trim(), this.pwCt.text.trim());
                          }
                        },
                        child: loginProvider.isLoading
                            ? CircularProgressIndicator()
                            : Text("LOGIN",
                                style: new TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Container(
                          child: TextButton(
                            onPressed: () => widget.toggleScreen!(),
                            child: Text('Register'),
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
    );
  }
}
