import 'package:flutter/material.dart';
import 'package:incredibclap/controller/audios_controller.dart';
import 'package:incredibclap/models/models.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DragCustom extends StatefulWidget{

  int dragIndx;
  Audio audio;

  DragCustom(
    this.dragIndx, 
    this.audio,
    {Key? key}
  ) : super(key: key);

  
  @override
  _DragCustomState createState() => _DragCustomState();
}

class _DragCustomState extends State<DragCustom> {


  @override
  Widget build(BuildContext context) {

    final ac = Provider.of<AudiosController>(context);
    final audio = widget.audio;
    final player = widget.audio.player;
    // Provider audioCon
    // final int i = audio;


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
                  // audio.setDragAudio(widget.dragIndx, 0);
                  // audio.setIconDrag(widget.dragIndx,0);
                  // audio.removeAudioOn(audio.audios[i].id);
                })
              ),
              IconButton(
                splashRadius: 20,
                icon: player.volume > 0 ? iconMuteOn : iconMuteOff,
                onPressed: () => setState(() {
                  player.volume == 0
                    ? player.setVolume(1)
                    : player.setVolume(0);        
                }),
              )
            ],
          ),

          _IconSoundBox(
            visual:  ac.playNow.contains(player) ? Text(audio.id.toString()): Text( audio.icon )
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