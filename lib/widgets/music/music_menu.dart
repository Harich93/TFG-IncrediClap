import 'package:flutter/material.dart';
import 'package:incredibclap/models/audio_model.dart';
import 'package:incredibclap/models/duration_model.dart';
import 'package:incredibclap/providers/audio_provider.dart';
import 'package:incredibclap/services/services.dart';
import 'package:incredibclap/widgets/music/music_widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class MusicButton {

  final Function onPress;
  final IconData icon;
  final String text;

  MusicButton({
    required this.onPress, 
    required this.icon,
    required this.text
  });
}

class MusicMenu extends StatelessWidget {

  final bool hidden;
  const MusicMenu({Key? key,  this.hidden = false }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final rs = Provider.of<RecordService>(context);
    final ap = Provider.of<AudiosProvider>(context);
    final dm = Provider.of<DurationModel>(context);
    String nameRecord = "Pista";



    // Alert confirmacion de guardado
    Future<void> _showMyDialog() async { 
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Guardar grabación'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const[
                  Text('¿Desea guardar la grabación?'),
                  SizedBox(height: 20),
                  // TextFormField(
                  //   autocorrect: false,
                  //   keyboardType: TextInputType.name,
                  //   decoration: InputDecorations.authInput(
                  //     hintText: 'Pista',
                  //     labelText: 'Pista',
                  //     prefixIcon: Icons.music_note_outlined
                  //   ),
                  //   onChanged: ( value ) => nameRecord = value,
                  // )
                ],
              ),
            ),
            actions: <Widget>[
              
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),

              TextButton(
                child: const Text('Si'),
                onPressed: () {

                  //TODO: Agregar duracion del guardado
                  rs.addAudio();
                  Navigator.of(context).pop();
                },
              ),

              
            ]
          );
        },
      );
    }

  
    final Audio audio = ap.audios[0];
    var zeroDuration = const Duration(hours: 0, minutes: 0, seconds: 0, milliseconds: 0);
    Duration durationless = const Duration();

    final List<MusicButton> items = [
      MusicButton(icon: Icons.radio_button_checked_rounded, text: rs.isRecord ? "Guardar" : "Grabar", onPress: () => { 
        
        rs.isRecord = !rs.isRecord,

        if( rs.isRecord ) {
          for (var audio in  ap.dragAudio ) {
            if(audio.id != -1)  
              rs.addPoint( dm.current, audio ) 
          },

           if(!dm.playing) {

            audio.player.createPositionStream().listen( (event) {
              
              dm.soundDuration = audio.player.duration!;

              if( dm.playing ) { 
                if( durationless.inSeconds != 0 || durationless.inMilliseconds != 0 ) {
                  dm.current = event + durationless;
                }
              }
              
              else { 
                durationless = zeroDuration - event; 
                dm.current = zeroDuration; 
              }
              
            }),

            dm.playing = true,
          }


        }
        else {

          _showMyDialog(),
          dm.playing = false
        }
        


      }),
      MusicButton(icon: Icons.music_note, text: "Partitura",onPress: () => showMaterialModalBottomSheet(
        context: context,
        builder: (context) => const MusicSheets(),
      )),
    ];

    return ChangeNotifierProvider(
      create: ( _ ) => _MenuModel(),
      child: _MusicMenuBackground( 
        child: _MenuItems( items )
      ),
    );
  }

  



}

class _MusicMenuBackground extends StatelessWidget {
  
  final Widget child;

  const _MusicMenuBackground({ required this.child });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( vertical: 5),
      width: 300,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 20,
            offset: Offset(1,1),
            color: Colors.black12
          )
        ]
      ),
      child: child,
    );
  }
}

class _MenuItems extends StatelessWidget {
  
  final List<MusicButton> menuItems;

  const _MenuItems( this.menuItems );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(menuItems.length, ( i ) => _MusicMenuButton( i, menuItems[i] ) ),
    );
  }
}

class _MusicMenuButton extends StatelessWidget{

  final int index;
  final MusicButton item;

  const _MusicMenuButton( this.index, this.item );
  
  @override
  Widget build(BuildContext context) {

    final model = Provider.of<_MenuModel>(context);
    final rs = Provider.of<RecordService>(context);


    return GestureDetector(
      child: Column(
        children: [
          Icon( 
            item.icon, 
            size: model.selectedIndex == index ? 25 : 25 , 
            color: 0 == index && rs.isRecord ? Colors.pink : Colors.black54 
          ),
          Text(item.text)
        ],
      ),
      behavior: HitTestBehavior.translucent,
      onTap: () => {  
        model.selectedIndex = index,
        item.onPress()
      },
    );
  }
}

class _MenuModel with ChangeNotifier{

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;
  set selectedIndex( int value ) {
    _selectedIndex = value;
    notifyListeners();
  }

}