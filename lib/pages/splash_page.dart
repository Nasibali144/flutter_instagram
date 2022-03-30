import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/pages/home_page.dart';
import 'package:flutter_instagram/pages/signin_page.dart';
import 'package:flutter_instagram/services/pref_service.dart';
import 'package:flutter_instagram/services/theme_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const String id = "splash_page";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Widget _starterPage() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          Prefs.store(StorageKeys.UID, snapshot.data!.uid);
          return HomePage();
        } else {
          Prefs.remove(StorageKeys.UID);
          return SignInPage();
        }
      },
    );
  }

  void _openSignInPage() => Timer(const Duration(seconds: 2), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => _starterPage())));

  _initNotification() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await _firebaseMessaging.getToken().then((token) {
      if (kDebugMode) {
        print(token);
      }
      Prefs.store(StorageKeys.TOKEN, token!);
    });
  }

  @override
  void initState() {
    super.initState();
    _openSignInPage();
    _initNotification();
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
