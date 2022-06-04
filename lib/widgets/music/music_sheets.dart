import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/providers/providers.dart';
import 'package:incredibclap/themes/colors.dart';

class MusicSheets extends StatelessWidget{
  const MusicSheets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final ap = Provider.of<AudiosProvider>(context);
    final sheets = createListSheets(ap.nowPlaying);

    return SizedBox(
      height: size.height * .55,
      child: Container(
        color: ThemeColors.backgroundSheets,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text('Partitura', style: GoogleFonts.righteous(
                    textStyle: const TextStyle(
                      color: ThemeColors.darkPrimary,
                      fontSize: 30
                    )
                  )),
                ),
              ],
            ),
            ListView.builder(
              padding: const EdgeInsets.only(top: 80),
              itemCount: sheets.length,
              itemBuilder: ( BuildContext context, int idx ) => SizedBox(
                width: 600,
                  child: Image(
                    image: AssetImage(sheets[idx].musicSheet,),
                    repeat: ImageRepeat.noRepeat,
                    alignment: Alignment.centerLeft,
                    height: 40,
                    fit: sheets[idx].musicSheet == "assets/sheets/7.jpg" ? BoxFit.cover : BoxFit.contain,
                  ),
              ),
            ),
          ],
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
