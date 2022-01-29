import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incredibclap/controller/audios_controller.dart';
import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/providers/audio_provider.dart';
import 'package:incredibclap/themes/themes.dart';
import 'package:incredibclap/widgets/home/home_background.dart';
import 'package:incredibclap/widgets/music/music_widgets.dart';
import 'package:provider/provider.dart';

class MusicScreen extends StatelessWidget {

static const String routeName = 'Music';

  const MusicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AudiosProvider audioProvider = Provider.of<AudiosProvider>(context);
  
    List<Audio> audios = audioProvider.audios;
    
    return Scaffold(
      
      body:HomeBackground( child: Stack(
            children: [
              _PlayPause(audios: audios),
              _MusicMenuLocation()
            ],
          )
      ),
    );
  }

}

class _MusicMenuLocation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Positioned(
      bottom: 40,
      child:  SizedBox(
        width: width,
        child: Center(child: MusicMenu())
      )
    );
  }
}

class _PlayPause extends StatelessWidget {
  const _PlayPause({
    Key? key,
    required this.audios,
  }) : super(key: key);

  final List<Audio> audios;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              color: Colors.teal,
              onPressed: () => {
              
                // audios.forEach((element) {element.player.play();})
                audios[1].player.setVolume(1),
                audios[2].player.setVolume(1),
                audios[3].player.setVolume(1),
                audios[4].player.setVolume(1),
                audios[5].player.setVolume(1),
                audios[6].player.setVolume(1),
                audios[7].player.setVolume(1),
                audios[8].player.setVolume(1),
                audios[9].player.setVolume(1),


              }, 
              icon: const Icon(Icons.play_arrow)
            ),
            IconButton(
              color: Colors.red,
              onPressed: () => {
                
                audios[1].player.setVolume(0),
                audios[2].player.setVolume(0),
                audios[3].player.setVolume(0),
                audios[4].player.setVolume(0),
                audios[5].player.setVolume(0),
                audios[6].player.setVolume(0),
                audios[7].player.setVolume(0),
                audios[8].player.setVolume(0),
                audios[9].player.setVolume(0),


              }, 
              icon: const Icon(Icons.stop)
            )
          ],
        ),
      ),
    );
  }
}