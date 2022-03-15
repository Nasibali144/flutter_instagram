import 'package:flutter/material.dart';

MaterialButton button({required String title, required void Function() onPressed}) {
  return MaterialButton(
    onPressed: onPressed,
    height: 50,
    minWidth: double.infinity,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7.5),
      side:  BorderSide(color: Colors.white54.withOpacity(0.2), width: 2),
    ),
    child: Text(title, style: TextStyle(fontSize: 16, color: Colors.white,),),
  );
}