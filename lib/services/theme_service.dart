import 'package:flutter/material.dart';

class ThemeService {
  // #colors
  static const Color colorOne = Color(0xFF833AB4);
  static const Color colorTwo = Color(0xFFC13584);

  // #fonts
  static const String fontHeader = "Billabong";

  // #font_size
  static const double fontHeaderSize = 30;

  // #style
  static const TextStyle appBarStyle = TextStyle(color: Colors.black, fontFamily: fontHeader, fontSize: fontHeaderSize);

  static BoxDecoration backgroundGradient = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [colorTwo, colorOne,],
    ),
  );
}