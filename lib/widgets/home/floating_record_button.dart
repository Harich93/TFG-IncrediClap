import 'dart:async';

import 'package:flutter/material.dart';
import 'package:incredibclap/models/s_audios.dart';
import 'package:incredibclap/widgets/music/music_radial_duration.dart';
import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/providers/providers.dart';
import 'package:incredibclap/services/services.dart';
import 'package:incredibclap/themes/themes.dart';
import 'package:incredibclap/widgets/music/music.dart';
import 'package:provider/provider.dart';

class FloatingRecordButton extends StatelessWidget {
  const FloatingRecordButton({
    Key? key,
    required this.dm,
  }) : super(key: key);

  final DurationModel dm;

  @override
  Widget build(BuildContext context) {

    StreamSubscription<Duration>? stream;
    final rs = Provider.of<RecordService>(context);
    final ap = Provider.of<AudiosProvider>(context);
    final Audio audio = ap.audios[0];
    const zeroDuration = Duration(hours: 0, minutes: 0, seconds: 0, milliseconds: 0);

    String nameRecord = "Pista";
    Duration durationless = const Duration();

    //^ Dialog confirmacion de guardado
    Future<void> _saveRecordDialog() async { 

      ap.pauseNowPlaying();
      
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Guardar'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Text('¿Desea guardar la grabación?'),
                  const SizedBox(height: 20),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    decoration: InputDecorations.authInput(
                      hintText: 'Titulo',
                      labelText: 'Pista',
                    ),
                    onChanged: ( value ) => nameRecord = value,
                  )
                ],
              ),
            ),
            actions: <Widget>[
              
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  ap.playNowPlaying();
                  Navigator.of(context).pop();
                },
              ),

              TextButton(
                child: const Text('Si'),
                onPressed: () {
                  rs.addPoint(dm.current, lstAudios[0]);
                  rs.addAudio( nameRecord );
                  ap.playNowPlaying();
                  Navigator.of(context).pop();
                },
              ),

              
            ]
          );
        },
      );
    }

    //^ Dialog si nowPlaying está vacio no graba
    Future<void> _nowPlayingIsEmptyDialog() async { 

      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sin audio'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const [
                  Text('Debe de estar reproduciendo para poder realizar la grabación'),
                  SizedBox(height: 20),
                ],
              ),
            ),
            actions: <Widget>[
              
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              
            ]
          );
        },
      );
    }

    _startRecord() async{ 
        
        dm.soundDuration = const Duration(minutes: 2); // Maximo duración grabación
      
        if( ap.nowPlaying.isEmpty ) {
          _nowPlayingIsEmptyDialog();
        }
        else{
         
          rs.isRecord = !rs.isRecord;

          if( rs.isRecord ) {
           
            for (Audio au in  ap.nowPlaying ) { // Guarda todos los audios actuales en comienzo 00:00
                rs.addPoint( dm.current, au ); 
            }

            if(!dm.playing) {

              stream = audio.player.createPositionStream().listen( (event) {
                
                if( dm.playing && rs.isRecord ) { 
                  
                  if( durationless.inSeconds != 0 || durationless.inMilliseconds != 0 ) { 
                    dm.current = event + durationless;
                  }

                  if( dm.current >= dm.soundDuration ) { // Si llega al maximo de duración permitida abre el dialogo de guardar
                    dm.playing = false;
                    _saveRecordDialog();
                  }

                }
                
                else {  
                  durationless = zeroDuration - event;
                  dm.playing = true;
                }
                
              });

            }


          }
          else {
            await _saveRecordDialog();
            stream?.pause() ;
            dm.playing = false;
            dm.current = zeroDuration; 
          }
          
        }
    
  }

    return FloatingActionButton(
      heroTag: null,
      onPressed: () => _startRecord(),
      backgroundColor: ThemeColors.darkPrimary,
      child: RadialProgress(
            primaryColor: rs.isRecord ? Colors.red : ThemeColors.primary ,
            secondColor: ThemeColors.primary,
            percentage: dm.porcentaje,
            percentageString: dm.currentSecond,
            strokeWidthBack: 3,
            strokeWidthFront: 3,
          ),
        
      );
    
  }
}