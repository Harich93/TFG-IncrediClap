import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:incredibclap/themes/themes.dart';

class HomeCard extends StatelessWidget {

  const HomeCard({
    Key? key,
    required this.buttonColor,
    required this.buttonIcon,
    required this.title,
    required this.onPressed,
    required this.image
  }) : super(key: key);
  
  final Color buttonColor;
  final IconData buttonIcon;
  final String title;
  final Function onPressed;
  final AssetImage image; 



  @override
  Widget build(BuildContext context) {
           
    return GestureDetector(
      onTap: () => onPressed(),
      child: _CardBackground( 
        image: image,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const SizedBox( width: 20 ),

            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [ 
                Text(title, style: TextStyle( color: buttonColor, fontSize: 40, fontFamily: 'Amadeus') )
              ]
            ),
          ],
        ),
        ),
      
    );
  }
}

class _ButtonGradient extends StatelessWidget {
  const _ButtonGradient({
    Key? key,
    required this.color,
    required this.icon,
    required this.onPressed

  }) : super(key: key);

  final Color color;
  final IconData icon;
  final Function onPressed;
  
  @override
  Widget build(BuildContext context) {

    return _BackgroundButton(
      child: IconButton(
        onPressed: () => onPressed(),
        icon: Icon(icon, color: Colors.white),
      ), 
      color: color
    ); 
  }
}

class _BackgroundButton extends StatelessWidget {
  const _BackgroundButton({
    required this.child,
    required this.color
  });

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(50),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          stops: const [ 0.01, 0.5 ],
          colors: [
            Colors.white,
            color
          ],
        )
      ),
      
      child: child
    );
  }
}

class _CardBackground extends StatelessWidget {

  const _CardBackground( { required this.child, required this.image } );

  final Widget child;
  final AssetImage image; 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Container(
        width: 350,
        height: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.centerRight,
            fit: BoxFit.cover,
            image: image
          ),
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              color: Colors.grey[200]!,
              offset: const Offset(1,1),
              blurRadius: 10
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