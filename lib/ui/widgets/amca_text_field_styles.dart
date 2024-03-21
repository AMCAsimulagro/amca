/// {@category Styles}
/// This file contains the `AmcaTextFieldStyles` class, which provides
/// custom styles for text fields in the Amca application.
///


import 'package:flutter/material.dart';

/// Estilos predefinidos para los campos de texto en la aplicación Amca.
class AmcaTextFieldStyles {
  /// Decoración predeterminada para los campos de texto.
  static const textFieldDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
      ),
    ),
    labelStyle: TextStyle(
      color: Colors.black54,
    ),
  );
}
