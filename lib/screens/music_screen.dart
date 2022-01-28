import 'package:flutter/material.dart';
import 'package:incredibclap/controller/samples_controller.dart';
import 'package:incredibclap/models/models.dart';

class MusicScreen extends StatelessWidget {

static const String routeName = 'Music';

  const MusicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    SamplesController sc = SamplesController();
    List<Sample> samples = sc.samples;
    
    return Scaffold(
      body: Center(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                color: Colors.teal,
                onPressed: () => {
                  

                  // samples.forEach((element) {element.audio.play();})
                  samples[1].audio.setVolume(1),
                  samples[2].audio.setVolume(1),
                  samples[3].audio.setVolume(1),
                  samples[4].audio.setVolume(1),
                  samples[5].audio.setVolume(1),
                  samples[6].audio.setVolume(1),
                  samples[7].audio.setVolume(1),
                  samples[8].audio.setVolume(1),
                  samples[9].audio.setVolume(1),




                }, 
                icon: const Icon(Icons.play_arrow)
              ),
              IconButton(
                color: Colors.red,
                onPressed: () => {
                  
                  samples[1].audio.setVolume(0),
                  samples[2].audio.setVolume(0),
                  samples[3].audio.setVolume(0),
                  samples[4].audio.setVolume(0),
                  samples[5].audio.setVolume(0),
                  samples[6].audio.setVolume(0),
                  samples[7].audio.setVolume(0),
                  samples[8].audio.setVolume(0),
                  samples[9].audio.setVolume(0),


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