import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incredibclap/screens/screens.dart';

class IntroScreen extends StatefulWidget {

  static const String routeName = 'Intro';

  const IntroScreen({Key? key}) : super(key: key);


  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    
    Timer( const Duration(milliseconds: 2), () => setState(() { visible = true; }));
    
    return Scaffold(
      body: Stack(
        children: [
          _BackgroundIntro(),
          Container(
            color: Colors.transparent,
            child: Center(
              child: AnimatedOpacity(
                opacity: visible ? 1 : 0,
                curve: Curves.fastOutSlowIn,
                duration: const Duration( seconds: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(
                      'IncredibClap',
                      style: GoogleFonts.acme(
                        fontSize: 50,
                        color: Colors.black
                      )
                    ),
                    
                    const SizedBox( height: 10 ),
                        
                     AnimatedPhysicalModel(
                      color: visible ? Colors.black : Colors.transparent,
                      animateShadowColor: true,
                      animateColor: true,
                      curve: Curves.easeInOutCirc,
                      duration: const Duration(seconds: 2),
                      elevation: 20,
                      shape: BoxShape.circle,
                      shadowColor: Colors.black,
                      child: const Image(
                        height: 100,
                        width: 100,
                        image: AssetImage('assets/palmas.png'),
                      ),
                      onEnd: () => Timer( const Duration(milliseconds: 100), () => Navigator.pushReplacementNamed(context, LoginScreen.routeName)),
                    ),
                  ],
                ),
              ),
            
            ),
          ),
        ]
      ),
    );
  }
}

class _BackgroundIntro extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: _builBoxDecoration(),
      child: Stack(
        children: [
          Positioned( child: _Bubble(), top: 90, left: 30,),
          Positioned( child: _Bubble(), top: -40, left: -30,),
          Positioned( child: _Bubble(), top: -50, right: -20,),
          Positioned( child: _Bubble(), bottom: -50, left: 10,),
          Positioned( child: _Bubble(), bottom: 120, right: 30,),
        ],
      ),
    );
  }

  BoxDecoration _builBoxDecoration() => const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromRGBO(185, 226, 140, 1),
        Color.fromRGBO(115, 146, 80, 1),
      ]
    )
  );
}

class _Bubble extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );
  }
}