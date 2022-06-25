import 'package:flutter/material.dart';
import 'package:incredibclap/themes/colors.dart';
import 'package:incredibclap/themes/themes.dart';

class InputDecorations {

  static InputDecoration authInput({
    required String hintText,
    required String labelText,
    required Color color,
    IconData? prefixIcon
  }) {
    return InputDecoration(
      enabledBorder:const UnderlineInputBorder(
        borderSide: BorderSide(color: ThemeColors.primary),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 2  
        ),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.grey
      ),
      prefixIcon: prefixIcon != null 
        ? Icon( prefixIcon, color: color)
        : null 
    );
  }

}