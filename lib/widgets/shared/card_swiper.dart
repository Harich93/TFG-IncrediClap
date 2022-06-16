import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/services/services.dart';
import 'package:incredibclap/themes/colors.dart';

// ignore: must_be_immutable
class CardSwiper extends StatelessWidget {

  final List<Audio> audios;
  double heigth;
  double width;
  bool citeHidden;
  bool auto;
  bool save;

  CardSwiper({
    Key? key,
    required this.audios,
    this.heigth = 0.6,
    this.width = 0.7,
    this.citeHidden = false,
    this.auto = true,
    this.save = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    if ( audios.isEmpty ) {
      return SizedBox(
        width: double.infinity,
        height: size.height * heigth,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * heigth,
      child: Swiper(
        index: save ? Preferences.idImg : 0,
        autoplay: auto ? true : false,
        axisDirection: AxisDirection.left,
        autoplayDisableOnInteraction: true,
        curve: Curves.easeInQuart,
        itemCount: audios.length,
        layout: SwiperLayout.DEFAULT,
        itemWidth: size.width,
        itemHeight: size.width,
        onIndexChanged: (val) => save ? Preferences.idImg = val : null,
        itemBuilder: ( _ , int index ){

          final audio = audios[index];

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                height: size.width * width,
                width: size.width * width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/artistas/loading.gif'), 
                    image: AssetImage( audio.icon ),
                    fit: BoxFit.fill
                  ),
                ),
              ),
              SizedBox(height: size.width * .1),
              
              if(!citeHidden) FadeIn(
                duration: const Duration(milliseconds: 300), 
                child: SizedBox(
                  width: size.width * 0.8,
                  child: Center(
                    child: Text(
                      audio.cite, 
                      style: GoogleFonts.righteous(
                        textStyle: const TextStyle(
                          color: ThemeColors.darkPrimary,
                          leadingDistribution: TextLeadingDistribution.proportional,
                          fontSize: 25
                        )
                      )
                    )
                  )
                )
              )
            ],
          );
        },
      ),
    );
  }
}