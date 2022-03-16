import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/pages/feed_page.dart';
import 'package:flutter_instagram/pages/likes_page.dart';
import 'package:flutter_instagram/pages/profile_page.dart';
import 'package:flutter_instagram/pages/search_page.dart';
import 'package:flutter_instagram/pages/upload_page.dart';
import 'package:flutter_instagram/services/theme_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = "home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: const [
          FeedPage(),
          SearchPage(),
          UploadPage(),
          LikesPage(),
          ProfilePage(),
        ],
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: currentPage,
        backgroundColor: Colors.white54,
        activeColor: Colors.purple,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.add_box)),
          BottomNavigationBarItem(icon: Icon(Icons.favorite)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
        ],
        onTap: (index) {
          pageController.jumpToPage(index);
        },
      ),
    );
  }
}