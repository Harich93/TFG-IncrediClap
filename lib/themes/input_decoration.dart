import 'package:flutter/material.dart';
import 'package:incrediclap/themes/colors.dart';
import 'package:incrediclap/themes/themes.dart';

class InputDecorations {

  static InputDecoration authInput({
    required String hintText,
    required String labelText,
    IconData? prefixIcon
  }) {
    return InputDecoration(
      enabledBorder:const UnderlineInputBorder(
        borderSide: BorderSide(color: ThemeColors.primary),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: ThemeColors.primary,
          width: 2  
        ),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.grey
      ),
      prefixIcon: prefixIcon != null 
        ? Icon( prefixIcon, color: ThemeColors.primary)
        : null 
    );
  }

}