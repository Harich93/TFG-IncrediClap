import 'package:flutter/material.dart';
import 'package:incredibclap/models/audio_model.dart';
import 'package:incredibclap/providers/audio_provider.dart';
import 'package:incredibclap/widgets/home/home_background.dart';
import 'package:provider/provider.dart';

class MusicSheets extends StatelessWidget {
  const MusicSheets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final ap = Provider.of<AudiosProvider>(context);
    final sheets = createListSheets(ap.dragAudio);

    return SizedBox(
      height: size.height * .4, 
      child: HomeBackground(
        child: Center(
          child: ListView.builder(
            itemCount: sheets.length,
            itemBuilder: ( BuildContext context, int ind ) => Image(image: AssetImage(sheets[ind].musicSheet))
          )
        ),
      ),
    );

        
  }

  List<Audio> createListSheets( List<dynamic> list ) {
    List<Audio> sheets = List.empty(growable: true);
    for (var item in list) {
      if( item != false){
        sheets.add(item);
      }
    }
    print(sheets);
    return sheets;
  }

}