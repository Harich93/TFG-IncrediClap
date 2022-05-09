import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:incredibclap/models/audio_model.dart';

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
      height: size.height * 0.43,
      child: Swiper(
        onIndexChanged: (val) => currentIndex = val ,
        itemCount: audios.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width,
        itemHeight: size.width,
        itemBuilder: ( _ , int index ){

          final audio = audios[index];

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.width * .5,
                width: size.width * .5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/artistas/loading.gif'), 
                    image: AssetImage( audio.icon ),
                    fit: BoxFit.cover
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              if(currentIndex == index) 
                FadeIn(
                  duration: const Duration(milliseconds: 300), 
                  child: Text('Artista: Frase del artista $index', style: const TextStyle( fontSize: 26))
                )
            ],
          );
        },
      ),
    );
  }
}