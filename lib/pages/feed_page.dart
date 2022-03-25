import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_instagram/models/post_model.dart';
import 'package:flutter_instagram/services/data_service.dart';
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
  bool isLoading = true;
  List<Post> items = [];
  
  @override
  void initState() {
    super.initState();
    _apiLoadFeeds();
  }

  void _apiLoadFeeds() async {
    setState(() {
      isLoading = true;
    });

    DataService.loadFeeds().then((posts) => {
      _resLoadFeeds(posts)
    });
  }

  void _resLoadFeeds(List<Post> posts) {
    setState(() {
      isLoading = false;
      items = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          title: "Instagram",
          icon: const Icon(Icons.camera_alt, color: Colors.black,),
          onPressed: () {
            widget.pageController!.jumpToPage(2);
          }),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => FeedWidget(post: items[index]),
          ),

          if(isLoading) const Center(
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}
