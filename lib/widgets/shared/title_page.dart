import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incredibclap/themes/colors.dart';

class TitlePage extends StatelessWidget {

  const TitlePage({
    Key? key,
    this.withIcon = true
  }) : super(key: key);

  final bool withIcon;

  @override
  Widget build(BuildContext context) {

    const durationAnima = Duration(milliseconds: 800);
    
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
          withIcon 
            ? const Icon(Icons.library_music_sharp, size: 100) 
            : const SizedBox(height: 0),
          FadeIn(
            duration: durationAnima,
            child: Center(
              child: Text(
                'IncrediClap',
                style: GoogleFonts.righteous(
                  textStyle: TextStyle(
                    fontSize: withIcon ? 60 : 30,
                    color: ThemeColors.darkPrimary
                  )
                )
              ),
            ),
          ),
          
        ]
      ),
    );
  }
}