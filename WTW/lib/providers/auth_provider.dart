import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wtw/models/user_model.dart';
import 'package:wtw/repository/db_repo.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future register(
    String email,
    String password,
    String name,
  ) async {
    setLoading(true);
    try {
      UserCredential authResult =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = authResult.user!;
      setLoading(false);
      await DbRepo().saveUser(UserModel(
        id: user.uid,
        email: email,
        name: name,
        userMovie: [],
      ));
      return user;
    } on SocketException {
      setMessage('No inter, please connect to internet');
    } catch (e) {
      setLoading(false);
      if (e.hashCode == 34618382) setMessage('이미 사용 중 인 계정 입니다.');
      if (e.hashCode == 360587416) setMessage('이메일 주소의 형식이 잘못되었습니다.');
      print(e.toString());
      print(e.hashCode);
    }
    notifyListeners();
  }

  Future login(String email, String password) async {
    setLoading(true);
    try {
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException {
      setMessage('No internet, please connect to internet');
    } catch (e) {
      setLoading(false);
      if (e.hashCode == 185768934 || e.hashCode == 140382746)
        setMessage('비밀번호가 잘못되었습니다.');
      if (e.hashCode == 505284406) setMessage('이 이메일 주소를 사용하는 계정을 찾을 수 없습니다.');
    }
    notifyListeners();
  }

  Future logout() async {
    await firebaseAuth.signOut();
    notifyListeners();
  }

  void setLoading(val) {
    this._isLoading = val;
    notifyListeners();
  }

  void setMessage(message) {
    this._errorMessage = message;
    notifyListeners();
  }

  Future<UserModel> getUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final user = FirebaseAuth.instance.currentUser;
      final userResult = await DbRepo().getUser(user!.uid);
      UserModel.current = userResult;
      notifyListeners();
      return UserModel.current;
    } else {
      return UserModel.fromJson({});
    }
  }

  Stream<User>? get user =>
      firebaseAuth.authStateChanges().map((event) => event!);
}
