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
    required this.dragIndx
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

    final size = MediaQuery.of(context).size;


    dynamic item = ap.dragAudio[widget.dragIndx];
    Audio audio = item.runtimeType == Audio ? item : Audio();
    final player = audio.player;

    const iconMuteOn = Icon( Icons.volume_up, color: Colors.black );
    const iconMuteOff = Icon( Icons.volume_off, color: Colors.grey );

    return SizedBox(
      height: size.width * 0.25,
      width: size.width * 0.25,
      child: Column(
        children: [
          Row( 
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _DeleteIcon(
                onPressed: ap.dragAudio[widget.dragIndx].id != -1 ? () => setState(() {
                  player.setVolume(0); 
                  ap.removeAudioInDrag(audio);
                  rs.addPoint(dm.current, audio);
                }) : null
              ),
              IconButton(
                disabledColor: ThemeColors.dark,
                iconSize: 20,
                splashRadius: 10,
                icon: player.volume != 1 ? iconMuteOff : iconMuteOn,
                onPressed: ap.dragAudio[widget.dragIndx].id != -1 ? () => setState(() {
                  player.volume == 0
                    ? player.setVolume(1)
                    : player.setVolume(0);        
                  rs.addPoint(dm.current, audio);
                }) : null,
              )
            ],
          ),

          _IconSoundBox(
            visual: ap.dragContaintAudio(widget.dragIndx) ? Image(image: AssetImage(audio.icon)) : const Icon(Icons.music_note_rounded),
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

    final size = MediaQuery.of(context).size;

    
    return Container(
      height: size.height*.05,
      width: size.width*.12,
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
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      disabledColor: ThemeColors.dark,
      iconSize: 20,
      splashRadius: 10,
      onPressed: onPressed != null ? () => onPressed!() : null, 
      icon: const Icon( Icons.clear, color: Colors.red,)
    );
  }
}