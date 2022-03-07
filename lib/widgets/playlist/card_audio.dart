
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:incredibclap/themes/colors.dart';

class CardAudio extends StatelessWidget {

  const CardAudio({
    Key? key,
    required this.buttonColor,
    required this.buttonIcon,
    required this.title,
    required this.onPressed,
    // required this.image
  }) : super(key: key);
  
  final Color buttonColor;
  final IconData buttonIcon;
  final String title;
  final Function onPressed;
  // final AssetImage image; 



  @override
  Widget build(BuildContext context) {
           
    return GestureDetector(
      onTap: () => onPressed(),
      child: FadeIn(
        duration: const Duration(milliseconds: 500),
        child: _CardBackground( 
          // image: image,
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
              
              const SizedBox( width: 20 ),
      
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: FadeInRight(
                  duration: const Duration(milliseconds: 800),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [ 
                
                      const Text(
                        "Pista 1", 
                        style: TextStyle( 
                          color: ThemeColors.dark, 
                          fontSize: 40, 
                          fontFamily: 'Amadeus'
                        )
                      ),
                
                      Text(
                        "Sara", 
                        style: TextStyle( 
                          color: buttonColor, 
                          fontSize: 40, 
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

  const _CardBackground( { required this.child } );

  final Widget child;
  // final AssetImage image; 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Container(
        width: 280,
        height: 110,
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   alignment: Alignment.centerRight,
          //   fit: BoxFit.cover,
          //   image: image
          // ),
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
      ),
    );
  }
}