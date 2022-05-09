import 'package:flutter/material.dart';
import 'package:incredibclap/providers/providers.dart';
import 'package:incredibclap/themes/colors.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  
  CustomButton({
    Key? key,
    required this.audioIdx
  }) : super(key: key);


  int audioIdx;

  @override
  Widget build(BuildContext context) {

    final ap = Provider.of<AudiosProvider>(context);
    final audio = ap.audios[audioIdx];

    return GestureDetector(

      onTap: () => {
        if(ap.firstPlay) { ap.playAll() },

        audio.player.volume == 1
          ? audio.player.setVolume(0)
          : audio.player.setVolume(1)
      },
      child: SizedBox(
        height: 80,
        width: 80,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            child: Center(
              child: Image(
                height: 80,
                width: 80,
                image: AssetImage(audio.icon),
                fit: BoxFit.cover,
              )
            ),
        )
      ),
    );
  }

}