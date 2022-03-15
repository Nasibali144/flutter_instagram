import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_instagram/pages/signin_page.dart';
import 'package:flutter_instagram/services/theme_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const String id = "splash_page";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  void _openSignInPage() => Timer(const Duration(seconds: 3), () => Navigator.pushReplacementNamed(context, SignInPage.id));

  @override
  void initState() {
    super.initState();
    _openSignInPage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 20, bottom: 40),
        decoration: ThemeService.backgroundGradient,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Expanded(
              child: Center(child: Text("Instagram", style: TextStyle(color: Colors.white, fontSize: 45, fontFamily: ThemeService.fontHeader),)),
            ),
            Text("All rights reserved", style: TextStyle(color: Colors.white, fontSize: 16),),
          ],
        ),
      ),
    );
  }
}
