import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);
  static const String id = "feed_page";

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("FeedPage"),
      ),
    );
  }
}
