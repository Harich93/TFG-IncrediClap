import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CardHome extends StatelessWidget {
  const CardHome({
    Key? key, 
    required this.img, 
    required this.text,
    required this.onPressed
  
  }) : super(key: key);

  final String img;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 50),
      child: Center(
        
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(115, 146, 80, 1),
                offset: Offset(5, 8),
                blurRadius: 15
              )
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20) ,
            child: TextButton(
              style: ButtonStyle( 
                backgroundColor: MaterialStateProperty.all( const Color.fromRGBO(185, 226, 140, 1)),
                padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                elevation: MaterialStateProperty.all(10),
              ),
              onPressed: () => onPressed(),
              child: Row(
                children: [
                  
                  const SizedBox( width: 30 ),
                  
                  SizedBox(
                    height: 100,
                    child: Image(
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                      image: AssetImage(img),
                    ),
                  ),
                  
                  const SizedBox( width: 50,),
            
                  Text(
                    text, 
                    style: GoogleFonts.acme(
                      fontSize: 30,
                      color: Colors.black
                    ),
                  ),
                  
                ],
            
              ),
            ),
          ),
        ),
      ),
    );
  }
}