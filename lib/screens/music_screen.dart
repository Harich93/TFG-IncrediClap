import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:incredibclap/services/services.dart';
import 'package:incredibclap/themes/colors.dart';
import 'package:incredibclap/widgets/shared/app_bar_custom.dart';
import 'package:incredibclap/widgets/shared/custom_navigation_bar.dart';
import 'package:provider/provider.dart';

import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/providers/audio_provider.dart';
import 'package:incredibclap/widgets/music/music_widgets.dart';

class MusicScreen extends StatefulWidget {

  const MusicScreen({Key? key}) : super(key: key);
  
  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {

  late AudiosProvider ap;
  @override
  void initState() {
    ap = Provider.of<AudiosProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    const durationAnima = Duration(milliseconds: 800);
    final size = MediaQuery.of(context).size;
    bool firstPlay = true;
    const soundEnable = IconButton(onPressed: null, icon: Icon(Icons.bubble_chart));
    
    AudiosProvider ap = Provider.of<AudiosProvider>(context);
    DurationModel dm = Provider.of<DurationModel>(context);
    RecordService rs = Provider.of<RecordService>(context);

    List<AudioTab> audiosTab = ap.audiostab;
   
    const textStyleTab = TextStyle( color: Colors.black87);
    
    return Container(
      child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: SizedBox(
                    height: size.height * 0.55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            CustomButton(),
                            CustomButton(),
                            CustomButton(),
                            CustomButton(),
                          ],
                        ),
                      
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            CustomButton(),
                            CustomButton(),
                            CustomButton(),
                            CustomButton(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
      
        
              SizedBox(height: size.height*.01),
          
              FadeInUp(
                duration: durationAnima,
                child: Column(
                  children: [
                    Row( // Tabs
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _TabAudio(audioTab: audiosTab[0], rs: rs, dm: dm, textStyleTab: textStyleTab),
                        _TabAudio(audioTab: audiosTab[1], rs: rs, dm: dm, textStyleTab: textStyleTab),
                        _TabAudio(audioTab: audiosTab[2], rs: rs, dm: dm, textStyleTab: textStyleTab),
                        _TabAudio(audioTab: audiosTab[3], rs: rs, dm: dm, textStyleTab: textStyleTab),
                      ],
                    ),
                    Row( // Tabs
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _TabAudio(audioTab: audiosTab[4], rs: rs, dm: dm, textStyleTab: textStyleTab),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: FloatingActionButton(
                            elevation: 0,
                            mini: true,
                            onPressed: (){}, 
                            child: const Icon(Icons.music_note, color: ThemeColors.dark,),
                            backgroundColor: ThemeColors.primary,
                          ),
                        ),
                        _TabAudio(audioTab: audiosTab[5], rs: rs, dm: dm, textStyleTab: textStyleTab),
                      ],
                    ),
                  ],
                ),
              ),
        
            ],
          ),
    );
  }

  void _onAccept(AudiosProvider ap, Audio audio, DurationModel dm, RecordService rs, int ind, bool firstPlay) { 
     
    if( !ap.dragContaintAudio(ind) ){
      
      setState(() {
        ap.addAudioInDrag(audio, ind);
        audio.player.setVolume(1);

        if(firstPlay) {
          ap.playAll();
          dm.soundDuration = audio.player.duration!;
          audio.player.createPositionStream().listen((event) {dm.currentSheets = event;});
          firstPlay = false;
        }

        rs.addPoint(dm.current, audio);
      });

    }
  }


}

class _ImageDisable extends StatelessWidget {
  const _ImageDisable({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage(path),height: 50);
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



