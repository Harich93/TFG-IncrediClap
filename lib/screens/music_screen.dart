import 'package:flutter/material.dart';
import 'package:incrediclap/widgets/shared/shared.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:incrediclap/services/services.dart';
import 'package:incrediclap/themes/colors.dart';
import 'package:incrediclap/models/models.dart';
import 'package:incrediclap/providers/providers.dart';
import 'package:incrediclap/widgets/music/music.dart';

class MusicScreen extends StatelessWidget {

  const MusicScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    const durationAnima = Duration(milliseconds: 800);
    final size = MediaQuery.of(context).size;
    // bool firstPlay = true;
    
    AudiosProvider ap = Provider.of<AudiosProvider>(context);
    DurationModel dm = Provider.of<DurationModel>(context);
    RecordService rs = Provider.of<RecordService>(context);

    List<AudioTab> audiosTab = ap.audiostab;
    
    const textStyleTab = TextStyle( color: Colors.black87);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        const TitlePage(withIcon: false),
        
        Center( // Audios
          child: SizedBox(
            height: size.height * 0.55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                
                FadeIn( //Audios left
                  duration: const Duration(milliseconds: 800),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(audioIdx: 0),
                      CustomButton(audioIdx: 1),
                      CustomButton(audioIdx: 2),
                      CustomButton(audioIdx: 3),
                    ],
                  ),
                ),

                Column( // Icon & sheets 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ///TODO: Reemplazar por logo
                    FloatingActionButton(
                      elevation: 0,
                      onPressed: (){}, 
                      child: const Icon(Icons.queue_music_rounded, color: Colors.black,),
                      backgroundColor: ThemeColors.primary,
                    ),

                    SizedBox(height: size.height*.01),

                    FloatingActionButton(
                      elevation: 0,
                      mini: true,
                      onPressed: () => showMaterialModalBottomSheet(
                        elevation: 10,
                        duration: const Duration(seconds: 1),

                        context: context,
                        builder: (context) => const MusicSheets(),
                      ), 
                      child: const Icon(Icons.queue_music_rounded, color: ThemeColors.darkPrimary),
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
            
                FadeIn( // Audios right
                  duration: const Duration(milliseconds: 800),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(audioIdx: 4),
                      CustomButton(audioIdx: 5),
                      CustomButton(audioIdx: 6),
                      CustomButton(audioIdx: 7),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),

        SizedBox(height: size.height*.075),
    
        FadeInUp( // Tabs audios
          duration: durationAnima,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _TabAudio(audioTab: audiosTab[0], rs: rs, dm: dm, textStyleTab: textStyleTab),
              _TabAudio(audioTab: audiosTab[1], rs: rs, dm: dm, textStyleTab: textStyleTab),
              _TabAudio(audioTab: audiosTab[2], rs: rs, dm: dm, textStyleTab: textStyleTab),
              _TabAudio(audioTab: audiosTab[3], rs: rs, dm: dm, textStyleTab: textStyleTab),
              _TabAudio(audioTab: audiosTab[4], rs: rs, dm: dm, textStyleTab: textStyleTab),
            ],
          ),
        ),
  
      ],
    );
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
          icon: Image(image:AssetImage(audioTab.icon)),
          iconSize: 40,
        ),
      ],
    );
  }
}




