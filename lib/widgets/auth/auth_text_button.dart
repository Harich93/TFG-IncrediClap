import 'package:flutter/material.dart';

class TextButtonAuth extends StatelessWidget {
  const TextButtonAuth({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(
              const Color.fromRGBO(185, 226, 140, 0.3)),
          shape: MaterialStateProperty.all(const StadiumBorder())),
      child: Text(text,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Colors.black87)),
    );
  }
}
