import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_instagram/models/user_model.dart';
import 'package:flutter_instagram/services/pref_service.dart';

class DataService {
  // init
  static final instance = FirebaseFirestore.instance;

  // folder
  static const String userFolder = "users";

  // User
  static Future<void> storeUser(User user) async {
    user.uid = (await Prefs.load(StorageKeys.UID))!;
    return instance.collection(userFolder).doc(user.uid).set(user.toJson());
  }

  static Future<User> loadUser() async {
    String uid = (await Prefs.load(StorageKeys.UID))!;
    var value = await instance.collection(userFolder).doc(uid).get();
    return User.fromJson(value.data()!);
  }

  static Future<void> updateUser(User user) async {
    // String uid = (await Prefs.load(StorageKeys.UID))!;
    return instance.collection(userFolder).doc(user.uid).update(user.toJson());
  }

  static Future<List<User>> searchUsers(String keyword) async {
    User user = await loadUser();
    List<User> users = [];
    // write request
    var querySnapshot = await instance.collection(userFolder).orderBy("fullName").startAt([keyword]).endAt([keyword + '\uf8ff']).get();
    if (kDebugMode) {
      print(querySnapshot.docs.toString());
    }

    for (var element in querySnapshot.docs) {
      users.add(User.fromJson(element.data()));
    }

    users.remove(user);
    return users;
  }
}