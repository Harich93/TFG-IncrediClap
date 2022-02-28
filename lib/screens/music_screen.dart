import 'package:flutter/material.dart';
import 'package:incredibclap/services/services.dart';
import 'package:incredibclap/themes/colors.dart';
import 'package:incredibclap/widgets/music/music_draggable.dart';
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

    final size = MediaQuery.of(context).size;
    const soundEnable = IconButton(onPressed: null, icon: Icon(Icons.bubble_chart));
    
    AudiosProvider ap = Provider.of<AudiosProvider>(context);
    DurationModel dm = Provider.of<DurationModel>(context);
    RecordService rs = Provider.of<RecordService>(context);

    List<AudioTab> audiosTab = ap.audiostab;
   
    const textStyleTab = TextStyle( color: Colors.black87);
    return WillPopScope(
      onWillPop: () async{ 
        ap.resetAudiosProvider();
        dm.playing = false;
        dm.current = const Duration(seconds: 0);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.black87,
          elevation: 5,
          centerTitle: true,
          title: const Text("IncredibClap"),
          backgroundColor: ThemeColors.primary,
        ),
        body:Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column( // Drags Container
                children: [

                  SizedBox(  
                    height: 70,
                    width: 70,
                    child: RadialProgress(
                      primaryColor: rs.isRecord ? Colors.red : Colors.black87 ,
                      percentage: dm.porcentaje,
                      percentageString: dm.currentSecond,
                      strokeWidthBack: 2,
                      strokeWidthFront: 3,
                    )
                  ),

                  Row( // Drags 1
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DragTarget<Audio>( // Audio 0
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        
                        ) => DragCustom( dragIndx: 0 ),
            
                        onAccept: (Audio audio) => _onAccept(ap, audio, dm, rs, 0)
                      ),
                      
                      DragTarget<Audio>( // Audio 1
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        
                        ) => DragCustom(  dragIndx: 1 ),
            
                        onAccept: (Audio audio) => _onAccept(ap, audio, dm, rs, 1)
                      ),
            
                      DragTarget<Audio>( // Audio 2
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        
                        ) => DragCustom(dragIndx: 2 ),
    
                        onAccept: (Audio audio) => _onAccept(ap, audio, dm, rs, 2)
    
                      ),
    
                      DragTarget<Audio>( // Audio 3
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        
                        ) => DragCustom(dragIndx: 3 ),
            
                        onAccept: (Audio audio) => _onAccept(ap, audio, dm, rs, 3)
    
                      ),
                    ],
                  ),
    
                  const SizedBox(height:20),
    
                  Row( // Drags 2
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DragTarget<Audio>( // Audio 4
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        
                        ) => DragCustom( dragIndx: 4 ),
            
                        onAccept: (Audio audio) => _onAccept(ap, audio, dm, rs, 4)
                      ),
                      
                      DragTarget<Audio>( // Audio 5
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        
                        ) => DragCustom(  dragIndx: 5 ),
            
                        onAccept: (Audio audio) => _onAccept(ap, audio, dm, rs, 5)
                      ),
            
                      DragTarget<Audio>( // Audio 6
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        
                        ) => DragCustom(dragIndx: 6),
    
                        onAccept: (Audio audio) => _onAccept(ap, audio, dm, rs, 6)
    
                      ),
    
                      DragTarget<Audio>( // Audio 7
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        
                        ) => DragCustom(dragIndx: 7 ),
            
                        onAccept: (Audio audio) => _onAccept(ap, audio, dm, rs, 7)
    
                      ),
                    ],
                  ),
                ],
              ),
             
              // const Divider(),
    
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
              
              // const Divider(),
    
              Row( // Tabs
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _TabAudio(audioTab: audiosTab[0], rs: rs, dm: dm, textStyleTab: textStyleTab),
                  _TabAudio(audioTab: audiosTab[1], rs: rs, dm: dm, textStyleTab: textStyleTab),
                  _TabAudio(audioTab: audiosTab[2], rs: rs, dm: dm, textStyleTab: textStyleTab),
                  _TabAudio(audioTab: audiosTab[3], rs: rs, dm: dm, textStyleTab: textStyleTab),
                  _TabAudio(audioTab: audiosTab[4], rs: rs, dm: dm, textStyleTab: textStyleTab),
                  _TabAudio(audioTab: audiosTab[5], rs: rs, dm: dm, textStyleTab: textStyleTab),
                ],
              ),
              
              // const Divider(),
    
              _MusicMenuLocation()
            ],
          )
        ),
    );
  }

  void _onAccept(AudiosProvider ap, Audio audio, DurationModel dm, RecordService rs, int ind) {
     if( !ap.dragContaintAudio(ind) ){
      setState(() {
        ap.addAudioInDrag(audio, ind);
        audio.player.setVolume(1);
        _setDuration(dm, ap, ind);
        rs.addPoint(dm.current, audio);
      });
    }
  }

  void _setDuration( DurationModel dm, AudiosProvider ap, int indDrag) async{ // Establece la duración del sonido
    
    if(!dm.playing) {
      ap.playAll();

      final Audio audio = ap.dragAudio[indDrag] ;
      dm.playing = true;

      dm.soundDuration = audio.player.duration!;

      audio.player.createPositionStream().listen((event) {
        mounted ? setState(() {
          dm.current = event;
        }) : null;
      });
    }
  }
}

class _TabAudio extends StatelessWidget {
  const _TabAudio({
    Key? key,
    required this.audioTab,
    required this.textStyleTab,
    required this.rs,
    required this.dm
  }) : super(key: key);

  final AudioTab audioTab;
  final TextStyle textStyleTab;
  final RecordService rs;
  final DurationModel dm;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        IconButton(
          onPressed: () { 
            audioTab.play();
            rs.isRecord ? rs.addPoint( dm.current , audioTab.audio ) : null;
          }, 
          icon: const Icon(Icons.touch_app),
        ),
        Text(audioTab.icon, style: textStyleTab,)
      ],
    );
  }
}

class _MusicMenuLocation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      child: const Center(
        child: MusicMenu()
      )
    );
  }
}



