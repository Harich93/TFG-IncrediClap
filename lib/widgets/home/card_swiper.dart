import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/themes/colors.dart';

class CardSwiper extends StatelessWidget {

  final List<Audio> audios;

  const CardSwiper({
    Key? key,
    required this.audios
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    int currentIndex = 0;
    final size = MediaQuery.of(context).size;

    if ( audios.isEmpty ) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        autoplay: true,
        axisDirection: AxisDirection.left,
        autoplayDisableOnInteraction: true,
        curve: Curves.easeInQuart,
        onIndexChanged: (val) => currentIndex = val ,
        itemCount: audios.length,
        layout: SwiperLayout.DEFAULT,
        itemWidth: size.width,
        itemHeight: size.width,
        itemBuilder: ( _ , int index ){

          final audio = audios[index];

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                height: size.width * .7,
                width: size.width * .7,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/artistas/loading.gif'), 
                    image: AssetImage( audio.icon ),
                    fit: BoxFit.fill
                  ),
                ),
              ),
              const SizedBox(height: 45),
              
              if(currentIndex == index) 
                FadeIn(
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