import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBar extends StatelessWidget with PreferredSizeWidget{
  const CustomBar({
    Key? key, 
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.acme(
          fontSize: 25,
          color: Colors.black
        )
        
      ),
    );
  }
}