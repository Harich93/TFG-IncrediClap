// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:incredibclap/services/record_service.dart';
import 'package:provider/provider.dart';

import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/providers/providers.dart';
import 'package:incredibclap/themes/themes.dart';
import 'package:incredibclap/widgets/settings/pop_menu.dart';


class PlayerScreen extends StatelessWidget {

  static const String routeName = 'Player';
  List<AudioRecord>? audioRecord = List<AudioRecord>.empty(growable: true);

  PlayerScreen({
    Key? key, 
    this.audioRecord
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    AudiosProvider ap = Provider.of<AudiosProvider>(context);
    DurationModel dm = Provider.of<DurationModel>(context);
    Duration durationZero = const Duration(seconds: 0);

    return WillPopScope(
      onWillPop: () async{ 
        ap.stopAll();
        dm.playing = false;
        dm.soundDuration = durationZero;
        dm.current = durationZero;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: const [
            PopMenu()
          ],
          foregroundColor: ThemeColors.dark,
          backgroundColor: ThemeColors.primary,
        ),
        body: Stack(
          children: <Widget>[

            Container(color: ThemeColors.dark),
            Background(),

            Column(
              children: <Widget>[

                ImagenDiscoDuracion(),

                TituloPlay( audioRecord ),

              ],
            ),
          ],
        )
      )
   );
  }
}

class Background extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: screenSize.height * .95,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only( bottomLeft: Radius.circular(60)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.bottomLeft,
          colors: [
            ThemeColors.primary,
            ThemeColors.lightPrimary
          ]
        )
      ),
    );
  }
}

class TituloPlay extends StatefulWidget {

  late List<AudioRecord> listAudios;
  TituloPlay(List<AudioRecord>? listAudios);

  @override
  _TituloPlayState createState() => _TituloPlayState();
}

class _TituloPlayState extends State<TituloPlay> with SingleTickerProviderStateMixin {

  bool isPlaying = false;
  bool firstTime = true;
  late AnimationController playAnimation;
  late AudioRecord audioRecord;

  List<Track> tracks = List<Track>.empty(growable: true); 
  List<Track> tracksDelete = List<Track>.empty(growable: true); 


  @override
  void initState() {
    
    playAnimation = AnimationController( vsync: this, duration: const Duration(milliseconds: 500 ) );
    super.initState();
  }

  @override
  void dispose() { 
    playAnimation.dispose();
    super.dispose();
  }

  void open() async{


    final audioProvider = Provider.of<AudiosProvider>(context, listen: false);
    final durationModel = Provider.of<DurationModel>(context, listen: false);

    audioProvider.playAll();
    tracks = audioRecord.tracks;

    durationModel.soundDuration = tracks.last.parseDuration();
    
    audioProvider.audios[0].player.createPositionStream().listen( (duration) {
      
      durationModel.current = duration;

      tracks = audioRecord.tracks;

      Track track = tracks[0];

      if( track.parseDuration().inSeconds == duration.inSeconds ) {
        
        for (var audio in audioProvider.audios) {

          if( audio.id == track.idAudio )  {
            audio.player.setVolume(track.volume);
            tracksDelete.add(tracks[0]);
            tracks.removeAt(0);
          }

        }
      }
    });
  }

  String name = "Pista";

  @override
  Widget build(BuildContext context) {

    final audioProvider = Provider.of<AudiosProvider>(context);
    // final durationModel = Provider.of<DurationModel>(context);
    final recordService = Provider.of<RecordService>(context);


   
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 50 ),
      margin: const EdgeInsets.only( top: 40 ),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(name, style: TextStyle( fontSize: 30, color: Colors.white.withOpacity(0.8) )),
              Text('-Breaking Benjamin-', style: TextStyle( fontSize: 15, color: Colors.white.withOpacity(0.5) )),
            ],
          ),

          const Spacer(),

          FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
            backgroundColor: ThemeColors.dark,
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause, 
              progress: playAnimation,
            ),
            onPressed: () async{
              
              if( isPlaying ) {
                playAnimation.reverse();
                isPlaying = false;
                audioProvider.stopAll();
              }

              if ( firstTime ) {
                audioRecord = await recordService.getAudio(); 
                name = audioRecord.name;
                open();
                firstTime = false;
              } else {
                isPlaying
                  ? audioProvider.stopAll() 
                  : continuePlay(audioProvider);
              }

            },
          )

        ],
      ),
    );
  }

  void continuePlay( AudiosProvider ap ) {
    for( Track t in tracksDelete ) {
      if( t.idAudio > 9 ) {
        ap.audios[t.idAudio].player.setVolume(t.volume);
      }
    }
  }
}

class ImagenDiscoDuracion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 30 ),
      margin: const EdgeInsets.only( top: 70 ),
      child: Row(
        children: <Widget>[

          ImagenDisco(),
          const SizedBox( width: 20 ),

          BarraProgreso(),
          const SizedBox( width: 20 ),
        ],
      ),
    );
  }
}

class BarraProgreso extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {

    final estilo = TextStyle( color: Colors.white.withOpacity(0.4) );

    final audioPlayerModel = Provider.of<DurationModel>(context);
    final porcentaje = audioPlayerModel.porcentaje;

    return Column(
      children: <Widget>[

        Text(audioPlayerModel.soundTotalDuration, style: estilo), 
        const SizedBox( height: 10 ),
        Stack(
          children: <Widget>[

            Container(
              width: 3,
              height: 230,
              color: Colors.white.withOpacity(0.1),
            ),

            Positioned(
              bottom: 0,
              child: Container(
                width: 3,
                height: 230 * porcentaje,
                color: Colors.white.withOpacity(0.8),
              ),
            ),

          ],
        ),
        const SizedBox( height: 10 ),
        Text(audioPlayerModel.currentSecond, style: estilo ),
      ],
    );
  }
}

class ImagenDisco extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final audioPlayerModel = Provider.of<DurationModel>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      width: 250,
      height: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            SpinPerfect(
              duration: const Duration( seconds: 10 ),
              infinite: true,
              manualTrigger: true,
              controller: ( animationController ) => audioPlayerModel.controller = animationController,
              child: const Image( image: AssetImage('assets/aurora.jpg') )
            ),

            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(100)
              ),
            ),

            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: ThemeColors.dark,
                borderRadius: BorderRadius.circular(100)
              ),
            ),

          ],
        )
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          colors: [
            ThemeColors.lightPrimary,
            ThemeColors.dark,
          ]
        )
      ),
    );
  }
}