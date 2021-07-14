import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future register(String email, String password) async {
    try {
      UserCredential authResult = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = authResult.user!;
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
  }

  void setLoading(val) {
    this._isLoading = val;
    notifyListeners();
  }

  void setMessage(message) {
    this._errorMessage = message;
    notifyListeners();
  }

  Stream<User> get user =>
      firebaseAuth.authStateChanges().map((event) => event!);
}
