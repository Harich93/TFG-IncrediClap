import 'package:flutter/material.dart';
import 'package:incredibclap/themes/colors.dart';
import 'package:incredibclap/widgets/music/music_draggable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/providers/audio_provider.dart';
import 'package:incredibclap/widgets/home/home_widgets.dart';
import 'package:incredibclap/widgets/music/music_widgets.dart';

class MusicScreen extends StatefulWidget {

static const String routeName = 'Music';

  const MusicScreen({Key? key}) : super(key: key);
  
  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {


  @override
  Widget build(BuildContext context) {

    DurationModel dm = Provider.of<DurationModel>(context);
    AudiosProvider ap = Provider.of<AudiosProvider>(context);
    const soundEnable = IconButton(onPressed: null, icon: Icon(Icons.bubble_chart));
    double currentDuration = 0;
   
    return Scaffold(
      
      body:HomeBackground( child: Stack(
          children: [
            
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                
                SizedBox(
                  height: 80,
                  width: 80,
                  child: RadialProgress(
                    primaryColor: ThemeColors.darkPrimary,
                    percentage: dm.porcentaje,
                    percentageString: dm.currentSecond,
                    strokeWidthBack: 2,
                    strokeWidthFront: 3,
                  )
                ),

                Column( // Drags Container
                  children: [
                    Row( // Drags 1
                      children: [
                        DragTarget<Audio>( // Audio 0
                          builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          
                          ) => DragCustom( dragIndx: 0, audio: ap.setInitAudioDrag(0) ),
          
                          onAccept: (Audio audio) {
                            if( !ap.dragContaintAudio(0, audio) ){
                              setState(() {
                                ap.addAudioInDrag(audio, 0);
                                audio.player.setVolume(1);
                                _setDuration(dm, ap, 0);
                              });
                            }
                          },
                        ),
                        
                        DragTarget<Audio>( // Audio 1
                          builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          
                          ) => DragCustom(  dragIndx: 1, audio: ap.setInitAudioDrag(1) ),
          
                          onAccept: (Audio audio) {
                            if( !ap.dragContaintAudio(1, audio) ){
                              setState(() {
                                ap.addAudioInDrag(audio, 1);
                                audio.player.setVolume(1);
                              });
                            }
                          },
                        ),
          
                        DragTarget<Audio>( // Audio 2
                          builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          
                          ) => DragCustom(dragIndx: 2, audio: ap.setInitAudioDrag(2)),

                          onAccept: (Audio audio) {
                            if( !ap.dragContaintAudio(2, audio) ){
                              setState(() {
                                ap.addAudioInDrag(audio, 2);
                                audio.player.setVolume(1);
                              });
                            }
                          },

                        ),

                        DragTarget<Audio>( // Audio 3
                          builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          
                          ) => DragCustom(dragIndx: 3, audio: ap.setInitAudioDrag(3) ),
          
                          onAccept: (Audio audio) {
                            if( !ap.dragContaintAudio(3, audio) ){
                              setState(() {
                                ap.addAudioInDrag(audio, 3);
                                audio.player.setVolume(1);
                              });
                            }
                          },

                        ),
                      ],
                    ),

                    const SizedBox(height:20),

                    Row( // Drags 2
                      children: [
                        DragTarget<Audio>( // Audio 4
                          builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          
                          ) => DragCustom( dragIndx: 4, audio: ap.setInitAudioDrag(4) ),
              
                          onAccept: (Audio audio) {
                            if( !ap.dragContaintAudio(4, audio) ){
                              setState(() {
                                ap.addAudioInDrag(audio, 4);
                                audio.player.setVolume(1);
                              });
                            }
                          },
                        ),
                        
                        DragTarget<Audio>( // Audio 5
                          builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          
                          ) => DragCustom(  dragIndx: 5, audio: ap.setInitAudioDrag(5) ),
              
                          onAccept: (Audio audio) {
                            if( !ap.dragContaintAudio(5, audio) ){
                              setState(() {
                                ap.addAudioInDrag(audio, 5);
                                audio.player.setVolume(1);
                              });
                            }
                          },
                        ),
              
                        DragTarget<Audio>( // Audio 6
                          builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          
                          ) => DragCustom(dragIndx: 6, audio: ap.setInitAudioDrag(6)),

                          onAccept: (Audio audio) {
                            if( !ap.dragContaintAudio(6, audio) ){
                              setState(() {
                                ap.addAudioInDrag(audio, 6);
                                audio.player.setVolume(1);
                              });
                            }
                          },

                        ),

                        DragTarget<Audio>( // Audio 7
                          builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          
                          ) => DragCustom(dragIndx: 7, audio: ap.setInitAudioDrag(7) ),
              
                          onAccept: (Audio audio) {
                            if( !ap.dragContaintAudio(7, audio) ){
                              setState(() {
                                ap.addAudioInDrag(audio, 7);
                                audio.player.setVolume(1);
                              });
                            }
                          },

                        ),
                      ],
                    ),
                  ],
                ),

                Column( // Draggables Container
                  children: [
                    Row( // Contenedores de sonidos
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
        
                        !ap.dragAudio.contains(ap.audios[0]) 
                          ? MusicDraggable(data: ap.audios[0], child: const Text('1') ) 
                          : soundEnable,
        
                        !ap.dragAudio.contains(ap.audios[1]) 
                          ? MusicDraggable(data: ap.audios[1], child: const Text('2')) 
                          : soundEnable,
        
                        !ap.dragAudio.contains(ap.audios[2])  
                          ? MusicDraggable(data: ap.audios[2], child: const Text('3') ) 
                          : soundEnable,
        
                        !ap.dragAudio.contains(ap.audios[3])  
                          ? MusicDraggable(data: ap.audios[3], child: const Text('4') ) 
                          : soundEnable,
        
                        !ap.dragAudio.contains(ap.audios[4]) 
                          ? MusicDraggable(data: ap.audios[4], child: const Text('5') ) 
                          : soundEnable,
                      ],
                    ),
                    const SizedBox(height:20),
                    Row( // Contenedores de sonidos
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
        
                        !ap.dragAudio.contains(ap.audios[5]) 
                          ? MusicDraggable(data: ap.audios[5], child: const Text('6') ) 
                          : soundEnable,
        
                        !ap.dragAudio.contains(ap.audios[6]) 
                          ? MusicDraggable(data: ap.audios[6], child: const Text('7')) 
                          : soundEnable,
        
                        !ap.dragAudio.contains(ap.audios[7])  
                          ? MusicDraggable(data: ap.audios[7], child: const Text('8') ) 
                          : soundEnable,
        
                        !ap.dragAudio.contains(ap.audios[8])  
                          ? MusicDraggable(data: ap.audios[8], child: const Text('9') ) 
                          : soundEnable,
        
                        !ap.dragAudio.contains(ap.audios[9]) 
                          ? MusicDraggable(data: ap.audios[9], child: const Text('10') ) 
                          : soundEnable,
                      ],
                    ),
                  ],
                ),
                _MusicMenuLocation()
              ],
            ),
            // _PlayPause(audios: audios),
          ],
        )
      ),
    );
  }

  void _setDuration( DurationModel dm, AudiosProvider ap, int indDrag) async{ // Establece la duración del sonido
    
    if(!dm.playing) {

      final Audio audio = ap.dragAudio[indDrag] ;
      dm.playing = true;

      dm.soundDuration = audio.player.duration!;

      audio.player.createPositionStream().listen((event) {
        setState(() {
          dm.current = event;
        });
      });
      // assetAudioPlayer.currentPosition.listen( (duration) {
      //   audioPlayerModel.current = duration;
      // });
    
      // assetAudioPlayer.current.listen( (playingAudio){
      //   audioPlayerModel.soundDuration = playingAudio?.audio.duration ?? const Duration(seconds: 0);
      // });
    }
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

