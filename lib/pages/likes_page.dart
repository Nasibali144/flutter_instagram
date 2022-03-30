import 'package:flutter/material.dart';
import 'package:flutter_instagram/models/post_model.dart';
import 'package:flutter_instagram/services/data_service.dart';
import 'package:flutter_instagram/views/appbar_widget.dart';
import 'package:flutter_instagram/views/feed_widget.dart';

class LikesPage extends StatefulWidget {
  const LikesPage({Key? key}) : super(key: key);
  static const String id = "likes_page";

  @override
  _LikesPageState createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  bool isLoading = true;
  List<Post> items = [];

  @override
  void initState() {
    super.initState();
    _apiLoadLikes();
  }

  void _apiLoadLikes() async {
    setState(() {
      isLoading = true;
    });

    DataService.loadLikes().then((posts) => {
      _resLoadLikes(posts)
    });
  }

  void _resLoadLikes(List<Post> posts) {
    setState(() {
      items = posts;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Likes",),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return FeedWidget(post: items[index], function: _apiLoadLikes, load: _apiLoadLikes,);
            }),

          if(isLoading) const Center(
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}
