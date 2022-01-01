import 'package:flutter/material.dart';
import 'package:incredibclap/models/audio_player_model.dart';
import 'package:provider/provider.dart';

class DurationSound extends StatelessWidget {
  const DurationSound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    final porcentaje = audioPlayerModel.porcentaje;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        const SizedBox( height: 50,),
        Text(audioPlayerModel.currentSecond, style: const TextStyle( color: Colors.grey )),
        const SizedBox( width: 10,),

        Stack(
          children: [
            Container(
              width: 230,
              height: 3,
              color: Colors.grey,
            ),

            Container(
              width: 230 * porcentaje,
              height: 3,
              color: Colors.white,
            )
          ],
        ),
        const SizedBox( width: 10,),

        Text(audioPlayerModel.soundTotalDuration, style: const TextStyle( color: Colors.grey )),

      ],
    );
  }
}