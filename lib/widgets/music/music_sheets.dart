import 'package:flutter/material.dart';
import 'package:incredibclap/models/audio_model.dart';
import 'package:incredibclap/models/duration_model.dart';
import 'package:incredibclap/providers/audio_provider.dart';
import 'package:incredibclap/themes/colors.dart';
import 'package:provider/provider.dart';

class MusicSheets extends StatefulWidget {
  const MusicSheets({Key? key}) : super(key: key);

  @override
  State<MusicSheets> createState() => _MusicSheetsState();
}

class _MusicSheetsState extends State<MusicSheets> with SingleTickerProviderStateMixin{

  

  @override
  void initState() {

    final dm = Provider.of<DurationModel>(context, listen: false);
  
    start = dm.current.inSeconds.toDouble() * 135;
    end = dm.soundDuration.inSeconds.toDouble() * 135;

    Duration duration = Duration(seconds: dm.soundDuration.inSeconds - dm.current.inSeconds );

    controller = AnimationController( 
      vsync: this, duration: duration
    );

    controller.addListener(() { 
      if( controller.status == AnimationStatus.completed ) {
        controller.repeat();
      }
    });


    move = Tween( begin: start , end: end ).animate(controller);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  late AnimationController controller;
  late Animation<double> move;
  late double start;
  late double end;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final ap = Provider.of<AudiosProvider>(context);
    final sheets = createListSheets(ap.dragAudio);
    controller.forward(); 

    return SizedBox(
      height: size.height * .42,
      child: Container(
        color: ThemeColors.backgroundSheets,
        child: Stack(
            children: [
              ListView.builder(
                itemCount: sheets.length,
                itemBuilder: ( BuildContext context, int ind ) => SizedBox(
                  width: 600,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: AnimatedBuilder(
                        animation: controller,
                        builder: (BuildContext context, Widget? child ) {
                          return Transform.translate(
                            offset: Offset(0 - move.value,0),
                            child: Image(
                              image: AssetImage(sheets[ind].musicSheet,),
                              repeat: ImageRepeat.repeatX,
                              alignment: Alignment.centerLeft,
                              width: end ,
                              height: 40,
                              fit: BoxFit.contain,
                            ),
                          );
                        }
                      ),
                    ),
                ),
              ),
              Container(
                margin: const  EdgeInsets.only( left: 0 ),
                child: const Icon(Icons.arrow_drop_down, size: 40, color: Colors.white, shadows: [
                  Shadow(
                    blurRadius: 5,
                    offset: Offset(0,5)
                  )
                ], )
              )
            ]
          ),
      )
    );

        
  }

  List<Audio> createListSheets( List<dynamic> list ) {
    List<Audio> sheets = List.empty(growable: true);
    for (var item in list) {
      if( item.musicSheet != ""){
        sheets.add(item);
      }
    }
    return sheets;
  }
}
