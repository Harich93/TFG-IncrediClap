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
        itemCount: audios.length,
        layout: SwiperLayout.DEFAULT,
        itemWidth: size.width * 0.8,
        itemHeight: size.height * 0.7,
        itemBuilder: ( _ , int index ){

          final audio = audios[index];

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * .75,
                // height: size.height * .27,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/artistas/loading.gif'), 
                    image: AssetImage( audio.icon ),
                    fit: BoxFit.cover
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Artista: Frase del artista $index', style: TextStyle( fontSize: 26),)
            ],
          );
        },
      ),
    );
  }
}