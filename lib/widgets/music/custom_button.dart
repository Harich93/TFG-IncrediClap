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
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: ThemeColors.dark
        ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Center(
              child: Image(
                image: AssetImage(audio.icon),
                fit: BoxFit.cover,
              )
            ),
        )
      ),
    );
  }

}