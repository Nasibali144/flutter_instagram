import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_instagram/models/post_model.dart';
import 'package:flutter_instagram/models/user_model.dart';
import 'package:flutter_instagram/services/pref_service.dart';
import 'package:flutter_instagram/services/utils.dart';

class DataService {
  // init
  static final instance = FirebaseFirestore.instance;

  // folder
  static const String folderUsers = "users";
  static const String folderPosts = "posts";
  static const String folderFeeds = "feeds";

  // User
  static Future<void> storeUser(User user) async {
    user.uid = (await Prefs.load(StorageKeys.UID))!;
    return instance.collection(folderUsers).doc(user.uid).set(user.toJson());
  }

  static Future<User> loadUser() async {
    String uid = (await Prefs.load(StorageKeys.UID))!;
    var value = await instance.collection(folderUsers).doc(uid).get();
    return User.fromJson(value.data()!);
  }

  static Future<void> updateUser(User user) async {
    // String uid = (await Prefs.load(StorageKeys.UID))!;
    return instance.collection(folderUsers).doc(user.uid).update(user.toJson());
  }

  static Future<List<User>> searchUsers(String keyword) async {
    User user = await loadUser();
    List<User> users = [];
    // write request
    var querySnapshot = await instance.collection(folderUsers).orderBy("fullName").startAt([keyword]).endAt([keyword + '\uf8ff']).get();
    if (kDebugMode) {
      print(querySnapshot.docs.toString());
    }

    for (var element in querySnapshot.docs) {
      users.add(User.fromJson(element.data()));
    }

    users.remove(user);
    return users;
  }

  // Post
  static Future<Post> storePost(Post post) async {
    // filled post
    User me = await loadUser();
    post.uid = me.uid;
    post.fullName = me.fullName;
    post.imageUser = me.imageUrl;
    post.createdDate = DateTime.now().toString();

    String postId = instance.collection(folderUsers).doc(me.uid).collection(folderPosts).doc().id;
    post.id = postId;
    await instance.collection(folderUsers).doc(me.uid).collection(folderPosts).doc(postId).set(post.toJson());
    return post;
  }

  static Future<Post> storeFeed(Post post) async {
    await instance.collection(folderUsers).doc(post.uid).collection(folderFeeds).doc(post.id).set(post.toJson());
    return post;
  }

  static Future<List<Post>> loadFeeds() async {
    List<Post> posts = [];
    String uid = (await Prefs.load(StorageKeys.UID))!;
    var querySnapshot = await instance.collection(folderUsers).doc(uid).collection(folderFeeds).get();

    for (var element in querySnapshot.docs) {
      Post post = Post.fromJson(element.data());
      if(post.uid == uid) post.isMine = true;
      posts.add(post);
    }

    return posts;
  }

  static Future<List<Post>> loadPosts() async {
    List<Post> posts = [];
    String uid = (await Prefs.load(StorageKeys.UID))!;
    var querySnapshot = await instance.collection(folderUsers).doc(uid).collection(folderPosts).get();

    for (var element in querySnapshot.docs) {
      posts.add(Post.fromJson(element.data()));
    }

    return posts;
  }
}