import 'package:flutter/material.dart';
import 'package:incredibclap/controller/audios_controller.dart';
import 'package:incredibclap/models/models.dart';

class MusicScreen extends StatelessWidget {

static const String routeName = 'Music';

  const MusicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    AudiosController sc = AudiosController();
    List<Audio> audios = sc.audios;
    
    return Scaffold(
      body: Center(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                color: Colors.teal,
                onPressed: () => {
                  

                  // audios.forEach((element) {element.audio.play();})
                  audios[1].audio.setVolume(1),
                  audios[2].audio.setVolume(1),
                  audios[3].audio.setVolume(1),
                  audios[4].audio.setVolume(1),
                  audios[5].audio.setVolume(1),
                  audios[6].audio.setVolume(1),
                  audios[7].audio.setVolume(1),
                  audios[8].audio.setVolume(1),
                  audios[9].audio.setVolume(1),




                }, 
                icon: const Icon(Icons.play_arrow)
              ),
              IconButton(
                color: Colors.red,
                onPressed: () => {
                  
                  audios[1].audio.setVolume(0),
                  audios[2].audio.setVolume(0),
                  audios[3].audio.setVolume(0),
                  audios[4].audio.setVolume(0),
                  audios[5].audio.setVolume(0),
                  audios[6].audio.setVolume(0),
                  audios[7].audio.setVolume(0),
                  audios[8].audio.setVolume(0),
                  audios[9].audio.setVolume(0),


                }, 
                icon: const Icon(Icons.stop)
              )
            ],
          ),
        ),
      ),
    );
  }

}