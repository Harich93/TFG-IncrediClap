import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:incredibclap/themes/themes.dart';

class HomeCard extends StatelessWidget {

  const HomeCard({
    Key? key,
    required this.buttonColor,
    required this.buttonIcon,
    required this.title,
    required this.onPressed
  }) : super(key: key);
  
  final Color buttonColor;
  final IconData buttonIcon;
  final String title;
  final Function onPressed;


  @override
  Widget build(BuildContext context) {
           
    return _CardBackground( 
      child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ButtonGradient( color: buttonColor, icon: buttonIcon, onPressed: onPressed,),
                const SizedBox( height: 20,),
                Text(title, style: TextStyle( color: buttonColor, fontSize: 18),)
              ],
            )
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

  const _CardBackground( { required this.child } );

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter( // Efecto Blur
          filter: ImageFilter.blur( sigmaX: 5, sigmaY: 5 ),
          child: Container(
            width: 220,
            height: 150,
            decoration: BoxDecoration(
              color: ThemeColors.transparent,
              // color: ThemeColors.purple,
              borderRadius: BorderRadius.circular(20) 
            ),
            child: child,
          ),
        ),
      ),
      
    );
  }
}