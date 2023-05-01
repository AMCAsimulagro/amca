import 'package:flutter/material.dart';

class AmcaTextFieldStyles{
  static const textFieldDecoration = InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          )
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          )
      ),
      labelStyle: TextStyle(
          color: Colors.black54
      )
  );
}