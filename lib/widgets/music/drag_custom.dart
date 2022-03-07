import 'package:flutter/material.dart';
import 'package:incredibclap/services/record_service.dart';
import 'package:incredibclap/themes/colors.dart';
import 'package:provider/provider.dart';

import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/providers/audio_provider.dart';

// ignore: must_be_immutable
class DragCustom extends StatefulWidget{

  int dragIndx;

  DragCustom({
    Key? key,
    required this.dragIndx, 
  }) : super(key: key);

  
  @override
  _DragCustomState createState() => _DragCustomState();
}

class _DragCustomState extends State<DragCustom> {


  @override
  Widget build(BuildContext context) {

    final ap = Provider.of<AudiosProvider>(context);
    final rs = Provider.of<RecordService>(context);
    final dm = Provider.of<DurationModel>(context);


    dynamic item = ap.dragAudio[widget.dragIndx];
    Audio audio = item.runtimeType == Audio ? item : Audio();
    final player = audio.player;

    const iconMuteOn = Icon( Icons.volume_up, color: Colors.black );
    const iconMuteOff = Icon( Icons.volume_off, color: Colors.grey );

    return SizedBox(
      height: 100.0,
      width: 100.0,
      child: Column(
        children: [
          Row( 
            children: [
              _DeleteIcon(
                onPressed: () => setState(() {
                  player.setVolume(0); 
                  ap.removeAudioInDrag(audio);
                  rs.addPoint(dm.current, audio);
                })
              ),
              IconButton(
                splashRadius: 20,
                icon: player.volume != 1 ? iconMuteOff : iconMuteOn,
                onPressed: () => setState(() {
                  player.volume == 0
                    ? player.setVolume(1)
                    : player.setVolume(0);        
                  rs.addPoint(dm.current, audio);
                }),
              )
            ],
          ),

          _IconSoundBox(
            visual:  ap.dragContaintAudio(widget.dragIndx) ? Text(audio.icon) : const Icon(Icons.bubble_chart),
            activo: ap.dragContaintAudio(widget.dragIndx),
          )
        ],
      ),
    );
  }

}

class _IconSoundBox extends StatelessWidget {
  const _IconSoundBox({
    Key? key, 
    required this.visual,
    required this.activo
  }) : super(key: key);

  final Widget visual;
  final bool activo;

  @override
  Widget build(BuildContext context) {

    
    return Container(
      height: 50,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: !activo ? Colors.black12 : ThemeColors.primary
      ),
      child:  Center(child: visual)
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