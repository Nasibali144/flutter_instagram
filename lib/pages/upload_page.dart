import 'package:flutter/material.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);
  static const String id = "upload_page";

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("UploadPage"),
      ),
    );
  }
}
