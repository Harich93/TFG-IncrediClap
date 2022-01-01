import 'package:flutter/material.dart';

class InputDecorations {

  static InputDecoration authInput({
    required String hintText,
    required String labelText,
    IconData? prefixIcon
  }) {
    return InputDecoration(
      enabledBorder:const UnderlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(185, 226, 140, 1),),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(185, 226, 140, 1),
          width: 2  
        ),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.grey
      ),
      prefixIcon: prefixIcon != null 
        ? Icon( prefixIcon, color: const Color.fromRGBO(185, 226, 140, 1),)
        : null 
    );
  }

}