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
    try {
      UserCredential authResult =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = authResult.user!;
      await DbRepo().saveUser(
          UserModel(id: user.uid, email: email, name: name, userMovieId: []));
      return user;
    } on SocketException {
      setMessage('No inter, please connect to internet');
    } catch (e) {
      setMessage(e.toString());
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
      setMessage(e.toString());
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

  Future<void> getUser() async {
    final user = FirebaseAuth.instance.currentUser;
    final userResult = await DbRepo().getUser(user!.uid);
    UserModel.current = userResult;
    notifyListeners();
    return;
  }

  Stream<User> get user =>
      firebaseAuth.authStateChanges().map((event) => event!);
}
