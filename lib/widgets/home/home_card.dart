
import 'package:flutter/material.dart';

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




class _CardBackground extends StatelessWidget {

  const _CardBackground( { required this.child, required this.image } );

  final Widget child;
  final AssetImage image; 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Container(
        width: 380,
        height: 170,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.centerRight,
            fit: BoxFit.cover,
            image: image
          ),
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