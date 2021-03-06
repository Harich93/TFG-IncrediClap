// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:incredibclap/themes/colors.dart';
import 'package:incredibclap/services/services.dart';
import 'package:incredibclap/widgets/shared/shared.dart';
import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/themes/themes.dart';


class PlayerScreen extends StatelessWidget {

  static const String routeName = 'Player';
  List<AudioRecord>? audioRecord = List<AudioRecord>.empty(growable: true);

  PlayerScreen({
    Key? key, 
    this.audioRecord
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    
    PlayerAudio pa = Provider.of<PlayerAudio>(context);

    return WillPopScope(
      onWillPop: () async{ 
        pa.resetTrack();
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: const AppBarCustom(
          title: "",
          elevation: 0,
          menuOpt: false,
        ),
        body: HomeBackground(
          child: Column(
            children: [
              ImagenDiscoDuracion(),
              TituloPlay()
            ],
          ),
        )
      )
   );
  }
}


class TituloPlay extends StatefulWidget {

  @override
  _TituloPlayState createState() => _TituloPlayState();
}

class _TituloPlayState extends State<TituloPlay> with SingleTickerProviderStateMixin {

  late PlayerAudio playerAudio;
  late AnimationController playAnimation;

  String title = "";
  String nameUser = "";

  @override
  void initState() {
    playerAudio = Provider.of<PlayerAudio>(context, listen: false);
    playAnimation = AnimationController( vsync: this, duration: playerAudio.lastDuration );
    super.initState();
  }

  @override
  void dispose() { 
    playAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 50 ),
      margin: const EdgeInsets.only( top: 40 ),
      child: Column(
        children: [

          SizedBox(height: size.height * 0.05),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      elevation: 0,
                      
                      highlightElevation: 0,
                      backgroundColor: ThemeColors.dark,
                      child: playerAudio.isPlaying 
                        ? const Icon(Icons.pause)
                        : const Icon(Icons.play_arrow), 
                      onPressed: () => playerAudio.playPause(),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.06),
                
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.6,
                      child: Column(
                        children: [
                          Text( 
                            playerAudio.title, 
                            maxLines: 1,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: size.width * 0.10, 
                              color: ThemeColors.darkPrimary.withOpacity(0.8) 
                            )
                          ),
                          Text(
                            'Creado por: ${playerAudio.userName}', 
                            style: TextStyle( 
                              fontSize: size.width * 0.05, 
                              color: ThemeColors.darkPrimary.withOpacity(0.4) 
                            )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
          // const SizedBox( width: 20 ),

        ],
      ),
    );
  }
}


class BarraProgreso extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {

    final estilo = TextStyle( color: Colors.white.withOpacity(0.4) );

    final dm = Provider.of<DurationModel>(context);

    return Column(
      children: <Widget>[

        Text(dm.soundTotalDuration, style: estilo), 
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
                height: dm.porcentaje/100 * 230,
                color: Colors.white.withOpacity(0.8),
              ),
            ),

          ],
        ),

        const SizedBox( height: 10 ),
        Text(dm.currentSecond, style: estilo ),
      ],
    );
  }
}


class ImagenDisco extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final dm = Provider.of<DurationModel>(context);
    final rs = Provider.of<RecordService>(context);
    final Duration discAnimaDuration = rs.selectedAudioRecord.tracks.last.parseDuration();
  
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
              duration: discAnimaDuration,
              infinite: true,
              manualTrigger: true,
              controller: ( animationController ) => {
                dm.controller = animationController,
                dm.controller.stop()  
              },
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
            ThemeColors.darkPrimary,
            ThemeColors.dark,
          ]
        )
      ),
    );
  }
}

