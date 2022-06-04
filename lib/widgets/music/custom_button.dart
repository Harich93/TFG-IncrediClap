import 'package:flutter/material.dart';
import 'package:incredibclap/models/duration_model.dart';
import 'package:incredibclap/providers/providers.dart';
import 'package:incredibclap/services/record_service.dart';
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
    final rs = Provider.of<RecordService>(context);
    final dm = Provider.of<DurationModel>(context);
    final audio = ap.audios[audioIdx];

    return GestureDetector(

      onTap: () => {
        if(ap.firstPlay) { ap.playAll() },
        ap.changeVolume(audio),
        rs.addPoint(dm.current, audio),
        ap.addNowPlaying()
      },
      child: Container(
        decoration: BoxDecoration(
          color: audio.player.volume == 1 ? ThemeColors.darkPrimary : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
        ),
        height: 100,
        width: 100,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            child: Center(
              child: Image(
                height: 95,
                width: 95,
                image: AssetImage(audio.icon),
                fit: BoxFit.cover,
              )
            ),
        )
      ),
    );
  }

}