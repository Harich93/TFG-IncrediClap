
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:incredibclap/themes/colors.dart';

class CardAudio extends StatelessWidget {

  const CardAudio({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.userName,
  }) : super(key: key);
  
  final String title;
  final String userName;
  final Function onPressed;



  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
           
    return GestureDetector(
      onTap: () => onPressed(),
      child: FadeIn(
        duration: const Duration(milliseconds: 500),
        child: _CardBackground( 
          size: size,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
      
              SizedBox(
                width: 130,
                child: FadeInLeft(
                  duration: const Duration(milliseconds: 800),
                  child: const Image(
                    image: AssetImage('assets/backgrounds/backMusic1.jpg'),
                    alignment: Alignment.centerRight,  
                  ),
                ),
              ),
              
              SizedBox(width: size.width*.02),
      
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: FadeInRight(
                  duration: const Duration(milliseconds: 800),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [ 
                
                      Text(
                        title, 
                        style: const TextStyle( 
                          color: ThemeColors.dark, 
                          fontSize: 35, 
                          fontFamily: 'Amadeus'
                        )
                      ),
                
                      Text(
                        userName,
                        style: const TextStyle( 
                          color: ThemeColors.primary, 
                          fontSize: 25, 
                          fontFamily: 'Amadeus'
                        )
                      ),
                    ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}




class _CardBackground extends StatelessWidget {

  const _CardBackground( { required this.child, required this.size } );

  final Widget child;
  final Size size;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      height: size.height*.133,
      decoration: BoxDecoration(

        boxShadow: const [
          BoxShadow(
            spreadRadius: 1,
            color: Colors.black26,
            offset: Offset(0,0),
            blurRadius: 2
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(5) 
      ),
      child: child,
    );
  }
}