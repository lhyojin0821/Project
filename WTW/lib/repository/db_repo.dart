import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wtw/models/user_model.dart';

class DbRepo {
  final CollectionReference userCol =
      FirebaseFirestore.instance.collection("users");
  Future saveUser(UserModel user) async {
    try {
      await userCol.doc(user.id).set(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel> getUser(String id) async {
    final dynamic data = await userCol.doc(id).get();
    final user = UserModel.fromJson(data.data());
    return user;
  }
}
