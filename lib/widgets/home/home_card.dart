
import 'package:flutter/material.dart';
import 'package:incredibclap/themes/colors.dart';

class HomeCard extends StatelessWidget {

  const HomeCard({
    Key? key,
    required this.buttonColor,
    required this.buttonIcon,
    required this.title,
    required this.image,
    required this.text,
    this.reverse = false,
  }) : super(key: key);
  
  final Color buttonColor;
  final String text;
  final IconData buttonIcon;
  final String title;
  final AssetImage image; 
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _CardBackground(
        reverse: reverse, 
        image: image,
        child: Row(
          mainAxisAlignment: !reverse ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            const SizedBox( width: 20 ),
            SizedBox(
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [ 
                  Text(title, style: TextStyle( color: buttonColor, fontSize: 20, fontFamily: 'Amadeus') ),
                  Text(text, style: TextStyle( color: buttonColor, fontSize: 15) ),
                ]
              ),
            ),
          ],
        ),
        ),
      
    );
  }
}




class _CardBackground extends StatelessWidget {

  const _CardBackground( { required this.child, required this.image, required this.reverse } );

  final Widget child;
  final AssetImage image; 
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Container(
        width: 380,
        height: 90,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: !reverse ? Alignment.centerRight : Alignment.centerLeft,
            image: image,
          ),
          boxShadow: const [
            BoxShadow(
              spreadRadius: 0,
              color: ThemeColors.dark,
              offset: Offset(0,0),
              blurRadius: 5
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(5) 
        ),
        child: child,
      ),
    );
  }
}