import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_instagram/models/post_model.dart';
import 'package:flutter_instagram/views/appbar_widget.dart';
import 'package:flutter_instagram/views/feed_widget.dart';

class FeedPage extends StatefulWidget {
  static const String id = "feed_page";
  PageController? pageController;

  FeedPage({this.pageController, Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  List<Post> items = [];
  
  @override
  void initState() {
    super.initState();
    items.addAll([
      Post(uid: "uid", id: "id", postImage: "https://firebasestorage.googleapis.com/v0/b/koreanguideway.appspot.com/o/develop%2Fpost.png?alt=media&token=f0b1ba56-4bf4-4df2-9f43-6b8665cdc964", caption: "Discover more great images on our sponsor's site", createdDate: DateTime.now().toString(), isLiked: false, isMine: true, fullName: "User"),
      Post(uid: "uid", id: "id", postImage: "https://firebasestorage.googleapis.com/v0/b/koreanguideway.appspot.com/o/develop%2Fpost2.png?alt=media&token=ac0c131a-4e9e-40c0-a75a-88e586b28b72", caption: "Discover more great images on our sponsor's site", createdDate: DateTime.now().toString(), isLiked: false, isMine: true, fullName: "User")
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          title: "Instagram",
          icon: Icon(Icons.camera_alt, color: Colors.black,),
          onPressed: () {
            widget.pageController!.jumpToPage(2);
          }),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => FeedWidget(post: items[index]),
      ),
    );
  }
}
