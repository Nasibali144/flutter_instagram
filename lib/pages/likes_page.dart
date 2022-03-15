import 'package:flutter/material.dart';

class LikesPage extends StatefulWidget {
  const LikesPage({Key? key}) : super(key: key);
  static const String id = "likes_page";

  @override
  _LikesPageState createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("LikesPage"),
      ),
    );
  }
}
