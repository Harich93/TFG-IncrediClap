// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incredibclap/models/audio_player_model.dart';
import 'package:incredibclap/widgets/music/duration_sound.dart';
import 'package:incredibclap/widgets/music/sounds_draggable.dart';
import 'package:incredibclap/widgets/shared/custom_bar.dart';
import 'package:incredibclap/widgets/shared/sidebar_menu.dart';
import 'package:provider/provider.dart';

class CreateMusicScreen extends StatefulWidget {

static const String routeName = 'CreateMusic';

  const CreateMusicScreen({Key? key}) : super(key: key);

  @override
  State<CreateMusicScreen> createState() => _CreateMusicScreenState();
}

class _CreateMusicScreenState extends State<CreateMusicScreen> {


  @override
  Widget build(BuildContext context) {
    
    // <-- Pantalla horizontal -->
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    return Scaffold(
      appBar: const CustomBar(title: 'IncredibClap'),
      drawer: const SidebarMenu(),
      body: Center(
        child: ChangeNotifierProvider(
          create: (_) => AudioPlayerModel(), 
          child: const BoxSounds()
        ),
      ),
    );
  }
}


class BoxSounds extends StatefulWidget {
  const BoxSounds({Key? key}) : super(key: key);

  @override
  State<BoxSounds> createState() => _BoxSoundsState();
}

class _BoxSoundsState extends State<BoxSounds> {

  String pathSound1 = 'assets/audios/1_Base_cajon.mp3';
  String pathSound2 = 'assets/audios/2_Base_palmas.mp3';
  String pathSound3 = 'assets/audios/3_Acento_base_palmas.mp3';
  String pathSound4 = 'assets/audios/4_Contra_1.mp3';
  String pathSound5 = 'assets/audios/5_Contra_2.mp3';
  String pathSound6 = 'assets/audios/6_Contra_3.mp3';
  String pathSound7 = 'assets/audios/7_Contra_4.mp3';
  String pathSound8 = 'assets/audios/8_Tresillo_taconeo_1.mp3';
  String pathSound9 = 'assets/audios/9_Tresillo_taconeo_2.mp3';

  List<AssetsAudioPlayer> playList = List.empty(growable: true);
  List<String> playListString = List.empty(growable: true);
  bool firstPlay = true;

  final iconMuteOn = const Icon( Icons.volume_up, color: Colors.black );
  final iconMuteOff = const Icon( Icons.volume_off, color: Colors.grey );
  final soundEnable = const IconButton(onPressed: null, icon: Icon(Icons.bubble_chart));
  
  var sound1 = AssetsAudioPlayer();
  var sound2 = AssetsAudioPlayer();
  var sound3 = AssetsAudioPlayer();
  var sound4 = AssetsAudioPlayer();
  var sound5 = AssetsAudioPlayer();
  var sound6 = AssetsAudioPlayer();
  var sound7 = AssetsAudioPlayer();

  
  bool sound1mute = false;
  bool sound2mute = false;
  bool sound3mute = false;
  bool sound4mute = false;
  bool sound5mute = false;
  bool sound6mute = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        const DurationSound(),
        const SizedBox(height: 20),

        
        Row( // Recibe sonido
          mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
          children: [

            DragTarget<String>( // sound 1
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return SizedBox(
                  height: 100.0,
                  width: 100.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          _DeleteIcon(
                            onPressed: () { 
                              sound1.stop(); 
                              playList.remove(sound1);
                            }
                          ),
                          IconButton(
                            splashRadius: 20,
                            onPressed: () {
                              
                              if(sound1mute){
                                sound1.setVolume(1);
                                sound1mute = false;
                              }
                              else{ 
                                sound1.setVolume(0);
                                sound1mute = true;
                              }
                              
                              setState(() {});
                            },
                            icon: !sound1mute ? iconMuteOn : iconMuteOff
                          )
                        ],
                      ),

                      _IconSoundBox(visual: Text(_iconReciveBox(sound1.id)))

                    ],
                  ),
                );
              },
              onAccept: (String data) {
                setState(() {
                  sound1 = AssetsAudioPlayer.withId(data);
                  playList.add(sound1);
                  sound1.open(Audio(data), autoStart: false, loopMode: LoopMode.playlist );
                  playListString.add(sound1.id);
                });
              },
            ),
            
            DragTarget<String>( // sound 2
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return SizedBox(
                  height: 100.0,
                  width: 100.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          _DeleteIcon(
                            onPressed: () { 
                              sound2.stop(); 
                              playList.remove(sound2); 
                            }
                          ),
                          IconButton(
                            onPressed: () {
                              if(sound2mute){
                                sound2.setVolume(1);
                                sound2mute = false;
                              }
                              else{ 
                                sound2.setVolume(0);
                                sound2mute = true;
                              } 

                              setState(() {});
                            },
                            icon: !sound2mute ? iconMuteOn : iconMuteOff
                          )
                        ],
                      ),

                      _IconSoundBox(visual: Text(_iconReciveBox(sound2.id)))

                    ],
                  ),
                );
              },
              onAccept: (String data) {
                setState(() {
                 sound2 = AssetsAudioPlayer.withId(data);
                 playList.add(sound2);
                 sound2.open(Audio(data), autoStart: false, loopMode: LoopMode.playlist );
                 playListString.add(sound2.id);
                });
              },
            ),
          
            DragTarget<String>( // sound 3
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return SizedBox(
                  height: 100.0,
                  width: 100.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          _DeleteIcon(
                            onPressed: () { 
                              sound3.stop();
                              sound3 = AssetsAudioPlayer();
                              playList.remove(sound3); 
                            }
                          ),
                          IconButton(
                            onPressed: () {
                              if(sound3mute){
                                sound3.setVolume(1);
                                sound3mute = false;
                              }
                              else{ 
                                sound3.setVolume(0);
                                sound3mute = true;
                              } 
                              setState(() {});
                            },
                            icon: !sound3mute ? iconMuteOn : iconMuteOff
                          )
                        ],
                      ),
                    
                      _IconSoundBox(visual: Text(_iconReciveBox(sound3.id)) )
                    ],
                ),
              );
            },
              onAccept: (String data) {
                setState(() {
                  sound3 = AssetsAudioPlayer.withId(data);
                  playList.add(sound3);
                  sound3.open(Audio(data), autoStart: false, loopMode: LoopMode.playlist );
                  playListString.add(sound3.id);
                });
              },
            ),
          
          ],
        ),

        const SizedBox(height: 20),

        Row( // Recibe sonido 2
          mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
          children: [

            DragTarget<String>( // sound 4
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return SizedBox(
                  height: 100.0,
                  width: 100.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          _DeleteIcon(
                            onPressed: () { 
                              sound4.stop(); 
                              sound4 = AssetsAudioPlayer();
                              playList.remove(sound4); 
                            }
                          ),
                          IconButton(
                            onPressed: () {
                              if(sound4mute){
                                sound4.setVolume(1);
                                sound4mute = false;
                              }
                              else{ 
                                sound4.setVolume(0);
                                sound4mute = true;
                              } 

                              setState(() {});
                            },
                            icon: !sound4mute ? iconMuteOn : iconMuteOff
                          )
                        ],
                      ),

                      _IconSoundBox(visual: Text(_iconReciveBox(sound4.id)) )

                    ],
                  ),
                );
              },
              onAccept: (String data) {
                setState(() {
                  sound4 = AssetsAudioPlayer.withId(data);
                  playList.add(sound4);
                  sound4.open(Audio(data), autoStart: false, loopMode: LoopMode.playlist );
                  playListString.add(sound4.id);
                });
              },
            ),
            
            DragTarget<String>( // sound 5
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return SizedBox(
                  height: 100.0,
                  width: 100.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          _DeleteIcon(
                            onPressed: () { 
                              sound5.stop(); 
                              sound5 = AssetsAudioPlayer();
                              playList.remove(sound5); 
                            }
                          ),
                          IconButton(
                            onPressed: () {
                              if(sound5mute){
                                sound5.setVolume(1);
                                sound5mute = false;
                              }
                              else{ 
                                sound5.setVolume(0);
                                sound5mute = true;
                              } 

                              setState(() {});
                            },
                            icon: !sound5mute ? iconMuteOn : iconMuteOff
                          )
                        ],
                      ),

                      _IconSoundBox(visual: Text(_iconReciveBox(sound5.id)) )

                    ],
                  ),
                );
              },
              onAccept: (String data) {
                setState(() {
                 sound5 = AssetsAudioPlayer.withId(data);
                 playList.add(sound5);
                 sound5.open(Audio(data), autoStart: false, loopMode: LoopMode.playlist );
                 playListString.add(sound5.id);
                });
              },
            ),
          
            DragTarget<String>( // sound 6
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return SizedBox(
                  height: 100.0,
                  width: 100.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          _DeleteIcon(
                            onPressed: () { 
                              sound6.stop();
                              sound6 = AssetsAudioPlayer();
                              playList.remove(sound6);
                            }
                          ),
                          IconButton(
                            onPressed: () {
                              if(sound6mute){
                                sound6.setVolume(1);
                                sound6mute = false;
                              }
                              else{ 
                                sound6.setVolume(0);
                                sound6mute = true;
                              } 

                              setState(() {});
                            },
                            icon: !sound6mute ? iconMuteOn : iconMuteOff
                          )
                        ],
                      ),
                    
                      _IconSoundBox(visual: Text(_iconReciveBox(sound6.id)) )
                    ],
                ),
              );
            },
              onAccept: (String data) {
                setState(() {
                  sound6 = AssetsAudioPlayer.withId(data);
                  playList.add(sound6);
                  sound6.open(Audio(data), autoStart: false, loopMode: LoopMode.playlist );
                  playListString.add(sound6.id);
                });
              },
            ),
          
          ],
        ),

        const SizedBox(height: 50),

        Row( // Contenedores de sonidos
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            !playListString.contains(pathSound1) 
              ? SoundDraggable(data: pathSound1, child: const Text('1') ) 
              : soundEnable,

            !playListString.contains(pathSound2) 
              ? SoundDraggable(data: pathSound2, child: const Text('2')) 
              : soundEnable,

            !playListString.contains(pathSound3) 
              ? SoundDraggable(data: pathSound3, child: const Text('3') ) 
              : soundEnable,

            !playListString.contains(pathSound4) 
              ? SoundDraggable(data: pathSound4, child: const Text('4') ) 
              : soundEnable,

            !playListString.contains(pathSound5) 
              ? SoundDraggable(data:pathSound5, child: const Text('5') ) 
              : soundEnable,

            !playListString.contains(pathSound6) 
              ? SoundDraggable(data: pathSound6, child: const Text('6') ) 
              : soundEnable,

            !playListString.contains(pathSound7) 
              ? SoundDraggable(data: pathSound7, child: const Text('7') ) 
              : soundEnable,
          ],
        ),
       
        const SizedBox(height: 50),

        Row( // Play-Pause Buttons
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => _stop(),
                  child: const Text('Stop', style: TextStyle( fontSize: 20, color: Colors.orange),)
                  
                ),
                TextButton(
                  onPressed: () => _play(),
                  child: const Text('Play', style: TextStyle( fontSize: 20, color: Colors.green),)
                  
                )
              ],
            ),
      ],
    );
  }

  void _play() => {
    playList.forEach( (sound) => sound.play() ),

    if(!playList.length.isNegative && firstPlay )  {
      _setDuration(playList[0]),
      firstPlay = false,
      setState(() {})
    }
  
  };

  void _stop() { playList.forEach( (sound) => sound.stop() );}

  void _setDuration( AssetsAudioPlayer sound ) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context, listen: false);
    final assetAudioPlayer = sound;

    assetAudioPlayer.currentPosition.listen( (duration) {
      audioPlayerModel.current = duration;
    });
  
    assetAudioPlayer.current.listen( (playingAudio){
      audioPlayerModel.soundDuration = playingAudio?.audio.duration ?? const Duration(seconds: 0);
    });

  }

  String _iconReciveBox( String data ) {

    if( data == pathSound1 ) return 'Sound1';
    if( data == pathSound2 ) return 'Sound2';
    if( data == pathSound3 ) return 'Sound3';
    if( data == pathSound4 ) return 'Sound4';
    if( data == pathSound5 ) return 'Sound5';
    if( data == pathSound6 ) return 'Sound6';
    if( data == pathSound7 ) return 'Sound7';
    
    return '';
  }
}


class _IconSoundBox extends StatelessWidget {
  const _IconSoundBox({
    Key? key, 
    required this.visual,
  }) : super(key: key);

  final Widget visual;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.black26
      ),
      child: Center(child: visual)
    );
  }
}

class _DeleteIcon extends StatelessWidget {
  const _DeleteIcon({
    Key? key, 
    required this.onPressed
  }) : super(key: key);
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20,
      onPressed: () => onPressed(), 
      icon: const Icon( Icons.clear, color: Colors.red,)
    );
  }
}