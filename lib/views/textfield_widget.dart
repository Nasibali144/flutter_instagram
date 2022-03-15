import 'package:flutter/material.dart';

ClipRRect textField({required String hintText, bool? isHidden, required TextEditingController controller})  {
  return ClipRRect(
    borderRadius: BorderRadius.circular(7.5),
    child: TextField(
      style: const TextStyle(fontSize: 16, color: Colors.white),
      controller: controller,
      obscureText: isHidden ?? false,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.white54.withOpacity(0.2),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white54)
      ),
    ),
  );
}